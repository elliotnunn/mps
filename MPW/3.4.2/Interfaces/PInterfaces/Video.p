{
 	File:		Video.p
 
 	Contains:	Video Driver Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Video;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VIDEO__}
{$SETC __VIDEO__ := 1}

{$I+}
{$SETC VideoIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	mBaseOffset					= 1;							{Id of mBaseOffset.}
	mRowBytes					= 2;							{Video sResource parameter Id's }
	mBounds						= 3;							{Video sResource parameter Id's }
	mVersion					= 4;							{Video sResource parameter Id's }
	mHRes						= 5;							{Video sResource parameter Id's }
	mVRes						= 6;							{Video sResource parameter Id's }
	mPixelType					= 7;							{Video sResource parameter Id's }
	mPixelSize					= 8;							{Video sResource parameter Id's }
	mCmpCount					= 9;							{Video sResource parameter Id's }
	mCmpSize					= 10;							{Video sResource parameter Id's }
	mPlaneBytes					= 11;							{Video sResource parameter Id's }
	mVertRefRate				= 14;							{Video sResource parameter Id's }
	mVidParams					= 1;							{Video parameter block id.}
	mTable						= 2;							{Offset to the table.}
	mPageCnt					= 3;							{Number of pages}
	mDevType					= 4;							{Device Type}
	oneBitMode					= 128;							{Id of OneBitMode Parameter list.}
	twoBitMode					= 129;							{Id of TwoBitMode Parameter list.}
	fourBitMode					= 130;							{Id of FourBitMode Parameter list.}
	eightBitMode				= 131;							{Id of EightBitMode Parameter list.}

	sixteenBitMode				= 132;							{Id of SixteenBitMode Parameter list.}
	thirtyTwoBitMode			= 133;							{Id of ThirtyTwoBitMode Parameter list.}
	firstVidMode				= 128;							{The new, better way to do the above. }
	secondVidMode				= 129;							{ QuickDraw only supports six video }
	thirdVidMode				= 130;							{ at this time.      }
	fourthVidMode				= 131;
	fifthVidMode				= 132;
	sixthVidMode				= 133;
	spGammaDir					= 64;
	spVidNamesDir				= 65;

{ csTimingFormat values in VDTimingInfo }
{ look in the declaration rom for timing info }
	kDeclROMtables				= 'decl';

{ Timing mode constants for Display Manager MultiMode support
	Corresponding	.h equates are in Video.h
					.a equates are in Video.a
					.r equates are in DepVideoEqu.r
	
	The first enum is the old names (for compatibility).
	The second enum is the new names.
}
	timingApple12				= 130;							{  512x384 (60 Hz) Rubik timing.}
	timingApple12x				= 135;							{  560x384 (60 Hz) Rubik-560 timing.}
	timingApple13				= 140;							{  640x480 (67 Hz) HR timing.}
	timingApple13x				= 145;							{  640x400 (67 Hz) HR-400 timing.}
	timingAppleVGA				= 150;							{  640x480  (60 Hz) VGA timing.}
	timingApple15				= 160;							{  640x870 (75 Hz) FPD timing.}
	timingApple15x				= 165;							{  640x818 (75 Hz) FPD-818 timing.}
	timingApple16				= 170;							{  832x624 (75 Hz) GoldFish timing.}
	timingAppleSVGA				= 180;							{  800x600  (56 Hz) SVGA timing.}
	timingApple1Ka				= 190;							{ 1024x768 (60 Hz) VESA 1K-60Hz timing.}
	timingApple1Kb				= 200;							{ 1024x768 (70 Hz) VESA 1K-70Hz timing.}
	timingApple19				= 210;							{ 1024x768  (75 Hz) Apple 19" RGB.}
	timingApple21				= 220;							{ 1152x870  (75 Hz) Apple 21" RGB.}

	timingInvalid				= 0;							{ Unknown timing… force user to confirm.}
	timingApple_512x384_60hz	= 130;							{  512x384  (60 Hz) Rubik timing.}
	timingApple_560x384_60hz	= 135;							{  560x384  (60 Hz) Rubik-560 timing.}
	timingApple_640x480_67hz	= 140;							{  640x480  (67 Hz) HR timing.}
	timingApple_640x400_67hz	= 145;							{  640x400  (67 Hz) HR-400 timing.}
	timingVESA_640x480_60hz		= 150;							{  640x480  (60 Hz) VGA timing.}
	timingApple_640x870_75hz	= 160;							{  640x870  (75 Hz) FPD timing.}
	timingApple_640x818_75hz	= 165;							{  640x818  (75 Hz) FPD-818 timing.}
	timingApple_832x624_75hz	= 170;							{  832x624  (75 Hz) GoldFish timing.}
	timingVESA_800x600_56hz		= 180;							{  800x600  (56 Hz) SVGA timing.}
	timingVESA_800x600_60hz		= 182;							{  800x600  (60 Hz) SVGA timing.}
	timingVESA_800x600_72hz		= 184;							{  800x600  (72 Hz) SVGA timing.}
	timingVESA_800x600_75hz		= 186;							{  800x600  (75 Hz) SVGA timing.}
	timingVESA_1024x768_60hz	= 190;							{ 1024x768  (60 Hz) VESA 1K-60Hz timing.}
	timingVESA_1024x768_70hz	= 200;							{ 1024x768  (70 Hz) VESA 1K-70Hz timing.}
	timingVESA_1024x768_75hz	= 204;							{ 1024x768  (75 Hz) VESA 1K-70Hz timing (very similar to timingApple_1024x768_75hz).}
	timingApple_1024x768_75hz	= 210;							{ 1024x768  (75 Hz) Apple 19" RGB.}
	timingApple_1152x870_75hz	= 220;							{ 1152x870  (75 Hz) Apple 21" RGB.}
	timingAppleNTSC_ST			= 230;							{  512x384  (60 Hz, interlaced, non-convolved).}
	timingAppleNTSC_FF			= 232;							{  640x480  (60 Hz, interlaced, non-convolved).}
	timingAppleNTSC_STconv		= 234;							{  512x384  (60 Hz, interlaced, convolved).}
	timingAppleNTSC_FFconv		= 236;							{  640x480  (60 Hz, interlaced, convolved).}
	timingApplePAL_ST			= 238;							{  640x480  (50 Hz, interlaced, non-convolved).}
	timingApplePAL_FF			= 240;							{  768x576  (50 Hz, interlaced, non-convolved).}
	timingApplePAL_STconv		= 242;							{  640x480  (50 Hz, interlaced, convolved).}
	timingApplePAL_FFconv		= 244;							{  768x576  (50 Hz, interlaced, convolved).}
	timingVESA_1280x960_75hz	= 250;							{ 1280x960  (75 Hz)}
	timingVESA_1280x1024_60hz	= 260;							{ 1280x1024 (60 Hz)}
	timingVESA_1280x1024_75hz	= 262;							{ 1280x1024 (75 Hz)}
	timingVESA_1600x1200_60hz	= 280;							{ 1600x1200 (60 Hz) VESA proposed timing.}
	timingVESA_1600x1200_65hz	= 282;							{ 1600x1200 (65 Hz) VESA proposed timing.}
	timingVESA_1600x1200_70hz	= 284;							{ 1600x1200 (70 Hz) VESA proposed timing.}
	timingVESA_1600x1200_75hz	= 286;							{ 1600x1200 (75 Hz) VESA proposed timing.}
	timingVESA_1600x1200_80hz	= 288;							{ 1600x1200 (80 Hz) VESA proposed timing (pixel clock is 216 Mhz dot clock).}

{ csConnectFlags values in VDDisplayConnectInfo }
	kAllModesValid				= 0;							{ All modes not trimmed by primary init are good close enough to try }
	kAllModesSafe				= 1;							{ All modes not trimmed by primary init are know to be safe }
	kReportsTagging				= 2;							{ Can detect tagged displays (to identify smart monitors) }
	kHasDirectConnection		= 3;							{ True implies that driver can talk directly to device (e.g. serial data link via sense lines) }
	kIsMonoDev					= 4;							{ Says whether there’s an RGB (0) or Monochrome (1) connection. }
	kUncertainConnection		= 5;							{ There may not be a display (no sense lines?). }
	kTaggingInfoNonStandard		= 6;							{ Set when csConnectTaggedType/csConnectTaggedData are non-standard (i.e., not the Apple CRT sense codes). }
	kReportsDDCConnection		= 7;							{ Card can do ddc (set kHasDirectConnect && kHasDDCConnect if you actually found a ddc display). }
	kHasDDCConnection			= 8;							{ Card has ddc connect now. }

{ csDisplayType values in VDDisplayConnectInfo }
	kUnknownConnect				= 1;							{ Not sure how we’ll use this, but seems like a good idea. }
	kPanelConnect				= 2;							{ For use with fixed-in-place LCD panels. }
	kPanelTFTConnect			= 2;							{ Alias for kPanelConnect }
	kFixedModeCRTConnect		= 3;							{  For use with fixed-mode (i.e., very limited range) displays. }
	kMultiModeCRT1Connect		= 4;							{ 320x200 maybe, 12" maybe, 13" (default), 16" certain, 19" maybe, 21" maybe }
	kMultiModeCRT2Connect		= 5;							{ 320x200 maybe, 12" maybe, 13" certain, 16" (default), 19" certain, 21" maybe }
	kMultiModeCRT3Connect		= 6;							{ 320x200 maybe, 12" maybe, 13" certain, 16" certain, 19" default, 21" certain }
	kMultiModeCRT4Connect		= 7;							{ Expansion to large multi mode (not yet used) }
	kModelessConnect			= 8;							{ Expansion to modeless model (not yet used) }
	kFullPageConnect			= 9;							{ 640x818 (to get 8bpp in 512K case) and 640x870 (these two only) }
	kVGAConnect					= 10;							{ 640x480 VGA default -- question everything else }
	kNTSCConnect				= 11;							{ NTSC ST (default), FF, STconv, FFconv }
	kPALConnect					= 12;							{ PAL ST (default), FF, STconv, FFconv }
	kHRConnect					= 13;							{ Straight-6 connect -- 640x480 and 640x400 (to get 8bpp in 256K case) (these two only) }
	kPanelFSTNConnect			= 14;							{ For use with fixed-in-place LCD FSTN (aka “Supertwist”) panels }
	kMonoTwoPageConnect			= 15;							{ 1152x870 Apple color two-page display }
	kColorTwoPageConnect		= 16;							{ 1152x870 Apple B&W two-page display }
	kColor16Connect				= 17;							{ 832x624 Apple B&W two-page display }
	kColor19Connect				= 18;							{ 1024x768 Apple B&W two-page display }

{ csTimingFlags values in VDTimingInfoRec }
	kModeValid					= 0;							{ Says that this mode should NOT be trimmed. }
	kModeSafe					= 1;							{ This mode does not need confirmation }
	kModeDefault				= 2;							{ This is the default mode for this type of connection }
	kModeShowNow				= 3;							{ This mode should always be shown (even though it may require a confirm) }
	kModeNotResize				= 4;							{ This mode should not be used to resize the display (eg. mode selects a different connector on card) }
	kModeRequiresPan			= 5;							{ This mode has more pixels than are actually displayed }

{ csResolutionFlags bit flags for VDResolutionInfoRec }
	kResolutionHasMultipleDepthSizes = 0;						{ Says that this mode has different csHorizontalPixels, csVerticalLines at different depths (usually slightly larger at lower depths) }

{	Power Mode constants for VDPowerStateRec.powerState.	}
	kAVPowerOff					= 0;
	kAVPowerStandby				= 1;
	kAVPowerSuspend				= 2;
	kAVPowerOn					= 3;

{	Power Mode masks and bits for VDPowerStateRec.powerFlags.	}
	kPowerStateNeedsRefresh		= 0;
	kPowerStateNeedsRefreshMask	= 0+(1 * (2**(0)));

{ Control Codes }
	cscReset					= 0;
	cscKillIO					= 1;
	cscSetMode					= 2;
	cscSetEntries				= 3;
	cscSetGamma					= 4;
	cscGrayPage					= 5;
	cscGrayScreen				= 5;
	cscSetGray					= 6;
	cscSetInterrupt				= 7;
	cscDirectSetEntries			= 8;
	cscSetDefaultMode			= 9;
	cscSwitchMode				= 10;
	cscSetSync					= 11;
	cscUnusedCall				= 127;							{ This call used to expend the scrn resource.  Its imbedded data contains more control info }

{ Status Codes }
	cscGetMode					= 2;
	cscGetEntries				= 3;
	cscGetPageCnt				= 4;
	cscGetPages					= 4;							{ This is what C&D 2 calls it. }
	cscGetPageBase				= 5;
	cscGetBaseAddr				= 5;							{ This is what C&D 2 calls it. }
	cscGetGray					= 6;
	cscGetInterrupt				= 7;
	cscGetGamma					= 8;
	cscGetDefaultMode			= 9;
	cscGetCurMode				= 10;
	cscGetSync					= 11;
	cscGetConnection			= 12;							{ Return information about the connection to the display }
	cscGetModeTiming			= 13;							{ Return timing info for a mode }
	cscGetModeBaseAddress		= 14;							{ Return base address information about a particular mode }
	cscGetScanProc				= 15;							{ QuickTime scan chasing routine }
	cscSavePreferredConfiguration = 16;
	cscSetHardwareCursor		= 22;
	cscDrawHardwareCursor		= 23;
	cscSetConvolution			= 24;
	cscSetPowerState			= 25;
	cscPrivateControlCall		= 26;							{  Takes a VDPrivateSelectorDataRec }
	cscSetMultiConnect			= 28;							{  From a GDI point of view, this call should be implemented completely in the HAL and not at all in the core. }
	cscSetClutBehavior			= 29;							{  Takes a VDClutBehavior  }

{ Bit definitions for the Get/Set Sync call}
	kDisableHorizontalSyncBit	= 0;
	kDisableVerticalSyncBit		= 1;
	kDisableCompositeSyncBit	= 2;
	kEnableSyncOnBlue			= 3;
	kEnableSyncOnGreen			= 4;
	kEnableSyncOnRed			= 5;
	kNoSeparateSyncControlBit	= 6;
	kHorizontalSyncMask			= $01;
	kVerticalSyncMask			= $02;
	kCompositeSyncMask			= $04;
	kDPMSSyncMask				= $7;
	kSyncOnBlueMask				= $08;
	kSyncOnGreenMask			= $10;
	kSyncOnRedMask				= $20;
	kSyncOnMask					= $38;

{	Power Mode constants for translating DPMS modes to Get/SetSync calls.	}
	kDPMSSyncOn					= 0;
	kDPMSSyncStandby			= 1;
	kDPMSSyncSuspend			= 2;
	kDPMSSyncOff				= 7;

{  Bit definitions for the Get/Set Convolution call }
	kConvolved					= 0;
	kLiveVideoPassThru			= 1;
	kConvolvedMask				= $01;
	kLiveVideoPassThruMask		= $02;

TYPE
	VPBlock = RECORD
		vpBaseOffset:			LONGINT;								{Offset to page zero of video RAM (From minorBaseOS).}
		vpRowBytes:				INTEGER;								{Width of each row of video memory.}
		vpBounds:				Rect;									{BoundsRect for the video display (gives dimensions).}
		vpVersion:				INTEGER;								{PixelMap version number.}
		vpPackType:				INTEGER;
		vpPackSize:				LONGINT;
		vpHRes:					LONGINT;								{Horizontal resolution of the device (pixels per inch).}
		vpVRes:					LONGINT;								{Vertical resolution of the device (pixels per inch).}
		vpPixelType:			INTEGER;								{Defines the pixel type.}
		vpPixelSize:			INTEGER;								{Number of bits in pixel.}
		vpCmpCount:				INTEGER;								{Number of components in pixel.}
		vpCmpSize:				INTEGER;								{Number of bits per component}
		vpPlaneBytes:			LONGINT;								{Offset from one plane to the next.}
	END;

	VPBlockPtr = ^VPBlock;

	VDEntryRecord = RECORD
		csTable:				Ptr;									{(long) pointer to color table entry=value, r,g,b:INTEGER}
	END;

	VDEntRecPtr = ^VDEntryRecord;

{ Parm block for SetGray control call }
	VDGrayRecord = RECORD
		csMode:					BOOLEAN;								{Same as GDDevType value (0=color, 1=mono)}
	END;

	VDGrayPtr = ^VDGrayRecord;

{ Parm block for SetInterrupt call }
	VDFlagRecord = RECORD
		csMode:					SInt8;
	END;

	VDFlagRecPtr = ^VDFlagRecord;

{ Parm block for SetEntries control call }
	VDSetEntryRecord = RECORD
		csTable:				^ColorSpec;								{Pointer to an array of color specs}
		csStart:				INTEGER;								{Which spec in array to start with, or -1}
		csCount:				INTEGER;								{Number of color spec entries to set}
	END;

	VDSetEntryPtr = ^VDSetEntryRecord;

{ Parm block for SetGamma control call }
	VDGammaRecord = RECORD
		csGTable:				Ptr;									{pointer to gamma table}
	END;

	VDGamRecPtr = ^VDGammaRecord;

	VDBaseAddressInfoRec = RECORD
		csDevData:				LONGINT;								{ LONGINT - (long) timing mode }
		csDevBase:				LONGINT;								{ LONGINT - (long) base address of the mode }
		csModeReserved:			INTEGER;								{ INTEGER - (short) will some day be the depth }
		csModeBase:				LONGINT;								{ LONGINT - (long) reserved }
	END;

	VDBaseAddressInfoPtr = ^VDBaseAddressInfoRec;

	VDSwitchInfoRec = RECORD
		csMode:					INTEGER;								{(word) mode depth}
		csData:					LONGINT;								{(long) functional sResource of mode}
		csPage:					INTEGER;								{(word) page to switch in}
		csBaseAddr:				Ptr;									{(long) base address of page (return value)}
		csReserved:				LONGINT;								{(long) Reserved (set to 0) }
	END;

	VDSwitchInfoPtr = ^VDSwitchInfoRec;

	VDTimingInfoRec = RECORD
		csTimingMode:			LONGINT;								{ LONGINT - (long) timing mode (a la InitGDevice) }
		csTimingReserved:		LONGINT;								{ LONGINT - (long) reserved }
		csTimingFormat:			LONGINT;								{ LONGINT - (long) what format is the timing info }
		csTimingData:			LONGINT;								{ LONGINT - (long) data supplied by driver }
		csTimingFlags:			LONGINT;								{ LONGINT - (long) mode within device }
	END;

	VDTimingInfoPtr = ^VDTimingInfoRec;

	VDDisplayConnectInfoRec = RECORD
		csDisplayType:			INTEGER;								{ INTEGER - (word) Type of display connected }
		csConnectTaggedType:	SInt8; (* unsigned char *)				{ BYTE - type of tagging }
		csConnectTaggedData:	SInt8; (* unsigned char *)				{ BYTE - tagging data }
		csConnectFlags:			LONGINT;								{ LONGINT - (long) tell us about the connection }
		csDisplayComponent:		LONGINT;								{ LONGINT - (long) if the card has a direct connection to the display, it returns the display component here (FUTURE) }
		csConnectReserved:		LONGINT;								{ LONGINT - (long) reserved }
	END;

	VDDisplayConnectInfoPtr = ^VDDisplayConnectInfoRec;

{ RawSenseCode
	This abstract data type is not exactly abstract.  Rather, it is merely enumerated constants
	for the possible raw sense code values when 'standard' sense code hardware is implemented.

	For 'standard' sense code hardware, the raw sense is obtained as follows:
		• Instruct the frame buffer controller NOT to actively drive any of the monitor sense lines
		• Read the state of the monitor sense lines 2, 1, and 0.  (2 is the MSB, 0 the LSB)

	IMPORTANT Note: 
	When the 'kTaggingInfoNonStandard' bit of 'csConnectFlags' is FALSE, then these constants 
	are valid 'csConnectTaggedType' values in 'VDDisplayConnectInfo' 

}
	RawSenseCode = CHAR;


CONST
	kRSCZero					= 0;
	kRSCOne						= 1;
	kRSCTwo						= 2;
	kRSCThree					= 3;
	kRSCFour					= 4;
	kRSCFive					= 5;
	kRSCSix						= 6;
	kRSCSeven					= 7;

{ ExtendedSenseCode
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

}
	
TYPE
	ExtendedSenseCode = CHAR;


CONST
	kESCZero21Inch				= $00;							{ 21" RGB 								}
	kESCOnePortraitMono			= $14;							{ Portrait Monochrome 					}
	kESCTwo12Inch				= $21;							{ 12" RGB								}
	kESCThree21InchRadius		= $31;							{ 21" RGB (Radius)						}
	kESCThree21InchMonoRadius	= $34;							{ 21" Monochrome (Radius) 				}
	kESCThree21InchMono			= $35;							{ 21" Monochrome						}
	kESCFourNTSC				= $0A;							{ NTSC 								}
	kESCFivePortrait			= $1E;							{ Portrait RGB 						}
	kESCSixMSB1					= $03;							{ MultiScan Band-1 (12" thru 1Six")	}
	kESCSixMSB2					= $0B;							{ MultiScan Band-2 (13" thru 19")		}
	kESCSixMSB3					= $23;							{ MultiScan Band-3 (13" thru 21")		}
	kESCSixStandard				= $2B;							{ 13"/14" RGB or 12" Monochrome		}
	kESCSevenPAL				= $00;							{ PAL									}
	kESCSevenNTSC				= $14;							{ NTSC 								}
	kESCSevenVGA				= $17;							{ VGA 									}
	kESCSeven16Inch				= $2D;							{ 16" RGB (GoldFish) 				 	}
	kESCSevenPALAlternate		= $30;							{ PAL (Alternate) 						}
	kESCSeven19Inch				= $3A;							{ Third-Party 19”						}
	kESCSevenNoDisplay			= $3F;							{ No display connected 				}

{ DepthMode
	This abstract data type is used to to reference RELATIVE pixel depths.
	Its definition is largely derived from its past usage, analogous to 'xxxVidMode'

	Bits per pixel DOES NOT directly map to 'DepthMode'  For example, on some
	graphics hardware, 'kDepthMode1' may represent 1 BPP, whereas on other
	hardware, 'kDepthMode1' may represent 8BPP.

	DepthMode IS considered to be ordinal, i.e., operations such as <, >, ==, etc.
	behave as expected.  The values of the constants which comprise the set are such
	that 'kDepthMode4 < kDepthMode6' behaves as expected.
}
	
TYPE
	DepthMode = INTEGER;


CONST
	kDepthMode1					= 128;
	kDepthMode2					= 129;
	kDepthMode3					= 130;
	kDepthMode4					= 131;
	kDepthMode5					= 132;
	kDepthMode6					= 133;

	kFirstDepthMode				= 128;							{ These constants are obsolete, and just included	}
	kSecondDepthMode			= 129;							{ for clients that have converted to the above		}
	kThirdDepthMode				= 130;							{ kDepthModeXXX constants.							}
	kFourthDepthMode			= 131;
	kFifthDepthMode				= 132;
	kSixthDepthMode				= 133;


TYPE
	VDPageInfo = RECORD
		csMode:					INTEGER;								{(word) mode within device}
		csData:					LONGINT;								{(long) data supplied by driver}
		csPage:					INTEGER;								{(word) page to switch in}
		csBaseAddr:				Ptr;									{(long) base address of page}
	END;

	VDPgInfoPtr = ^VDPageInfo;

	VDSizeInfo = RECORD
		csHSize:				INTEGER;								{(word) desired/returned h size}
		csHPos:					INTEGER;								{(word) desired/returned h position}
		csVSize:				INTEGER;								{(word) desired/returned v size}
		csVPos:					INTEGER;								{(word) desired/returned v position}
	END;

	VDSzInfoPtr = ^VDSizeInfo;

	VDSettings = RECORD
		csParamCnt:				INTEGER;								{(word) number of params}
		csBrightMax:			INTEGER;								{(word) max brightness}
		csBrightDef:			INTEGER;								{(word) default brightness}
		csBrightVal:			INTEGER;								{(word) current brightness}
		csCntrstMax:			INTEGER;								{(word) max contrast}
		csCntrstDef:			INTEGER;								{(word) default contrast}
		csCntrstVal:			INTEGER;								{(word) current contrast}
		csTintMax:				INTEGER;								{(word) max tint}
		csTintDef:				INTEGER;								{(word) default tint}
		csTintVal:				INTEGER;								{(word) current tint}
		csHueMax:				INTEGER;								{(word) max hue}
		csHueDef:				INTEGER;								{(word) default hue}
		csHueVal:				INTEGER;								{(word) current hue}
		csHorizDef:				INTEGER;								{(word) default horizontal}
		csHorizVal:				INTEGER;								{(word) current horizontal}
		csHorizMax:				INTEGER;								{(word) max horizontal}
		csVertDef:				INTEGER;								{(word) default vertical}
		csVertVal:				INTEGER;								{(word) current vertical}
		csVertMax:				INTEGER;								{(word) max vertical}
	END;

	VDSettingsPtr = ^VDSettings;

	VDDefMode = RECORD
		csID:					SInt8; (* UInt8 *)
	END;

	VDDefModePtr = ^VDDefMode;

	VDSyncInfoRec = RECORD
		csMode:					SInt8; (* UInt8 *)
		csFlags:				SInt8; (* UInt8 *)
	END;

	VDSyncInfoPtr = ^VDSyncInfoRec;

	DisplayModeID						= LONGINT;
	VideoDeviceType						= LONGINT;
	GammaTableID						= LONGINT;
{  Constants for the GetNextResolution call  }

CONST
	kDisplayModeIDCurrent		= $00;							{  Reference the Current DisplayModeID  }
	kDisplayModeIDInvalid		= $FFFFFFFF;					{  A bogus DisplayModeID in all cases  }
	kDisplayModeIDFindFirstResolution = $FFFFFFFE;				{  Used in cscGetNextResolution to reset iterator  }
	kDisplayModeIDNoMoreResolutions = $FFFFFFFD;				{  Used in cscGetNextResolution to indicate End Of List  }

{  Constants for the GetGammaInfoList call  }
	kGammaTableIDFindFirst		= $FFFFFFFE;					{  Get the first gamma table ID  }
	kGammaTableIDNoMoreTables	= $FFFFFFFD;					{  Used to indicate end of list  }
	kGammaTableIDSpecific		= $00;							{  Return the info for the given table id  }


TYPE
	VDResolutionInfoRecPtr = ^VDResolutionInfoRec;
	VDResolutionInfoRec = RECORD
		csPreviousDisplayModeID: DisplayModeID;							{  ID of the previous resolution in a chain  }
		csDisplayModeID:		DisplayModeID;							{  ID of the next resolution  }
		csHorizontalPixels:		LONGINT;								{  # of pixels in a horizontal line at the max depth  }
		csVerticalLines:		LONGINT;								{  # of lines in a screen at the max depth  }
		csRefreshRate:			Fixed;									{  Vertical Refresh Rate in Hz  }
		csMaxDepthMode:			DepthMode;								{  0x80-based number representing max bit depth  }
		csResolutionFlags:		LONGINT;								{  Reserved - flag bits  }
		csReserved:				LONGINT;								{  Reserved  }
	END;

	VDResolutionInfoPtr					= ^VDResolutionInfoRec;
	VDVideoParametersInfoRecPtr = ^VDVideoParametersInfoRec;
	VDVideoParametersInfoRec = RECORD
		csDisplayModeID:		DisplayModeID;							{  the ID of the resolution we want info on  }
		csDepthMode:			DepthMode;								{  The bit depth we want the info on (0x80 based)  }
		csVPBlockPtr:			VPBlockPtr;								{  Pointer to a video parameter block  }
		csPageCount:			LONGINT;								{  Number of pages supported by the resolution  }
		csDeviceType:			VideoDeviceType;						{  Device Type:  Direct, Fixed or CLUT;  }
		csReserved:				LONGINT;								{  Reserved  }
	END;

	VDVideoParametersInfoPtr			= ^VDVideoParametersInfoRec;
	VDGammaInfoRecPtr = ^VDGammaInfoRec;
	VDGammaInfoRec = RECORD
		csLastGammaID:			GammaTableID;							{  the ID of the previous gamma table  }
		csNextGammaID:			GammaTableID;							{  the ID of the next gamma table  }
		csGammaPtr:				Ptr;									{  Ptr to a gamma table data  }
		csReserved:				LONGINT;								{  Reserved  }
	END;

	VDGammaInfoPtr						= ^VDGammaInfoRec;
	VDGetGammaListRecPtr = ^VDGetGammaListRec;
	VDGetGammaListRec = RECORD
		csPreviousGammaTableID:	GammaTableID;							{  ID of the previous gamma table  }
		csGammaTableID:			GammaTableID;							{  ID of the gamma table following csPreviousDisplayModeID  }
		csGammaTableSize:		LONGINT;								{  Size of the gamma table in bytes  }
		csGammaTableName:		CStringPtr;								{  Gamma table name (c-string)  }
	END;

	VDGetGammaListPtr					= ^VDGetGammaListRec;
	VDRetrieveGammaRecPtr = ^VDRetrieveGammaRec;
	VDRetrieveGammaRec = RECORD
		csGammaTableID:			GammaTableID;							{  ID of gamma table to retrieve  }
		csGammaTablePtr:		GammaTblPtr;							{  Location to copy desired gamma to  }
	END;

	VDRetrieveGammaPtr					= ^VDRetrieveGammaRec;
	VDSetHardwareCursorRecPtr = ^VDSetHardwareCursorRec;
	VDSetHardwareCursorRec = RECORD
		csCursorRef:			Ptr;									{  reference to cursor data  }
		csReserved1:			UInt32;									{  reserved for future use  }
		csReserved2:			UInt32;									{  should be ignored  }
	END;

	VDSetHardwareCursorPtr				= ^VDSetHardwareCursorRec;
	VDDrawHardwareCursorRecPtr = ^VDDrawHardwareCursorRec;
	VDDrawHardwareCursorRec = RECORD
		csCursorX:				SInt32;									{  x coordinate  }
		csCursorY:				SInt32;									{  y coordinate  }
		csCursorVisible:		UInt32;									{  true if cursor is must be visible  }
		csReserved1:			UInt32;									{  reserved for future use  }
		csReserved2:			UInt32;									{  should be ignored  }
	END;

	VDDrawHardwareCursorPtr				= ^VDDrawHardwareCursorRec;
	VDSupportsHardwareCursorRecPtr = ^VDSupportsHardwareCursorRec;
	VDSupportsHardwareCursorRec = RECORD
		csSupportsHardwareCursor: UInt32;
																		{  true if hardware cursor is supported  }
		csReserved1:			UInt32;									{  reserved for future use  }
		csReserved2:			UInt32;									{  must be zero  }
	END;

	VDSupportsHardwareCursorPtr			= ^VDSupportsHardwareCursorRec;
	VDHardwareCursorDrawStateRecPtr = ^VDHardwareCursorDrawStateRec;
	VDHardwareCursorDrawStateRec = RECORD
		csCursorX:				SInt32;									{  x coordinate  }
		csCursorY:				SInt32;									{  y coordinate  }
		csCursorVisible:		UInt32;									{  true if cursor is visible  }
		csCursorSet:			UInt32;									{  true if cursor successfully set by last set control call  }
		csReserved1:			UInt32;									{  reserved for future use  }
		csReserved2:			UInt32;									{  must be zero  }
	END;

	VDHardwareCursorDrawStatePtr		= ^VDHardwareCursorDrawStateRec;
	VDConvolutionInfoRecPtr = ^VDConvolutionInfoRec;
	VDConvolutionInfoRec = RECORD
		csDisplayModeID:		DisplayModeID;							{  the ID of the resolution we want info on  }
		csDepthMode:			DepthMode;								{  The bit depth we want the info on (0x80 based)  }
		csPage:					LONGINT;
		csFlags:				UInt32;
		csReserved:				UInt32;
	END;

	VDConvolutionInfoPtr				= ^VDConvolutionInfoRec;
	VDPowerStateRecPtr = ^VDPowerStateRec;
	VDPowerStateRec = RECORD
		powerState:				LONGINT;
		powerFlags:				LONGINT;
		powerReserved1:			LONGINT;
		powerReserved2:			LONGINT;
	END;

	VDPowerStatePtr						= ^VDPowerStateRec;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := VideoIncludes}

{$ENDC} {__VIDEO__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

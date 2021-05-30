{
     File:       ZoomedVideo.p
 
     Contains:   PC Card Family Zoomed Video Driver Interface
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc.  All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ZoomedVideo;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ZOOMEDVIDEO__}
{$SETC __ZOOMEDVIDEO__ := 1}

{$I+}
{$SETC ZoomedVideoIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DEVICES__}
{$I Devices.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{  Control codes  }


CONST
	cscZVVideoEnable			= 2;							{  Used to enable or disable ZV Video }
	cscZVSetCurrentAnalogValue	= 3;							{  Used to set brightness, contrast, etc. }
	cscZVSetInput				= 9;							{  Set video source to selected input }
	cscZVSetInputStandard		= 11;							{  Set the input to NTSC, PAL, or SECAM }
	cscZVGetMaxSourceRect		= 12;							{  Get Maximum Source Rect }

	{  Status codes }
	cscZVGetVideoEnable			= 2;							{  Indicates whether ZV Video is enabled }
	cscZVGetCurrentAnalogValue	= 3;							{  Used to get brightness, contrast, etc. }
	cscZVGetDefaultAnalogValue	= 4;
	cscZVGetVSyncState			= 5;							{  Used to look for a Vertical Sync on ZV Video }
	cscZVGetInfo				= 6;							{  Returns the ZV Information }
	cscZVGetInputFlags			= 7;							{  Returns the input flags. }
	cscZVGetNumberOfInputs		= 8;							{  Returns the number of video inputs }
	cscZVGetInput				= 9;							{  Zero-based input number }
	cscZVGetInputFormat			= 10;							{  Returns whether input is compsite/s-video }


	{
	  -----------------------------------------------------------------
	   Additional parameters for csInfoZV control call
	    A pointer to ZVInfo is passed in csParam[0] (and csParam[1])
	    which must be filled by the driver in response to this call.
	}


TYPE
	ZVFeatures							= UInt32;

CONST
	kZVHasAudio					= $01;
	kZVHasTVTuner				= $02;
	kZVHasContrast				= $00010000;
	kZVHasBrightness			= $00020000;
	kZVHasSharpness				= $00040000;
	kZVHasSaturation			= $00080000;
	kZVHasHue					= $00100000;



TYPE
	ZVInfoPtr = ^ZVInfo;
	ZVInfo = RECORD
		features:				ZVFeatures;
		currentFlags:			UInt32;
		activeRect:				Rect;
		isInterlaced:			BOOLEAN;
		filler:					SInt8;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	ZVFlagRecordPtr = ^ZVFlagRecord;
	ZVFlagRecord = RECORD
		csFlag:					BOOLEAN;
		filler:					SInt8;
	END;

	{
	  -----------------------------------------------------------------
	   Additional definitions for "AnalogCtlZV" control calls
	    A pointer to a ZVSetAnalogControlParam is passed to the driver
	    whenever the system needs to adjust one of the analog settings.
	}
	ZVAnalogControlSelector				= UInt16;

CONST
	kZVContrast					= 1;							{  Range:  0x0 <= no change to image, larger values increase the contrast }
	kZVBrightness				= 2;							{  Range:  0x0 <= darkest setting, 0xffff = lightest setting }
	kZVSharpness				= 3;							{  Range:  0x0 <= no sharpness filtering, 0xffff <= full sharpness filtering }
	kZVSaturation				= 4;							{  Range:  0x0 <= min saturation, 0xffff <= max saturation        }
	kZVHue						= 5;							{  Range:  0x0 <= -180º shift in hue, 0xffff <= 179º shift, 0x8000 <=0º shift }
	kZVBlackLevel				= 6;							{  Range:  0x0 <= max black, 0xffff <= min black level }
	kZVWhiteLevel				= 7;							{  Range:  0x0 <= min white, 0xffff <= max white level }


TYPE
	ZVAnalogControlRecordPtr = ^ZVAnalogControlRecord;
	ZVAnalogControlRecord = RECORD
		whichControl:			ZVAnalogControlSelector;
		value:					UInt16;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ZoomedVideoIncludes}

{$ENDC} {__ZOOMEDVIDEO__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

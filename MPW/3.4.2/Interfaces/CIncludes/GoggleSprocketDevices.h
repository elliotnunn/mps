/*
********************************************************************************
**
** Name: GoggleSprocketDevices.h
**
** Description:
**
**	Header file for the device-level interface for stereoscopic devices.
**
********************************************************************************
*/
#ifndef GOGGLESPROCKETDEVICES
#define GOGGLESPROCKETDEVICES

#include <Displays.h>
#include <Types.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
********************************************************************************
** constants & data types
********************************************************************************
*/
/* GoggleSprocket file creator type */
#define kGoggleSprocketCreatorType 'GSp '

/* device error codes */
enum {
	kGSpDeviceError_NoMoreModes			= 1,
	kGSpDeviceError_UnsupportedCall		= 2
};
typedef UInt32 gDSpDeviceError;

/* device type */
enum {
	kGSpDeviceKind_Unknown			= 0,
	kGSpDeviceKind_FrameSequential	= 1,	/* i.e. shutter glasses */
	kGSpDeviceKind_Stereoscopic		= 2		/* i.e. hmd */
};
typedef UInt32 GSpDeviceKind;

/* mode data format */
enum {
	kGSpModeDataFormat_Unknown		= 0,
	kGSpModeDataFormat_Normal		= 1,
	kGSpModeDataFormat_Interleaved	= 2
};
typedef UInt32 GSpModeDataFormat;

/* mode attributes */
enum {
	kGSpModeAttribute_CustomProcess				= (1L << 0L),
	kGSpModeAttribute_FullDisplayRequired		= (1L << 1L),
	kGSpModeAttribute_ManualEyeToggleRequired	= (1L << 2L),
	kGSpModeAttribute_RightEyeDataFirst			= (1L << 3L),
	kGSpModeAttribute_PrimeBuffers				= (1L << 4L)
};
typedef UInt32 GSpModeAttributes;

/* mode information */
struct GSpDeviceModeInfo {
	GSpModeDataFormat		format;
	GSpModeAttributes		attributes;
	
	/* non-zero if attached to specific display */
	DisplayIDType			displayID;
	
	/* display requirement ranges are [low,high] inclusive bounds, 0 = don't care */
	UInt32					displayWidthRange[2];
	UInt32					displayHeightRange[2];
	UInt32					displayDepthRange[2];
	
	/* frequencies are Fixed point values */
	Fixed					displayFrequencyRange[2];
};
typedef struct GSpDeviceModeInfo GSpDeviceModeInfo;

/*
********************************************************************************
** calls exported by the stereoscopic device driver
********************************************************************************
*/
/* general */
OSStatus GSpDevice_Open( void );
OSStatus GSpDevice_Close( void );

/* device configuration */
OSStatus GSpDevice_Configure( Point *inUpperLeft );

/* mode iteration */
OSStatus GSpDevice_GetFirstModeInfo( GSpDeviceModeInfo *outFirstModeInfo );
OSStatus GSpDevice_GetNextModeInfo( GSpDeviceModeInfo *inCurrentModeInfo,
			GSpDeviceModeInfo *outNextModeInfo );

/* for manual eye toggle */
OSStatus GSpDevice_SetVisibleEye( Boolean inLeftEyeVisible );
OSStatus GSpDevice_GetVisibleEye( Boolean *outLeftEyeVisible );

/* custom buffer processing by device */
OSStatus GSpDevice_CustomBufferProcess(
			CGrafPtr inLeftEyeBuffer,		/* left eye image				*/
			CGrafPtr inRightEyeBuffer,		/* right eye image				*/
			CGrafPtr inDestBuffer,			/* dest buffer					*/
			Boolean inBuildLeftEyeBuffer,	/* 0 = build right eye image	*/
			CTabHandle ioColorTable,		/* src color table to use		*/
			Boolean *outShowDisplayBuffer,	/* 0 = driver will show output	*/
			Boolean *outCTabChanged );		/* 0 = driver didnt change ctab	*/

#ifdef __cplusplus
}
#endif

#endif /* GOGGLESPROCKETDEVICES */
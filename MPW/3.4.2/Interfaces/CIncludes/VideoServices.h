/*
 	File:		VideoServices.h
 
 	Contains:	Video Services Library Interfaces.
 
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

#ifndef __VIDEOSERVICES__
#define __VIDEOSERVICES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __NAMEREGISTRY__
#include <NameRegistry.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
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
	kTransparentEncoding		= 0,
	kInvertingEncoding
};

enum {
	kTransparentEncodingShift	= (kTransparentEncoding << 1),
	kTransparentEncodedPixel	= (0x01 << kTransparentEncodingShift),
	kInvertingEncodingShift		= (kInvertingEncoding << 1),
	kInvertingEncodedPixel		= (0x01 << kInvertingEncodingShift)
};

enum {
	kHardwareCursorDescriptorMajorVersion = 0x0001,
	kHardwareCursorDescriptorMinorVersion = 0x0000
};

struct HardwareCursorDescriptorRec {
	UInt16							majorVersion;
	UInt16							minorVersion;
	UInt32							height;
	UInt32							width;
	UInt32							bitDepth;
	UInt32							maskBitDepth;
	UInt32							numColors;
	UInt32							*colorEncodings;
	UInt32							flags;
	UInt32							supportedSpecialEncodings;
	UInt32							specialEncodings[16];
};
typedef struct HardwareCursorDescriptorRec HardwareCursorDescriptorRec, *HardwareCursorDescriptorPtr;


enum {
	kHardwareCursorInfoMajorVersion = 0x0001,
	kHardwareCursorInfoMinorVersion = 0x0000
};

struct HardwareCursorInfoRec {
	UInt16							majorVersion;				/* Test tool should check for kHardwareCursorInfoMajorVersion1*/
	UInt16							minorVersion;				/* Test tool should check for kHardwareCursorInfoMinorVersion1*/
	UInt32							cursorHeight;
	UInt32							cursorWidth;
	CTabPtr							colorMap;					/* nil or big enough for hardware's max colors*/
	Ptr								hardwareCursor;
	UInt32							reserved[6];				/* Test tool should check for 0s*/
};
typedef struct HardwareCursorInfoRec HardwareCursorInfoRec, *HardwareCursorInfoPtr;


enum {
	kVBLInterruptServiceType	= 'vbl ',
	kHBLInterruptServiceType	= 'hbl ',
	kFrameInterruptServiceType	= 'fram'
};

typedef ResType InterruptServiceType;

typedef UInt32 InterruptServiceIDType, *InterruptServiceIDPtr;

extern OSErr VSLNewInterruptService(RegEntryIDPtr serviceDevice, InterruptServiceType serviceType, InterruptServiceIDPtr serviceID);
extern OSErr VSLDisposeInterruptService(InterruptServiceIDType serviceID);
extern OSErr VSLDoInterruptService(InterruptServiceIDType serviceID);
extern Boolean VSLPrepareCursorForHardwareCursor(void *cursorRef, HardwareCursorDescriptorPtr hardwareDescriptor, HardwareCursorInfoPtr hwCursorInfo);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __VIDEOSERVICES__ */

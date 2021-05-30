/*
 	File:		QDOffscreen.h
 
 	Contains:	QuickDraw Offscreen GWorld Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __QDOFFSCREEN__
#define __QDOFFSCREEN__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <Types.h>											*/
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
	pixPurgeBit					= 0,
	noNewDeviceBit				= 1,
	useTempMemBit				= 2,
	keepLocalBit				= 3,
	pixelsPurgeableBit			= 6,
	pixelsLockedBit				= 7,
	mapPixBit					= 16,
	newDepthBit					= 17,
	alignPixBit					= 18,
	newRowBytesBit				= 19,
	reallocPixBit				= 20,
	clipPixBit					= 28,
	stretchPixBit				= 29,
	ditherPixBit				= 30,
	gwFlagErrBit				= 31
};

enum {
	pixPurge					= 1L << pixPurgeBit,
	noNewDevice					= 1L << noNewDeviceBit,
	useTempMem					= 1L << useTempMemBit,
	keepLocal					= 1L << keepLocalBit,
	pixelsPurgeable				= 1L << pixelsPurgeableBit,
	pixelsLocked				= 1L << pixelsLockedBit,
	mapPix						= 1L << mapPixBit,
	newDepth					= 1L << newDepthBit,
	alignPix					= 1L << alignPixBit,
	newRowBytes					= 1L << newRowBytesBit,
	reallocPix					= 1L << reallocPixBit,
	clipPix						= 1L << clipPixBit,
	stretchPix					= 1L << stretchPixBit,
	ditherPix					= 1L << ditherPixBit,
	gwFlagErr					= 1L << gwFlagErrBit
};

typedef unsigned long GWorldFlags;

/* Type definition of a GWorldPtr */
typedef CGrafPtr GWorldPtr;

extern pascal QDErr NewGWorld(GWorldPtr *offscreenGWorld, short PixelDepth, const Rect *boundsRect, CTabHandle cTable, GDHandle aGDevice, GWorldFlags flags)
 FOURWORDINLINE(0x203C, 0x0016, 0x0000, 0xAB1D);
extern pascal Boolean LockPixels(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x0001, 0xAB1D);
extern pascal void UnlockPixels(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x0002, 0xAB1D);
extern pascal GWorldFlags UpdateGWorld(GWorldPtr *offscreenGWorld, short pixelDepth, const Rect *boundsRect, CTabHandle cTable, GDHandle aGDevice, GWorldFlags flags)
 FOURWORDINLINE(0x203C, 0x0016, 0x0003, 0xAB1D);
extern pascal void DisposeGWorld(GWorldPtr offscreenGWorld)
 FOURWORDINLINE(0x203C, 0x0004, 0x0004, 0xAB1D);
extern pascal void GetGWorld(CGrafPtr *port, GDHandle *gdh)
 FOURWORDINLINE(0x203C, 0x0008, 0x0005, 0xAB1D);
extern pascal void SetGWorld(CGrafPtr port, GDHandle gdh)
 FOURWORDINLINE(0x203C, 0x0008, 0x0006, 0xAB1D);
extern pascal void CTabChanged(CTabHandle ctab)
 FOURWORDINLINE(0x203C, 0x0004, 0x0007, 0xAB1D);
extern pascal void PixPatChanged(PixPatHandle ppat)
 FOURWORDINLINE(0x203C, 0x0004, 0x0008, 0xAB1D);
extern pascal void PortChanged(GrafPtr port)
 FOURWORDINLINE(0x203C, 0x0004, 0x0009, 0xAB1D);
extern pascal void GDeviceChanged(GDHandle gdh)
 FOURWORDINLINE(0x203C, 0x0004, 0x000A, 0xAB1D);
extern pascal void AllowPurgePixels(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x000B, 0xAB1D);
extern pascal void NoPurgePixels(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x000C, 0xAB1D);
extern pascal GWorldFlags GetPixelsState(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x000D, 0xAB1D);
extern pascal void SetPixelsState(PixMapHandle pm, GWorldFlags state)
 FOURWORDINLINE(0x203C, 0x0008, 0x000E, 0xAB1D);
extern pascal Ptr GetPixBaseAddr(PixMapHandle pm)
 FOURWORDINLINE(0x203C, 0x0004, 0x000F, 0xAB1D);
extern pascal QDErr NewScreenBuffer(const Rect *globalRect, Boolean purgeable, GDHandle *gdh, PixMapHandle *offscreenPixMap)
 FOURWORDINLINE(0x203C, 0x000E, 0x0010, 0xAB1D);
extern pascal void DisposeScreenBuffer(PixMapHandle offscreenPixMap)
 FOURWORDINLINE(0x203C, 0x0004, 0x0011, 0xAB1D);
extern pascal GDHandle GetGWorldDevice(GWorldPtr offscreenGWorld)
 FOURWORDINLINE(0x203C, 0x0004, 0x0012, 0xAB1D);
extern pascal Boolean QDDone(GrafPtr port)
 FOURWORDINLINE(0x203C, 0x0004, 0x0013, 0xAB1D);
extern pascal long OffscreenVersion(void)
 TWOWORDINLINE(0x7014, 0xAB1D);
extern pascal QDErr NewTempScreenBuffer(const Rect *globalRect, Boolean purgeable, GDHandle *gdh, PixMapHandle *offscreenPixMap)
 FOURWORDINLINE(0x203C, 0x000E, 0x0015, 0xAB1D);
extern pascal Boolean PixMap32Bit(PixMapHandle pmHandle)
 FOURWORDINLINE(0x203C, 0x0004, 0x0016, 0xAB1D);
extern pascal PixMapHandle GetGWorldPixMap(GWorldPtr offscreenGWorld)
 FOURWORDINLINE(0x203C, 0x0004, 0x0017, 0xAB1D);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __QDOFFSCREEN__ */

/************************************************************

Created: Tuesday, May 9, 1989 at 5:26 PM
    QDOffscreen.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1989
    All rights reserved

************************************************************/


#ifndef __QDOFFSCREEN__
#define __QDOFFSCREEN__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif


/* New error codes */

#define cDepthErr -157  /*invalid pixel depth*/

enum {pixPurgeBit = 0,noNewDeviceBit = 1,pixelsPurgeableBit = 6,pixelsLockedBit = 7,
    mapPixBit = 16,newDepthBit = 17,alignPixBit = 18,newRowBytesBit = 19,reallocPixBit = 20,
    clipPixBit = 28,stretchPixBit = 29,ditherPixBit = 30,gwFlagErrBit = 31};

enum {pixPurge = 1 << pixPurgeBit,noNewDevice = 1 << noNewDeviceBit,pixelsPurgeable = 1 << pixelsPurgeableBit,
    pixelsLocked = 1 << pixelsLockedBit,mapPix = 1 << mapPixBit,newDepth = 1 << newDepthBit,
    alignPix = 1 << alignPixBit,newRowBytes = 1 << newRowBytesBit,reallocPix = 1 << reallocPixBit,
    clipPix = 1 << clipPixBit,stretchPix = 1 << stretchPixBit,ditherPix = 1 << ditherPixBit,
    gwFlagErr = 1 << gwFlagErrBit};
typedef unsigned long GWorldFlags;


/* Type definition of a GWorldPtr */

typedef CGrafPtr GWorldPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal QDErr NewGWorld(GWorldPtr *offscreenGWorld,short PixelDepth,Rect *boundsRect,
    CTabHandle cTable,GDHandle aGDevice,GWorldFlags flags)
    = {0x7000,0xAB1D}; 
pascal Boolean LockPixels(PixMapHandle pm)
    = {0x7001,0xAB1D}; 
pascal void UnlockPixels(PixMapHandle pm)
    = {0x7002,0xAB1D}; 
pascal GWorldFlags UpdateGWorld(GWorldPtr *offscreenGWorld,short pixelDepth,
    Rect *boundsRect,CTabHandle cTable,GDHandle aGDevice,GWorldFlags flags)
    = {0x7003,0xAB1D}; 
pascal void DisposeGWorld(GWorldPtr offscreenGWorld)
    = {0x7004,0xAB1D}; 
pascal void GetGWorld(CGrafPtr *port,GDHandle *gdh)
    = {0x7005,0xAB1D}; 
pascal void SetGWorld(CGrafPtr port,GDHandle gdh)
    = {0x7006,0xAB1D}; 
pascal void CTabChanged(CTabHandle ctab)
    = {0x7007,0xAB1D}; 
pascal void PixPatChanged(PixPatHandle ppat)
    = {0x7008,0xAB1D}; 
pascal void PortChanged(GrafPtr port)
    = {0x7009,0xAB1D}; 
pascal void GDeviceChanged(GDHandle gdh)
    = {0x700A,0xAB1D}; 
pascal void AllowPurgePixels(PixMapHandle pm)
    = {0x700B,0xAB1D}; 
pascal void NoPurgePixels(PixMapHandle pm)
    = {0x700C,0xAB1D}; 
pascal GWorldFlags GetPixelsState(PixMapHandle pm)
    = {0x700D,0xAB1D}; 
pascal void SetPixelsState(PixMapHandle pm,GWorldFlags state)
    = {0x700E,0xAB1D}; 
pascal Ptr GetPixBaseAddr(PixMapHandle pm)
    = {0x700F,0xAB1D}; 
pascal QDErr NewScreenBuffer(Rect *globalRect,Boolean purgeable,GDHandle *gdh,
    PixMapHandle *offscreenPixMap)
    = {0x7010,0xAB1D}; 
pascal void DisposeScreenBuffer(PixMapHandle offscreenPixMap)
    = {0x7011,0xAB1D}; 
pascal GDHandle GetGWorldDevice(GWorldPtr offscreenGWorld)
    = {0x7012,0xAB1D}; 
#ifdef __safe_link
}
#endif

#endif

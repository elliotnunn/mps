/************************************************************

Created: Tuesday, October 4, 1988 at 7:24 PM
    Palettes.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1987-1988
    All rights reserved

************************************************************/


#ifndef __PALETTES__
#define __PALETTES__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#define pmCourteous 0           /*Record use of color on each device touched.*/
#define pmTolerant 2            /*render ciRGB if ciTolerance is exceeded by best match.*/
#define pmAnimated 4            /*reserve an index on each device touched and render ciRGB.*/
#define pmExplicit 8            /*no reserve, no render, no record; stuff index into port.*/

/* NSetPalette Update Constants */

#define pmNoUpdates 0x8000      /*no updates*/
#define pmBkUpdates 0xA000      /*background updates only*/
#define pmFgUpdates 0xC000      /*foreground updates only*/
#define pmAllUpdates 0xE000     /*all updates*/

struct ColorInfo {
    RGBColor ciRGB;             /*true RGB values*/
    short ciUsage;              /*color usage*/
    short ciTolerance;          /*tolerance value*/
    short ciDataFields[3];      /*private fields*/
};

#ifndef __cplusplus
typedef struct ColorInfo ColorInfo;
#endif

struct Palette {
    short pmEntries;            /*entries in pmTable*/
    short pmDataFields[7];      /*private fields*/
    ColorInfo pmInfo[1];
};

#ifndef __cplusplus
typedef struct Palette Palette;
#endif

typedef Palette *PalettePtr, **PaletteHandle;

#ifdef __safe_link
extern "C" {
#endif
pascal void InitPalettes(void)
    = 0xAA90; 
pascal PaletteHandle NewPalette(short entries,CTabHandle srcColors,short srcUsage,
    short srcTolerance)
    = 0xAA91; 
pascal PaletteHandle GetNewPalette(short PaletteID)
    = 0xAA92; 
pascal void DisposePalette(PaletteHandle srcPalette)
    = 0xAA93; 
pascal void ActivatePalette(WindowPtr srcWindow)
    = 0xAA94; 
pascal void SetPalette(WindowPtr dstWindow,PaletteHandle srcPalette,Boolean cUpdates)
    = 0xAA95; 
pascal void NSetPalette(WindowPtr dstWindow,PaletteHandle srcPalette,short nCUpdates)
    = 0xAA95; 
pascal PaletteHandle GetPalette(WindowPtr srcWindow)
    = 0xAA96; 
pascal void CopyPalette(PaletteHandle srcPalette,PaletteHandle dstPalette,
    short srcEntry,short dstEntry,short dstLength)
    = 0xAAA1; 
pascal void PmForeColor(short dstEntry)
    = 0xAA97; 
pascal void PmBackColor(short dstEntry)
    = 0xAA98; 
pascal void AnimateEntry(WindowPtr dstWindow,short dstEntry,const RGBColor *srcRGB)
    = 0xAA99; 
pascal void AnimatePalette(WindowPtr dstWindow,CTabHandle srcCTab,short srcIndex,
    short dstEntry,short dstLength)
    = 0xAA9A; 
pascal void GetEntryColor(PaletteHandle srcPalette,short srcEntry,RGBColor *dstRGB)
    = 0xAA9B; 
pascal void SetEntryColor(PaletteHandle dstPalette,short dstEntry,const RGBColor *srcRGB)
    = 0xAA9C; 
pascal void GetEntryUsage(PaletteHandle srcPalette,short srcEntry,short *dstUsage,
    short *dstTolerance)
    = 0xAA9D; 
pascal void SetEntryUsage(PaletteHandle dstPalette,short dstEntry,short srcUsage,
    short srcTolerance)
    = 0xAA9E; 
pascal void CTab2Palette(CTabHandle srcCTab,PaletteHandle dstPalette,short srcUsage,
    short srcTolerance)
    = 0xAA9F; 
pascal void Palette2CTab(PaletteHandle srcPalette,CTabHandle dstCTab)
    = 0xAAA0; 
#ifdef __safe_link
}
#endif

#endif

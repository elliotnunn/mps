/*
 	File:		Palettes.h
 
 	Contains:	Palette Manager Interfaces.
 
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

#ifndef __PALETTES__
#define __PALETTES__


#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Memory.h>											*/
/*	#include <Events.h>											*/
/*		#include <OSUtils.h>									*/
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

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
	pmCourteous					= 0,							/*Record use of color on each device touched.*/
	pmTolerant					= 0x0002,						/*render ciRGB if ciTolerance is exceeded by best match.*/
	pmAnimated					= 0x0004,						/*reserve an index on each device touched and render ciRGB.*/
	pmExplicit					= 0x0008,						/*no reserve, no render, no record; stuff index into port.*/
	pmWhite						= 0x0010,
	pmBlack						= 0x0020,
	pmInhibitG2					= 0x0100,
	pmInhibitC2					= 0x0200,
	pmInhibitG4					= 0x0400,
	pmInhibitC4					= 0x0800,
	pmInhibitG8					= 0x1000,
	pmInhibitC8					= 0x2000,
/* NSetPalette Update Constants */
	pmNoUpdates					= 0x8000,						/*no updates*/
	pmBkUpdates					= 0xA000,						/*background updates only*/
	pmFgUpdates					= 0xC000,						/*foreground updates only*/
	pmAllUpdates				= 0xE000						/*all updates*/
};

struct ColorInfo {
	RGBColor						ciRGB;						/*true RGB values*/
	short							ciUsage;					/*color usage*/
	short							ciTolerance;				/*tolerance value*/
	short							ciDataFields[3];			/*private fields*/
};
typedef struct ColorInfo ColorInfo;

struct Palette {
	short							pmEntries;					/*entries in pmTable*/
	short							pmDataFields[7];			/*private fields*/
	ColorInfo						pmInfo[1];
};
typedef struct Palette Palette, *PalettePtr, **PaletteHandle;

extern pascal void InitPalettes(void)
 ONEWORDINLINE(0xAA90);
extern pascal PaletteHandle NewPalette(short entries, CTabHandle srcColors, short srcUsage, short srcTolerance)
 ONEWORDINLINE(0xAA91);
extern pascal PaletteHandle GetNewPalette(short PaletteID)
 ONEWORDINLINE(0xAA92);
extern pascal void DisposePalette(PaletteHandle srcPalette)
 ONEWORDINLINE(0xAA93);
extern pascal void ActivatePalette(WindowPtr srcWindow)
 ONEWORDINLINE(0xAA94);
extern pascal void SetPalette(WindowPtr dstWindow, PaletteHandle srcPalette, Boolean cUpdates)
 ONEWORDINLINE(0xAA95);
extern pascal void NSetPalette(WindowPtr dstWindow, PaletteHandle srcPalette, short nCUpdates)
 ONEWORDINLINE(0xAA95);
extern pascal PaletteHandle GetPalette(WindowPtr srcWindow)
 ONEWORDINLINE(0xAA96);
extern pascal void CopyPalette(PaletteHandle srcPalette, PaletteHandle dstPalette, short srcEntry, short dstEntry, short dstLength)
 ONEWORDINLINE(0xAAA1);
extern pascal void PmForeColor(short dstEntry)
 ONEWORDINLINE(0xAA97);
extern pascal void PmBackColor(short dstEntry)
 ONEWORDINLINE(0xAA98);
extern pascal void AnimateEntry(WindowPtr dstWindow, short dstEntry, const RGBColor *srcRGB)
 ONEWORDINLINE(0xAA99);
extern pascal void AnimatePalette(WindowPtr dstWindow, CTabHandle srcCTab, short srcIndex, short dstEntry, short dstLength)
 ONEWORDINLINE(0xAA9A);
extern pascal void GetEntryColor(PaletteHandle srcPalette, short srcEntry, RGBColor *dstRGB)
 ONEWORDINLINE(0xAA9B);
extern pascal void SetEntryColor(PaletteHandle dstPalette, short dstEntry, const RGBColor *srcRGB)
 ONEWORDINLINE(0xAA9C);
extern pascal void GetEntryUsage(PaletteHandle srcPalette, short srcEntry, short *dstUsage, short *dstTolerance)
 ONEWORDINLINE(0xAA9D);
extern pascal void SetEntryUsage(PaletteHandle dstPalette, short dstEntry, short srcUsage, short srcTolerance)
 ONEWORDINLINE(0xAA9E);
extern pascal void CTab2Palette(CTabHandle srcCTab, PaletteHandle dstPalette, short srcUsage, short srcTolerance)
 ONEWORDINLINE(0xAA9F);
extern pascal void Palette2CTab(PaletteHandle srcPalette, CTabHandle dstCTab)
 ONEWORDINLINE(0xAAA0);
extern pascal long Entry2Index(short entry)
 TWOWORDINLINE(0x7000, 0xAAA2);
extern pascal void RestoreDeviceClut(GDHandle gd)
 TWOWORDINLINE(0x7002, 0xAAA2);
extern pascal void ResizePalette(PaletteHandle p, short size)
 TWOWORDINLINE(0x7003, 0xAAA2);
extern pascal void SaveFore(ColorSpec *c)
 THREEWORDINLINE(0x303C, 0x040D, 0xAAA2);
extern pascal void SaveBack(ColorSpec *c)
 THREEWORDINLINE(0x303C, 0x040E, 0xAAA2);
extern pascal void RestoreFore(const ColorSpec *c)
 THREEWORDINLINE(0x303C, 0x040F, 0xAAA2);
extern pascal void RestoreBack(const ColorSpec *c)
 THREEWORDINLINE(0x303C, 0x0410, 0xAAA2);
extern pascal OSErr SetDepth(GDHandle gd, short depth, short whichFlags, short flags)
 THREEWORDINLINE(0x303C, 0x0A13, 0xAAA2);
extern pascal short HasDepth(GDHandle gd, short depth, short whichFlags, short flags)
 THREEWORDINLINE(0x303C, 0x0A14, 0xAAA2);
extern pascal short PMgrVersion(void)
 TWOWORDINLINE(0x7015, 0xAAA2);
extern pascal void SetPaletteUpdates(PaletteHandle p, short updates)
 THREEWORDINLINE(0x303C, 0x0616, 0xAAA2);
extern pascal short GetPaletteUpdates(PaletteHandle p)
 THREEWORDINLINE(0x303C, 0x0417, 0xAAA2);
extern pascal Boolean GetGray(GDHandle device, const RGBColor *backGround, RGBColor *foreGround)
 THREEWORDINLINE(0x303C, 0x0C19, 0xAAA2);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PALETTES__ */

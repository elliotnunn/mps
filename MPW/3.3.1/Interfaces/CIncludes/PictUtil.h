/*
	File:		PictUtil.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __PICTUTIL__
#define __PICTUTIL__

#ifndef __TYPES__
#include <Types.h>
/*	#include <ConditionalMacros.h>								*/
/*	#include <MixedMode.h>										*/
/*		#include <Traps.h>										*/
#endif

#ifndef __PALETTES__
#include <Palettes.h>
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*			#include <IntlResources.h>							*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*		#include <Controls.h>									*/
/*			#include <Menus.h>									*/
#endif


/* verbs for the GetPictInfo, GetPixMapInfo, and NewPictInfo calls */

#define returnColorTable ((short) 0x0001)

#define returnPalette ((short) 0x0002)

#define recordComments ((short) 0x0004)

#define recordFontInfo ((short) 0x0008)

#define suppressBlackAndWhite ((short) 0x0010)

enum  {
/* color pick methods */
	systemMethod				= 0,							/* system color pick method */
	popularMethod				= 1,							/* method that chooses the most popular set of colors */
	medianMethod				= 2,							/* method that chooses a good average mix of colors */
/* color bank types */
	ColorBankIsCustom			= -1,
	ColorBankIsExactAnd555		= 0,
	ColorBankIs555				= 1
};

typedef long PictInfoID;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CommentSpec {
	short						count;							/* number of occurrances of this comment ID */
	short						ID;								/* ID for the comment in the picture */
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CommentSpec CommentSpec;

typedef CommentSpec *CommentSpecPtr, **CommentSpecHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct FontSpec {
	short						pictFontID;						/* ID of the font in the picture */
	short						sysFontID;						/* ID of the same font in the current system file */
	long						size[4];						/* bit array of all the sizes found (1..127) (bit 0 means > 127) */
	short						style;							/* combined style of all occurrances of the font */
	long						nameOffset;						/* offset into the fontNamesHdl handle for the font’s name */
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct FontSpec FontSpec;

typedef FontSpec *FontSpecPtr, **FontSpecHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct PictInfo {
	short						version;						/* this is always zero, for now */
	long						uniqueColors;					/* the number of actual colors in the picture(s)/pixmap(s) */
	PaletteHandle				thePalette;						/* handle to the palette information */
	CTabHandle					theColorTable;					/* handle to the color table */
	Fixed						hRes;							/* maximum horizontal resolution for all the pixmaps */
	Fixed						vRes;							/* maximum vertical resolution for all the pixmaps */
	short						depth;							/* maximum depth for all the pixmaps (in the picture) */
	Rect						sourceRect;						/* the picture frame rectangle (this contains the entire picture) */
	long						textCount;						/* total number of text strings in the picture */
	long						lineCount;						/* total number of lines in the picture */
	long						rectCount;						/* total number of rectangles in the picture */
	long						rRectCount;						/* total number of round rectangles in the picture */
	long						ovalCount;						/* total number of ovals in the picture */
	long						arcCount;						/* total number of arcs in the picture */
	long						polyCount;						/* total number of polygons in the picture */
	long						regionCount;					/* total number of regions in the picture */
	long						bitMapCount;					/* total number of bitmaps in the picture */
	long						pixMapCount;					/* total number of pixmaps in the picture */
	long						commentCount;					/* total number of comments in the picture */
	long						uniqueComments;					/* the number of unique comments in the picture */
	CommentSpecHandle			commentHandle;					/* handle to all the comment information */
	long						uniqueFonts;					/* the number of unique fonts in the picture */
	FontSpecHandle				fontHandle;						/* handle to the FontSpec information */
	Handle						fontNamesHandle;				/* handle to the font names */
	long						reserved1;
	long						reserved2;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct PictInfo PictInfo;

typedef PictInfo *PictInfoPtr, **PictInfoHandle;

#ifdef __cplusplus
extern "C" {
#endif

extern pascal OSErr GetPictInfo(PicHandle thePictHandle, PictInfo *thePictInfo, short verb, short colorsRequested, short colorPickMethod, short version)
 THREEWORDINLINE(0x303C, 0x0800, 0xA831);
extern pascal OSErr GetPixMapInfo(PixMapHandle thePixMapHandle, PictInfo *thePictInfo, short verb, short colorsRequested, short colorPickMethod, short version)
 THREEWORDINLINE(0x303C, 0x0801, 0xA831);
extern pascal OSErr NewPictInfo(PictInfoID *thePictInfoID, short verb, short colorsRequested, short colorPickMethod, short version)
 THREEWORDINLINE(0x303C, 0x0602, 0xA831);
extern pascal OSErr RecordPictInfo(PictInfoID thePictInfoID, PicHandle thePictHandle)
 THREEWORDINLINE(0x303C, 0x0403, 0xA831);
extern pascal OSErr RecordPixMapInfo(PictInfoID thePictInfoID, PixMapHandle thePixMapHandle)
 THREEWORDINLINE(0x303C, 0x0404, 0xA831);
extern pascal OSErr RetrievePictInfo(PictInfoID thePictInfoID, PictInfo *thePictInfo, short colorsRequested)
 THREEWORDINLINE(0x303C, 0x0505, 0xA831);
extern pascal OSErr DisposePictInfo(PictInfoID thePictInfoID)
 THREEWORDINLINE(0x303C, 0x0206, 0xA831);
#if OLDROUTINENAMES
#define DisposPictInfo(thePictInfoID) DisposePictInfo(thePictInfoID)

#endif

#ifdef __cplusplus
}
#endif

#endif


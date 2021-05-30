/*
 	File:		PictUtils.h
 
 	Contains:	Picture Utilities Interfaces.
 
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

#ifndef __PICTUTILS__
#define __PICTUTILS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Events.h>											*/
/*		#include <OSUtils.h>									*/
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

#ifndef __PALETTES__
#include <Palettes.h>
#endif

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
	returnColorTable			= 0x0001,
	returnPalette				= 0x0002,
	recordComments				= 0x0004,
	recordFontInfo				= 0x0008,
	suppressBlackAndWhite		= 0x0010
};

enum {
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

struct CommentSpec {
	short							count;						/* number of occurrances of this comment ID */
	short							ID;							/* ID for the comment in the picture */
};
typedef struct CommentSpec CommentSpec, *CommentSpecPtr, **CommentSpecHandle;

struct FontSpec {
	short							pictFontID;					/* ID of the font in the picture */
	short							sysFontID;					/* ID of the same font in the current system file */
	long							size[4];					/* bit array of all the sizes found (1..127) (bit 0 means > 127) */
	short							style;						/* combined style of all occurrances of the font */
	long							nameOffset;					/* offset into the fontNamesHdl handle for the font’s name */
};
typedef struct FontSpec FontSpec, *FontSpecPtr, **FontSpecHandle;

struct PictInfo {
	short							version;					/* this is always zero, for now */
	long							uniqueColors;				/* the number of actual colors in the picture(s)/pixmap(s) */
	PaletteHandle					thePalette;					/* handle to the palette information */
	CTabHandle						theColorTable;				/* handle to the color table */
	Fixed							hRes;						/* maximum horizontal resolution for all the pixmaps */
	Fixed							vRes;						/* maximum vertical resolution for all the pixmaps */
	short							depth;						/* maximum depth for all the pixmaps (in the picture) */
	Rect							sourceRect;					/* the picture frame rectangle (this contains the entire picture) */
	long							textCount;					/* total number of text strings in the picture */
	long							lineCount;					/* total number of lines in the picture */
	long							rectCount;					/* total number of rectangles in the picture */
	long							rRectCount;					/* total number of round rectangles in the picture */
	long							ovalCount;					/* total number of ovals in the picture */
	long							arcCount;					/* total number of arcs in the picture */
	long							polyCount;					/* total number of polygons in the picture */
	long							regionCount;				/* total number of regions in the picture */
	long							bitMapCount;				/* total number of bitmaps in the picture */
	long							pixMapCount;				/* total number of pixmaps in the picture */
	long							commentCount;				/* total number of comments in the picture */
	long							uniqueComments;				/* the number of unique comments in the picture */
	CommentSpecHandle				commentHandle;				/* handle to all the comment information */
	long							uniqueFonts;				/* the number of unique fonts in the picture */
	FontSpecHandle					fontHandle;					/* handle to the FontSpec information */
	Handle							fontNamesHandle;			/* handle to the font names */
	long							reserved1;
	long							reserved2;
};
typedef struct PictInfo PictInfo;

typedef PictInfo *PictInfoPtr, **PictInfoHandle;

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

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PICTUTILS__ */

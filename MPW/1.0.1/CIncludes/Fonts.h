/*
	Fonts.h -- Font Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __FONTS__
#define __FONTS__
#ifndef __TYPES__
#include <Types.h>
#endif

#define systemFont 0
#define applFont 1
#define newYork 2
#define geneva 3
#define monaco 4
#define venice 5
#define london 6
#define athens 7
#define sanFran 8
#define toronto 9
#define cairo 11
#define losAngeles 12
#define times 20
#define helvetica 21
#define courier 22
#define symbol 23
#define mobile 24
#define commandMark '\021'
#define checkMark '\022'
#define diamondMark '\023'
#define appleMark '\024'
#define propFont 0x9000
#define prpFntH 0x9001
#define prpFntW 0x9002
#define prpFntHW 0x9003
#define fixedFont 0xB000
#define fxdFntH 0xB001
#define fxdFntW 0xB002
#define fxdFntHW 0xB003
#define fontWid 0xACB0
typedef struct FMInput {
	short family;
	short size;
	Style face;
	Boolean needBits;
	short device;
	Point numer;
	Point denom;
} FMInput;
typedef struct FMOutput {
	short errNum;
	Handle fontHandle;
	unsigned char boldPixels;
	unsigned char italicPixels;
	unsigned char ulOffset;
	unsigned char ulShadow;
	unsigned char ulThick;
	unsigned char shadowPixels;
	char extra;
	unsigned char ascent;
	unsigned char descent;
	unsigned char widMax;
	char leading;
	char unused;
	Point numer;
	Point denom;
} FMOutput,*FMOutPtr;
typedef struct FontRec {
	short fontType;
	short firstChar;
	short lastChar;
	short widMax;
	short kernMax;
	short nDescent;
	short fRectWidth;
	short fRectHeight;
	short owTLoc;
	short ascent;
	short descent;
	short leading;
	short rowWords;
} FontRec;
typedef struct FMetricRec {
	Fixed ascent;
	Fixed descent;
	Fixed leading;
	Fixed widMax;
	Handle wTabHandle;
} FMetricRec;
typedef struct WidthTable {
	Fixed tabData[256];
	Handle tabFont;
	long sExtra;
	long style;
	short fID;
	short fSize;
	short face;
	short device;
	Point inNumer;
	Point inDenom;
	short aFID;
	Handle fHand;
	Boolean usedFam;
	unsigned char aFace;
	short vOutput;
	short hOutput;
	short vFactor;
	short hFactor;
	short aSize;
	short tabSize;
} WidthTable;
typedef struct FamRec {
	short ffFlags;
	short ffFamId;
	short ffFirstChar;
	short ffLastChar;
	short ffAscent;
	short ffDescent;
	short ffLeading;
	short ffWidMax;
	long ffWTabOff;
	long ffKernOff;
	long ffStylOff;
	short ffProperty[9];
	short ffIntl[2];
	short ffVersion;
} FamRec;
pascal void InitFonts()
	extern 0xA8FE;
pascal Boolean RealFont(fontNum,size)
	short fontNum;
	short size;
	extern 0xA902;
pascal void SetFontLock(lockFlag)
	Boolean lockFlag;
	extern 0xA903;
pascal FMOutPtr FMSwapFont(inRec)
	FMInput *inRec;
	extern 0xA901;
pascal void SetFScaleDisable(fscaleDisable)
	Boolean fscaleDisable;
	extern 0xA834;
pascal void FontMetrics(theMetrics)
	FMetricRec *theMetrics;
	extern 0xA835;
#endif

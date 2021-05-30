/************************************************************

Created: Tuesday, October 4, 1988 at 6:29 PM
    Fonts.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


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
#define commandMark 17
#define checkMark 18
#define diamondMark 19
#define appleMark 20
#define propFont 36864
#define prpFntH 36865
#define prpFntW 36866
#define prpFntHW 36867
#define fixedFont 45056
#define fxdFntH 45057
#define fxdFntW 45058
#define fxdFntHW 45059
#define fontWid 44208

struct FMInput {
    short family;
    short size;
    Style face;
    Boolean needBits;
    short device;
    Point numer;
    Point denom;
};

#ifndef __cplusplus
typedef struct FMInput FMInput;
#endif

struct FMOutput {
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
};

#ifndef __cplusplus
typedef struct FMOutput FMOutput;
#endif

typedef FMOutput *FMOutPtr;

struct FontRec {
    short fontType;         /*font type*/
    short firstChar;        /*ASCII code of first character*/
    short lastChar;         /*ASCII code of last character*/
    short widMax;           /*maximum character width*/
    short kernMax;          /*negative of maximum character kern*/
    short nDescent;         /*negative of descent*/
    short fRectWidth;       /*width of font rectangle*/
    short fRectHeight;      /*height of font rectangle*/
    short owTLoc;           /*offset to offset/width table*/
    short ascent;           /*ascent*/
    short descent;          /*descent*/
    short leading;          /*leading*/
    short rowWords;         /*row width of bit image / 2 */
};

#ifndef __cplusplus
typedef struct FontRec FontRec;
#endif

struct FMetricRec {
    Fixed ascent;           /*base line to top*/
    Fixed descent;          /*base line to bottom*/
    Fixed leading;          /*leading between lines*/
    Fixed widMax;           /*maximum character width*/
    Handle wTabHandle;      /*handle to font width table*/
};

#ifndef __cplusplus
typedef struct FMetricRec FMetricRec;
#endif

struct WidEntry {
    short widStyle;         /*style entry applies to*/
};

#ifndef __cplusplus
typedef struct WidEntry WidEntry;
#endif

struct WidTable {
    short numWidths;        /*number of entries - 1*/
};

#ifndef __cplusplus
typedef struct WidTable WidTable;
#endif

struct AsscEntry {
    short fontSize;
    short fontStyle;
    short fontID;           /*font resource ID*/
};

#ifndef __cplusplus
typedef struct AsscEntry AsscEntry;
#endif

struct FontAssoc {
    short numAssoc;         /*number of entries - 1*/
};

#ifndef __cplusplus
typedef struct FontAssoc FontAssoc;
#endif

struct StyleTable {
    short fontClass;
    long offset;
    long reserved;
    char indexes[48];
};

#ifndef __cplusplus
typedef struct StyleTable StyleTable;
#endif

struct NameTable {
    short stringCount;
    Str255 baseFontName;
};

#ifndef __cplusplus
typedef struct NameTable NameTable;
#endif

struct KernPair {
    char kernFirst;         /*1st character of kerned pair*/
    char kernSecond;        /*2nd character of kerned pair*/
    short kernWidth;        /*kerning in 1pt fixed format*/
};

#ifndef __cplusplus
typedef struct KernPair KernPair;
#endif

struct KernEntry {
    short kernLength;       /*length of this entry*/
    short kernStyle;        /*style the entry applies to*/
};

#ifndef __cplusplus
typedef struct KernEntry KernEntry;
#endif

struct KernTable {
    short numKerns;         /*number of kerning entries*/
};

#ifndef __cplusplus
typedef struct KernTable KernTable;
#endif

struct WidthTable {
    Fixed tabData[256];     /*character widths*/
    Handle tabFont;         /*font record used to build table*/
    long sExtra;            /*space extra used for table*/
    long style;             /*extra due to style*/
    short fID;              /*font family ID*/
    short fSize;            /*font size request*/
    short face;             /*style (face) request*/
    short device;           /*device requested*/
    Point inNumer;          /*scale factors requested*/
    Point inDenom;          /*scale factors requested*/
    short aFID;             /*actual font family ID for table*/
    Handle fHand;           /*family record used to build up table*/
    Boolean usedFam;        /*used fixed point family widths*/
    unsigned char aFace;    /*actual face produced*/
    short vOutput;          /*vertical scale output value*/
    short hOutput;          /*horizontal scale output value*/
    short vFactor;          /*vertical scale output value*/
    short hFactor;          /*horizontal scale output value*/
    short aSize;            /*actual size of actual font used*/
    short tabSize;          /*total size of table*/
};

#ifndef __cplusplus
typedef struct WidthTable WidthTable;
#endif

struct FamRec {
    short ffFlags;          /*flags for family*/
    short ffFamID;          /*family ID number*/
    short ffFirstChar;      /*ASCII code of 1st character*/
    short ffLastChar;       /*ASCII code of last character*/
    short ffAscent;         /*maximum ascent for 1pt font*/
    short ffDescent;        /*maximum descent for 1pt font*/
    short ffLeading;        /*maximum leading for 1pt font*/
    short ffWidMax;         /*maximum widMax for 1pt font*/
    long ffWTabOff;         /*offset to width table*/
    long ffKernOff;         /*offset to kerning table*/
    long ffStylOff;         /*offset to style mapping table*/
    short ffProperty[9];    /*style property info*/
    short ffIntl[2];        /*for international use*/
    short ffVersion;        /*version number*/
};

#ifndef __cplusplus
typedef struct FamRec FamRec;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void InitFonts(void)
    = 0xA8FE; 
pascal void GetFontName(short familyID,Str255 theName)
    = 0xA8FF; 
pascal void GetFNum(const Str255 theName,short *familyID)
    = 0xA900; 
pascal Boolean RealFont(short fontNum,short size)
    = 0xA902; 
pascal void SetFontLock(Boolean lockFlag)
    = 0xA903; 
pascal FMOutPtr FMSwapFont(const FMInput *inRec)
    = 0xA901; 
pascal void SetFScaleDisable(Boolean fscaleDisable)
    = 0xA834; 
pascal void FontMetrics(const FMetricRec *theMetrics)
    = 0xA835; 
pascal void SetFractEnable(Boolean fractEnable); 
void getfnum(char *theName,short *familyID); 
void getfontname(short familyID,char *theName); 
#ifdef __safe_link
}
#endif

#endif

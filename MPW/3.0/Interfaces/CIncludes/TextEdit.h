/************************************************************

Created: Tuesday, October 4, 1988 at 9:46 PM
    TextEdit.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __TEXTEDIT__
#define __TEXTEDIT__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define teJustLeft 0
#define teJustCenter 1
#define teJustRight -1
#define teForceLeft -2
#define doFont 1                                        /* set font (family) number*/
#define doFace 2                                        /*set character style*/
#define doSize 4                                        /*set type size*/
#define doColor 8                                       /*set color*/
#define doAll 15                                        /*set all attributes*/
#define addSize 16                                      /*adjust type size*/
#define doToggle 32                                     /*toggle mode for TESetStyle & TEContinuousStyle*/
#define intEOLHook 0                                    /*TEIntHook value*/
#define intDrawHook 1                                   /*TEIntHook value*/
#define intWidthHook 2                                  /*TEIntHook value*/
#define intHitTestHook 3                                /*TEIntHook value*/

typedef char Chars[32001];
typedef Chars *CharsPtr,**CharsHandle;

typedef short TEIntHook;

typedef pascal Boolean (*WordBreakProcPtr)(Ptr text, short charPos);
typedef pascal Boolean (*ClikLoopProcPtr)(void);

struct TERec {
    Rect destRect;
    Rect viewRect;
    Rect selRect;
    short lineHeight;
    short fontAscent;
    Point selPoint;
    short selStart;
    short selEnd;
    short active;
    WordBreakProcPtr wordBreak;
    ClikLoopProcPtr clikLoop;
    long clickTime;
    short clickLoc;
    long caretTime;
    short caretState;
    short just;
    short teLength;
    Handle hText;
    short recalBack;
    short recalLines;
    short clikStuff;
    short crOnly;
    short txFont;
    Style txFace;                                       /*txFace is unpacked byte*/
    char filler;
    short txMode;
    short txSize;
    GrafPtr inPort;
    ProcPtr highHook;
    ProcPtr caretHook;
    short nLines;
    short lineStarts[16001];
};

#ifndef __cplusplus
typedef struct TERec TERec;
#endif

typedef TERec *TEPtr, **TEHandle;

struct StyleRun {
    short startChar;                                    /*starting character position*/
    short styleIndex;                                   /*index in style table*/
};

#ifndef __cplusplus
typedef struct StyleRun StyleRun;
#endif

struct STElement {
    short stCount;                                      /*number of runs in this style*/
    short stHeight;                                     /*line height*/
    short stAscent;                                     /*font ascent*/
    short stFont;                                       /*font (family) number*/
    Style stFace;                                       /*character Style*/
    char filler;                                        /*stFace is unpacked byte*/
    short stSize;                                       /*size in points*/
    RGBColor stColor;                                   /*absolute (RGB) color*/
};

#ifndef __cplusplus
typedef struct STElement STElement;
#endif

typedef STElement TEStyleTable[1777], *STPtr, **STHandle;

struct LHElement {
    short lhHeight;                                     /*maximum height in line*/
    short lhAscent;                                     /*maximum ascent in line*/
};

#ifndef __cplusplus
typedef struct LHElement LHElement;
#endif

typedef LHElement LHTable[8001], *LHPtr, **LHHandle;    /* ARRAY [0..8000] OF LHElement */

struct ScrpSTElement {
    long scrpStartChar;                                 /*starting character position*/
    short scrpHeight;                                   /*starting character position*/
    short scrpAscent;
    short scrpFont;
    Style scrpFace;                                     /*unpacked byte*/
    char filler;                                        /*scrpFace is unpacked byte*/
    short scrpSize;
    RGBColor scrpColor;
};

#ifndef __cplusplus
typedef struct ScrpSTElement ScrpSTElement;
#endif

typedef ScrpSTElement ScrpSTTable[1601];                /* ARRAY [0..1600] OF ScrpSTElement */

struct StScrpRec {
    short scrpNStyles;                                  /*number of styles in scrap*/
    ScrpSTTable scrpStyleTab;                           /*table of styles for scrap*/
};

#ifndef __cplusplus
typedef struct StScrpRec StScrpRec;
#endif

typedef StScrpRec *StScrpPtr, **StScrpHandle;

struct NullStRec {
    long teReserved;                                    /*reserved for future expansion*/
    StScrpHandle nullScrap;                             /*handle to scrap style table*/
};

#ifndef __cplusplus
typedef struct NullStRec NullStRec;
#endif

typedef NullStRec *NullStPtr, **NullStHandle;

struct TEStyleRec {
    short nRuns;                                        /*number of style runs*/
    short nStyles;                                      /*size of style table*/
    STHandle styleTab;                                  /*handle to style table*/
    LHHandle lhTab;                                     /*handle to line-height table*/
    long teRefCon;                                      /*reserved for application use*/
    NullStHandle nullStyle;                             /*Handle to style set at null selection*/
    StyleRun runs[8001];                                /*ARRAY [0..8000] OF StyleRun*/
};

#ifndef __cplusplus
typedef struct TEStyleRec TEStyleRec;
#endif

typedef TEStyleRec *TEStylePtr, **TEStyleHandle;

struct TextStyle {
    short tsFont;                                       /*font (family) number*/
    Style tsFace;                                       /*character Style*/
    char filler;                                        /*tsFace is unpacked byte*/
    short tsSize;                                       /*size in point*/
    RGBColor tsColor;                                   /*absolute (RGB) color*/
};

#ifndef __cplusplus
typedef struct TextStyle TextStyle;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void TEInit(void)
    = 0xA9CC; 
pascal TEHandle TENew(const Rect *destRect,const Rect *viewRect)
    = 0xA9D2; 
pascal void TEDispose(TEHandle hTE)
    = 0xA9CD; 
pascal void TESetText(Ptr text,long length,TEHandle hTE)
    = 0xA9CF; 
pascal CharsHandle TEGetText(TEHandle hTE)
    = 0xA9CB; 
pascal void TEIdle(TEHandle hTE)
    = 0xA9DA; 
pascal void TESetSelect(long selStart,long selEnd,TEHandle hTE)
    = 0xA9D1; 
pascal void TEActivate(TEHandle hTE)
    = 0xA9D8; 
pascal void TEDeactivate(TEHandle hTE)
    = 0xA9D9; 
pascal void TEKey(short key,TEHandle hTE)
    = 0xA9DC; 
pascal void TECut(TEHandle hTE)
    = 0xA9D6; 
pascal void TECopy(TEHandle hTE)
    = 0xA9D5; 
pascal void TEPaste(TEHandle hTE)
    = 0xA9DB; 
pascal void TEDelete(TEHandle hTE)
    = 0xA9D7; 
pascal void TEInsert(Ptr text,long length,TEHandle hTE)
    = 0xA9DE; 
pascal void TESetJust(short just,TEHandle hTE)
    = 0xA9DF; 
pascal void TEUpdate(const Rect *rUpdate,TEHandle hTE)
    = 0xA9D3; 
pascal void TextBox(Ptr text,long length,const Rect *box,short just)
    = 0xA9CE; 
pascal void TEScroll(short dh,short dv,TEHandle hTE)
    = 0xA9DD; 
pascal void TESelView(TEHandle hTE)
    = 0xA811; 
pascal void TEPinScroll(short dh,short dv,TEHandle hTE)
    = 0xA812; 
pascal void TEAutoView(Boolean fAuto,TEHandle hTE)
    = 0xA813; 
pascal Handle TEScrapHandle(void)
    = {0x2EB8,0x0AB4}; 
pascal void TECalText(TEHandle hTE)
    = 0xA9D0; 
pascal short TEGetOffset(Point pt,TEHandle hTE)
    = 0xA83C; 
pascal struct Point TEGetPoint(short offset,TEHandle hTE)
    = {0x3F3C,0x0008,0xA83D}; 
pascal void TEClick(Point pt,Boolean fExtend,TEHandle h)
    = 0xA9D4; 
pascal TEHandle TEStylNew(const Rect *destRect,const Rect *viewRect)
    = 0xA83E; 
pascal void SetStylHandle(TEStyleHandle theHandle,TEHandle hTE)
    = {0x3F3C,0x0005,0xA83D}; 
pascal TEStyleHandle GetStylHandle(TEHandle hTE)
    = {0x3F3C,0x0004,0xA83D}; 
pascal void TEGetStyle(short offset,TextStyle *theStyle,short *lineHeight,
    short *fontAscent,TEHandle hTE)
    = {0x3F3C,0x0003,0xA83D}; 
pascal void TEStylPaste(TEHandle hTE)
    = {0x3F3C,0x0000,0xA83D}; 
pascal void TESetStyle(short mode,const TextStyle *newStyle,Boolean redraw,
    TEHandle hTE)
    = {0x3F3C,0x0001,0xA83D}; 
pascal void TEReplaceStyle(short mode,const TextStyle *oldStyle,const TextStyle *newStyle,
    Boolean redraw,TEHandle hTE)
    = {0x3F3C,0x0002,0xA83D}; 
pascal StScrpHandle GetStylScrap(TEHandle hTE)
    = {0x3F3C,0x0006,0xA83D}; 
pascal void TEStylInsert(Ptr text,long length,StScrpHandle hST,TEHandle hTE)
    = {0x3F3C,0x0007,0xA83D}; 
pascal long TEGetHeight(long endLine,long startLine,TEHandle hTE)
    = {0x3F3C,0x0009,0xA83D}; 
pascal Boolean TEContinuousStyle(short *mode,TextStyle *aStyle,TEHandle hTE)
    = {0x3F3C,0x000A,0xA83D}; 
pascal void SetStylScrap(long rangeStart,long rangeEnd,StScrpHandle newStyles,
    Boolean redraw,TEHandle hTE)
    = {0x3F3C,0x000B,0xA83D}; 
pascal void TECustomHook(TEIntHook which,ProcPtr *addr,TEHandle hTE)
    = {0x3F3C,0x000C,0xA83D}; 
pascal long TENumStyles(long rangeStart,long rangeEnd,TEHandle hTE)
    = {0x3F3C,0x000D,0xA83D}; 
pascal long TEGetScrapLen(void); 
pascal void TESetScrapLen(long length); 
pascal OSErr TEFromScrap(void); 
pascal OSErr TEToScrap(void); 
pascal void SetClikLoop(ClikLoopProcPtr clikProc,TEHandle hTE); 
pascal void SetWordBreak(WordBreakProcPtr wBrkProc,TEHandle hTE); 
void teclick(Point *pt,Boolean fExtend,TEHandle h); 
#ifdef __safe_link
}
#endif

#endif

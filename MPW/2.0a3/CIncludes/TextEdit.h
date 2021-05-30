/*
	TextEdit.h -- Text Edit Manager interface
	
	Version: 2.0a3.1

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
	
	modifications:
	02/17/87	KLH	added new TE calls.
	9/mar/87	KLH teForceLeft	added for script manager in text edit.
*/

#ifndef __TEXTEDIT__
#define __TEXTEDIT__
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __TYPES__
#include <Types.h>
#endif

#define teJustLeft 0
#define teJustCenter 1
#define teJustRight (-1)
#define teForceLeft (-2)
typedef struct TERec {
	Rect destRect;
	Rect viewRect;
	Rect selRect;
	short lineHeight;
	short fontAscent;
	Point selPoint;
	short selStart;
	short selEnd;
	short active;
	ProcPtr wordBreak;
	ProcPtr clikLoop;
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
	Style txFace;			/* txFace is unpacked byte */
	char filler;
	short txMode;
	short txSize;
	struct GrafPort *inPort;
	ProcPtr highHook;
	ProcPtr caretHook;
	short nLines;
	short lineStarts[16001];
} TERec,*TEPtr,**TEHandle;
typedef char Chars[32001];
typedef Chars *CharsPtr,**CharsHandle;

pascal void TEInit()
	extern 0xA9CC;
pascal TEHandle TENew(destRect,viewRect)
	Rect *destRect,*viewRect;
	extern 0xA9D2;
pascal void TEDispose(hTE)
	TEHandle hTE;
	extern 0xA9CD;
pascal void TESetText(text,length,hTE)
	Ptr text;
	long length;
	TEHandle hTE;
	extern 0xA9CF;
pascal CharsHandle TEGetText(hTE)
	TEHandle hTE;
	extern 0xA9CB;
pascal void TEIdle(hTE)
	TEHandle hTE;
	extern 0xA9DA;
pascal void TESetSelect(selStart,selEnd,hTE)
	long selStart,selEnd;
	TEHandle hTE;
	extern 0xA9D1;
pascal void TEActivate(hTE)
	TEHandle hTE;
	extern 0xA9D8;
pascal void TEDeactivate(hTE)
	TEHandle hTE;
	extern 0xA9D9;
pascal void TEKey(key,hTE)
	short key;
	TEHandle hTE;
	extern 0xA9DC;
pascal void TECut(hTE)
	TEHandle hTE;
	extern 0xA9D6;
pascal void TECopy(hTE)
	TEHandle hTE;
	extern 0xA9D5;
pascal void TEPaste(hTE)
	TEHandle hTE;
	extern 0xA9DB;
pascal void TEDelete(hTE)
	TEHandle hTE;
	extern 0xA9D7;
pascal void TEInsert(text,length,hTE)
	Ptr text;
	long length;
	TEHandle hTE;
	extern 0xA9DE;
pascal void TESetJust(just,hTE)
	short just;
	TEHandle hTE;
	extern 0xA9DF;
pascal void TEUpdate(rUpdate,hTE)
	Rect *rUpdate;
	TEHandle hTE;
	extern 0xA9D3;
pascal void TextBox(text,length,box,just)
	Ptr text;
	long length;
	Rect *box;
	short just;
	extern 0xA9CE;
pascal void TEScroll(dh,dv,hTE)
	short dh,dv;
	TEHandle hTE;
	extern 0xA9DD;
pascal void TESelView(hTE)
	TEHandle hTE;
	extern 0xA811;
pascal void TEPinScroll(dh,dv,hTE)
	short dh,dv;
	TEHandle hTE;
	extern 0xA812;
pascal void TEAutoView(pAuto,hTE)
	Boolean pAuto;
	TEHandle hTE;
	extern 0xA813;
Handle TEScrapHandle();
pascal void TECalText(hTE)
	TEHandle hTE;
	extern 0xA9D0;



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


#define doFont			1				/* set font (family) number */
#define doFace			2				/* set character style */
#define doSize			4				/* set type size */
#define doColor			8				/* set color */
#define doAll			15				/* set all attributes */
#define addSize			16				/* adjust type size */
		

typedef struct StyleRun{
	short			startChar;			/* starting character position */
	short			styleIndex; 		/* index in style table */
} StyleRun;

typedef struct STElement{
	short			stCount;			/* number of runs in this style */
	short			stHeight;			/* line height */
	short			stAscent;			/* font ascent */
	short			stFont;				/* font (family) number */
	Style			stFace;				/* character Style */
	char			filler;				/* stFace is unpacked byte */
	short			stSize;				/* size in points */
	RGBColor		stColor;			/* absolute (RGB) color */
} STElement;

typedef STElement TEStyleTable[1777], *STPtr, **STHandle;
		
typedef struct LHElement{
	short			lhHeight;			/* maximum height in line */
	short			lhAscent;			/* maximum ascent in line */
} LHElement;
						  
typedef LHElement LHTable[8001], *LHPtr, **LHHandle;
										/* ARRAY [0..8000] OF LHElement */

typedef struct TEStyleRec{
	short			nRuns;				/* number of style runs */
	short			nStyles;			/* size of style table */
	STHandle		styleTab;			/* handle to style table */
	LHHandle		lhTab;				/* handle to line-height table */
	long			teRefCon;			/* reserved for application use */
	long			teReserved;			/* reserved for future expansion */
	StyleRun		runs[8001];			/* ARRAY [0..8000] OF StyleRun */
} TEStyleRec, *TEStylePtr, **TEStyleHandle;

typedef struct TextStyle{
	short			tsFont;				/* font (family) number */
	Style			tsFace;				/* character Style */
	char			filler;				/* tsFace is unpacked byte */
	short			tsSize;				/* size in point */
	RGBColor		tsColor;			/* absolute (RGB) color */
} TextStyle;

typedef struct ScrpSTElement{
	long			scrpStartChar; 		/* starting character position */
	short			scrpHeight;
	short			scrpAscent;
	short			scrpFont;
	Style			scrpFace;			/* unpacked byte */
	char			filler;				/* scrpFace is unpacked byte */
	short			scrpSize;
	RGBColor		scrpColor;
} ScrpSTElement;
		
typedef ScrpSTElement ScrpSTTable[1601];	/* ARRAY [0..1600] OF ScrpSTElement */

typedef struct StScrpRec{
	short			scrpNStyles;			/* number of styles in scrap */
	ScrpSTTable		scrpStyleTab;			/* table of styles for scrap */
} StScrpRec, *StScrpPtr, **StScrpHandle;
	  


pascal TEHandle TEStylNew(destRect, viewRect)
	Rect destRect, viewRect;
	extern 0xA83E;
pascal void SetStylHandle(theHandle, hTE)
	TEStyleHandle theHandle;
	TEHandle hTE;
	extern;
pascal TEStyleHandle GetStylHandle(hTE)
	TEHandle hTE;
	extern;
pascal short TEGetOffset(pt, hTE)
	Point pt;
	TEHandle hTE;
	extern 0xA83C;
pascal void TEGetStyle(offset, theStyle, lineHeight, fontAscent, hTE)
	short offset;
	TextStyle *theStyle;
	short *lineHeight;
	short *fontAscent;
	TEHandle hTE;
	extern;
pascal void TEStylPaste(hTE)
	TEHandle hTE;
	extern;
pascal void TESetStyle(mode, newStyle, redraw, hTE)
	short mode;
	TextStyle newStyle;
	Boolean redraw;
	TEHandle hTE;
	extern;
pascal void TEReplaceStyle(mode, oldStyle, newStyle, redraw, hTE)
	short mode;
	TextStyle oldStyle, newStyle;
	Boolean redraw;
	TEHandle hTE;
	extern;
pascal StScrpHandle GetStylScrap(hTE)
	TEHandle hTE;
	extern;
pascal void TEStylInsert(text, length, hST, hTE)
	Ptr text;
	long length;
	StScrpHandle hST;
	TEHandle hTE;
	extern;
pascal Point TEGetPoint(offset, hTE)
	short offset;
	TEHandle hTE;
	extern;
pascal long TEGetHeight(startLine, endLine, hTE)
	long startLine;
	long endLine;
	TEHandle hTE;
	extern;
					  
			
#endif
#endif

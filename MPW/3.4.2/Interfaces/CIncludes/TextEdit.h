/*
 	File:		TextEdit.h
 
 	Contains:	TextEdit Interfaces.
 
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

#ifndef __TEXTEDIT__
#define __TEXTEDIT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
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

typedef struct TERec TERec, *TEPtr, **TEHandle;

/* 
	Important note about TEClickLoopProcPtr and WordBreakProcPtr

	At one point these were defined as returning the function result in the 
	condition code Z-bit.  This was correct, in that it was what the 68K
	implementation of TextEdit actually tested.  But, MixedMode had a different 
	idea of what returning a boolean in the Z-bit meant.  MixedMode was setting
	the Z-bit the complement of what was wanted.  
	
	Therefore, these ProcPtrs have been changed (back) to return the result in
	register D0.  It turns out that for register based routines, 
	MixedMode sets the Z-bit of the 68K emulator based on the contents 
	of the return result register.  Thus we can get the Z-bit set correctly.  
	
	But, when TextEdit is recoded in PowerPC, if it calls a 68K ClickLoop
	or WordBreak routine, register D0 had better have the result (in addition
	to the Z-bit). Therefore all 68K apps should make sure their ClickLoop or
	WordBreak routines set register D0 at the end.
*/
/*
	The following ProcPtrs cannot be written in or called from a high-level 
	language without the help of mixed mode or assembly glue because they 
	use the following parameter-passing conventions:

	typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
	typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);

		In:
			=> 	r						on stack
			=>	pTE						A3.L
		Out:
			none

	typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);

		In:
			=> 	theChar					D0.B
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	Boolean					Z bit of the CCR

	typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
	typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen,
	 unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textLen					D0.W
			=>	textOffset				D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, 
	 short *lineStart, TEPtr pTE, TEHandle hTE);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W (low)
			=>	direction				D2.W (high)
			=>	textBufferPtr			A0.L
			=>	lineStart				A2.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	unsigned short			D1.W

	typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen,
	 void *textBufferPtr, TEPtr pTE, TEHandle hTE);

		In:
			=> 	textOffset				D0.W
			=>	drawLen					D1.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			none

	typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen,
	 unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr,
	 TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, 
	 Boolean *pixelInChar);

		In:
			=> 	styleRunLen				D0.W
			=>	styleRunOffset			D1.W
			=>	slop					D2.W
			=>	textBufferPtr			A0.L
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	pixelWidth				D0.W (low)
			<=	Boolean					D0.W (high)
			<=	charOffset				D1.W
			<=	pixelInChar				D2.W

	typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, 
	 TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);

		In:
			=> 	currentPos				D0.W
			=>	caller					D2.W
			=>	pTE						A3.L
			=>	hTE						A4.L
		Out:
			<=	wordStart				D0.W
			<=	wordEnd					D1.W

	typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength,
  	 unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);

		In:
			=> 	pTE						A3.L
			=>	changeLength			D7.W
		Out:
			<=	lineStart				D2.W
			<=	firstChar				D3.W
			<=	lastChar				D4.W

	typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar,
	 					short selector, GrafPtr *currentGrafPort, short *charPosition);

		In:
			=> 	pTE						A3.L
			=>	firstChar				D3.W
			=>	lastChar				D4.W
			=>	selector				D7.W
		Out:
			<=	currentGrafPort			A0.L
			<=	charPosition			D0.W
			
*/
typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);
typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);
typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen, unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen, unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen, unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, short *lineStart, TEPtr pTE, TEHandle hTE);
typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen, unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr, TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, Boolean *pixelInChar);
typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);
typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength, unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);
typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar, short selector, GrafPtr *currentGrafPort, short *charPosition);
/*
		TEClickLoopProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal Boolean (*TEClickLoopProcPtr)(TEPtr pTE);

		In:
		 => pTE         	A3.L
		Out:
		 <= return value	D0.B
*/
/*
		WordBreakProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal Boolean (*WordBreakProcPtr)(Ptr text, short charPos);

		In:
		 => text        	A0.L
		 => charPos     	D0.W
		Out:
		 <= return value	D0.B
*/

#if GENERATINGCFM
typedef UniversalProcPtr HighHookUPP;
typedef UniversalProcPtr EOLHookUPP;
typedef UniversalProcPtr CaretHookUPP;
typedef UniversalProcPtr WidthHookUPP;
typedef UniversalProcPtr TextWidthHookUPP;
typedef UniversalProcPtr NWidthHookUPP;
typedef UniversalProcPtr DrawHookUPP;
typedef UniversalProcPtr HitTestHookUPP;
typedef UniversalProcPtr TEFindWordUPP;
typedef UniversalProcPtr TERecalcUPP;
typedef UniversalProcPtr TEDoTextUPP;
typedef UniversalProcPtr TEClickLoopUPP;
typedef UniversalProcPtr WordBreakUPP;
#else
typedef Register68kProcPtr HighHookUPP;
typedef Register68kProcPtr EOLHookUPP;
typedef Register68kProcPtr CaretHookUPP;
typedef Register68kProcPtr WidthHookUPP;
typedef Register68kProcPtr TextWidthHookUPP;
typedef Register68kProcPtr NWidthHookUPP;
typedef Register68kProcPtr DrawHookUPP;
typedef Register68kProcPtr HitTestHookUPP;
typedef Register68kProcPtr TEFindWordUPP;
typedef Register68kProcPtr TERecalcUPP;
typedef Register68kProcPtr TEDoTextUPP;
typedef Register68kProcPtr TEClickLoopUPP;
typedef Register68kProcPtr WordBreakUPP;
#endif

struct TERec {
	Rect							destRect;
	Rect							viewRect;
	Rect							selRect;
	short							lineHeight;
	short							fontAscent;
	Point							selPoint;
	short							selStart;
	short							selEnd;
	short							active;
	WordBreakUPP					wordBreak;
	TEClickLoopUPP					clickLoop;
	long							clickTime;
	short							clickLoc;
	long							caretTime;
	short							caretState;
	short							just;
	short							teLength;
	Handle							hText;
	long							hDispatchRec;				/* added to replace recalBack & recalLines.  it's a handle anyway */
	short							clikStuff;
	short							crOnly;
	short							txFont;
	Style							txFace;						/*txFace is unpacked byte*/
	SInt8							filler;
	short							txMode;
	short							txSize;
	GrafPtr							inPort;
	HighHookUPP						highHook;
	CaretHookUPP					caretHook;
	short							nLines;
	short							lineStarts[16001];
};

enum {
/* Justification (word alignment) styles */
	teJustLeft					= 0,
	teJustCenter				= 1,
	teJustRight					= -1,
	teForceLeft					= -2,
/* new names for the Justification (word alignment) styles */
	teFlushDefault				= 0,							/*flush according to the line direction */
	teCenter					= 1,							/*center justify (word alignment) */
	teFlushRight				= -1,							/*flush right for all scripts */
	teFlushLeft					= -2,							/*flush left for all scripts */
/* Set/Replace style modes */
	fontBit						= 0,							/*set font*/
	faceBit						= 1,							/*set face*/
	sizeBit						= 2,							/*set size*/
	clrBit						= 3,							/*set color*/
	addSizeBit					= 4,							/*add size mode*/
	toggleBit					= 5,							/*set faces in toggle mode*/
	toglBit						= 5,							/* obsolete.  use toggleBit */
/* TESetStyle/TEContinuousStyle modes */
	doFont						= 1,							/* set font (family) number*/
	doFace						= 2,							/*set character style*/
	doSize						= 4,							/*set type size*/
	doColor						= 8,							/*set color*/
	doAll						= 15,							/*set all attributes*/
	addSize						= 16							/*adjust type size*/
};

enum {
	doToggle					= 32,							/*toggle mode for TESetStyle*/
/* offsets into TEDispatchRec */
	EOLHook						= 0,							/*[UniversalProcPtr] TEEOLHook*/
	DRAWHook					= 4,							/*[UniversalProcPtr] TEWidthHook*/
	WIDTHHook					= 8,							/*[UniversalProcPtr] TEDrawHook*/
	HITTESTHook					= 12,							/*[UniversalProcPtr] TEHitTestHook*/
	nWIDTHHook					= 24,							/*[UniversalProcPtr] nTEWidthHook*/
	TextWidthHook				= 28,							/*[UniversalProcPtr] TETextWidthHook*/
/* selectors for TECustomHook */
	intEOLHook					= 0,							/*TEIntHook value*/
	intDrawHook					= 1,							/*TEIntHook value*/
	intWidthHook				= 2,							/*TEIntHook value*/
	intHitTestHook				= 3,							/*TEIntHook value*/
	intNWidthHook				= 6,							/*TEIntHook value for new version of WidthHook*/
	intTextWidthHook			= 7,							/*TEIntHook value for new TextWidthHook*/
	teFAutoScroll				= 0,							/*00000001b*/
	teFAutoScr					= 0,							/*00000001b  obsolete. use teFAutoScroll*/
	teFTextBuffering			= 1,							/*00000010b*/
	teFOutlineHilite			= 2,							/*00000100b*/
	teFInlineInput				= 3,							/*00001000b */
	teFUseTextServices			= 4								/*00010000b */
};

enum {
/* action for the new "bit (un)set" interface, TEFeatureFlag */
	teBitClear					= 0,
	teBitSet					= 1,							/*set the selector bit*/
	teBitTest					= -1,							/*no change; just return the current setting*/
/*constants for identifying the routine that called FindWord */
	teWordSelect				= 4,							/*clickExpand to select word*/
	teWordDrag					= 8,							/*clickExpand to drag new word*/
	teFromFind					= 12,							/*FindLine called it ($0C)*/
	teFromRecal					= 16,							/*RecalLines called it ($10)      obsolete */
/*constants for identifying TEDoText selectors */
	teFind						= 0,							/*TEDoText called for searching*/
	teHighlight					= 1,							/*TEDoText called for highlighting*/
	teDraw						= -1,							/*TEDoText called for drawing text*/
	teCaret						= -2							/*TEDoText called for drawing the caret*/
};

#if OLDROUTINENAMES
enum {
	TEBitClear					= 0,
	TEBitSet					= 1,							/*set the selector bit*/
	TEBitTest					= -1							/*no change; just return the current setting*/
};

#endif
typedef char Chars[32001];

typedef char *CharsPtr;

typedef CharsPtr *CharsHandle;

struct StyleRun {
	short							startChar;					/*starting character position*/
	short							styleIndex;					/*index in style table*/
};
typedef struct StyleRun StyleRun;

struct STElement {
	short							stCount;					/*number of runs in this style*/
	short							stHeight;					/*line height*/
	short							stAscent;					/*font ascent*/
	short							stFont;						/*font (family) number*/
	Style							stFace;						/*character Style*/
	SInt8							filler;						/*stFace is unpacked byte*/
	short							stSize;						/*size in points*/
	RGBColor						stColor;					/*absolute (RGB) color*/
};
typedef struct STElement STElement;

typedef STElement TEStyleTable[1777];

typedef STElement *STPtr, **STHandle;

struct LHElement {
	short							lhHeight;					/*maximum height in line*/
	short							lhAscent;					/*maximum ascent in line*/
};
typedef struct LHElement LHElement;

typedef LHElement LHTable[8001];

typedef LHElement *LHPtr, **LHHandle;

struct ScrpSTElement {
	long							scrpStartChar;				/*starting character position*/
	short							scrpHeight;					/*starting character position*/
	short							scrpAscent;
	short							scrpFont;
	Style							scrpFace;					/*unpacked byte*/
	SInt8							filler;						/*scrpFace is unpacked byte*/
	short							scrpSize;
	RGBColor						scrpColor;
};
typedef struct ScrpSTElement ScrpSTElement;

/* ARRAY [0..1600] OF ScrpSTElement */
typedef ScrpSTElement ScrpSTTable[1601];

struct StScrpRec {
	short							scrpNStyles;				/*number of styles in scrap*/
	ScrpSTTable						scrpStyleTab;				/*table of styles for scrap*/
};
typedef struct StScrpRec StScrpRec;

typedef StScrpRec *StScrpPtr, **StScrpHandle;

struct NullStRec {
	long							teReserved;					/*reserved for future expansion*/
	StScrpHandle					nullScrap;					/*handle to scrap style table*/
};
typedef struct NullStRec NullStRec;

typedef NullStRec *NullStPtr, **NullStHandle;

struct TEStyleRec {
	short							nRuns;						/*number of style runs*/
	short							nStyles;					/*size of style table*/
	STHandle						styleTab;					/*handle to style table*/
	LHHandle						lhTab;						/*handle to line-height table*/
	long							teRefCon;					/*reserved for application use*/
	NullStHandle					nullStyle;					/*Handle to style set at null selection*/
	StyleRun						runs[8001];					/*ARRAY [0..8000] OF StyleRun*/
};
typedef struct TEStyleRec TEStyleRec;

typedef TEStyleRec *TEStylePtr, **TEStyleHandle;

struct TextStyle {
	short							tsFont;						/*font (family) number*/
	Style							tsFace;						/*character Style*/
	SInt8							filler;						/*tsFace is unpacked byte*/
	short							tsSize;						/*size in point*/
	RGBColor						tsColor;					/*absolute (RGB) color*/
};
typedef struct TextStyle TextStyle;

typedef TextStyle *TextStylePtr, **TextStyleHandle;

typedef short TEIntHook;


#if GENERATINGCFM
#else
#endif

enum {
	uppHighHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseHighHook ),
	uppEOLHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseEOLHook ),
	uppCaretHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseCaretHook ),
	uppWidthHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseWidthHook ),
	uppTextWidthHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseTextWidthHook ),
	uppNWidthHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseNWidthHook ),
	uppDrawHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseDrawHook ),
	uppHitTestHookProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseHitTestHook ),
	uppTEFindWordProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseTEFindWord ),
	uppTERecalcProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseTERecalc ),
	uppTEDoTextProcInfo = SPECIAL_CASE_PROCINFO( kSpecialCaseTEDoText ),
	uppTEClickLoopProcInfo = kRegisterBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | REGISTER_RESULT_LOCATION(kRegisterD0)
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA3, SIZE_CODE(sizeof(TEPtr))),
	uppWordBreakProcInfo = kRegisterBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | REGISTER_RESULT_LOCATION(kRegisterD0)
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterA0, SIZE_CODE(sizeof(Ptr)))
		 | REGISTER_ROUTINE_PARAMETER(2, kRegisterD0, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewHighHookProc(userRoutine)		\
		(HighHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppHighHookProcInfo, GetCurrentArchitecture())
#define NewEOLHookProc(userRoutine)		\
		(EOLHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppEOLHookProcInfo, GetCurrentArchitecture())
#define NewCaretHookProc(userRoutine)		\
		(CaretHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCaretHookProcInfo, GetCurrentArchitecture())
#define NewWidthHookProc(userRoutine)		\
		(WidthHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppWidthHookProcInfo, GetCurrentArchitecture())
#define NewTextWidthHookProc(userRoutine)		\
		(TextWidthHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTextWidthHookProcInfo, GetCurrentArchitecture())
#define NewNWidthHookProc(userRoutine)		\
		(NWidthHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppNWidthHookProcInfo, GetCurrentArchitecture())
#define NewDrawHookProc(userRoutine)		\
		(DrawHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDrawHookProcInfo, GetCurrentArchitecture())
#define NewHitTestHookProc(userRoutine)		\
		(HitTestHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppHitTestHookProcInfo, GetCurrentArchitecture())
#define NewTEFindWordProc(userRoutine)		\
		(TEFindWordUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTEFindWordProcInfo, GetCurrentArchitecture())
#define NewTERecalcProc(userRoutine)		\
		(TERecalcUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTERecalcProcInfo, GetCurrentArchitecture())
#define NewTEDoTextProc(userRoutine)		\
		(TEDoTextUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTEDoTextProcInfo, GetCurrentArchitecture())
#define NewTEClickLoopProc(userRoutine)		\
		(TEClickLoopUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTEClickLoopProcInfo, GetCurrentArchitecture())
#define NewWordBreakProc(userRoutine)		\
		(WordBreakUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppWordBreakProcInfo, GetCurrentArchitecture())
#else
#define NewHighHookProc(userRoutine)		\
		((HighHookUPP) (userRoutine))
#define NewEOLHookProc(userRoutine)		\
		((EOLHookUPP) (userRoutine))
#define NewCaretHookProc(userRoutine)		\
		((CaretHookUPP) (userRoutine))
#define NewWidthHookProc(userRoutine)		\
		((WidthHookUPP) (userRoutine))
#define NewTextWidthHookProc(userRoutine)		\
		((TextWidthHookUPP) (userRoutine))
#define NewNWidthHookProc(userRoutine)		\
		((NWidthHookUPP) (userRoutine))
#define NewDrawHookProc(userRoutine)		\
		((DrawHookUPP) (userRoutine))
#define NewHitTestHookProc(userRoutine)		\
		((HitTestHookUPP) (userRoutine))
#define NewTEFindWordProc(userRoutine)		\
		((TEFindWordUPP) (userRoutine))
#define NewTERecalcProc(userRoutine)		\
		((TERecalcUPP) (userRoutine))
#define NewTEDoTextProc(userRoutine)		\
		((TEDoTextUPP) (userRoutine))
#define NewTEClickLoopProc(userRoutine)		\
		((TEClickLoopUPP) (userRoutine))
#define NewWordBreakProc(userRoutine)		\
		((WordBreakUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallHighHookProc(userRoutine, r, pTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppHighHookProcInfo, (r), (pTE))
#define CallEOLHookProc(userRoutine, theChar, pTE, hTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppEOLHookProcInfo, (theChar), (pTE), (hTE))
#define CallCaretHookProc(userRoutine, r, pTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCaretHookProcInfo, (r), (pTE))
#define CallWidthHookProc(userRoutine, textLen, textOffset, textBufferPtr, pTE, hTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppWidthHookProcInfo, (textLen), (textOffset), (textBufferPtr), (pTE), (hTE))
#define CallTextWidthHookProc(userRoutine, textLen, textOffset, textBufferPtr, pTE, hTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTextWidthHookProcInfo, (textLen), (textOffset), (textBufferPtr), (pTE), (hTE))
#define CallNWidthHookProc(userRoutine, styleRunLen, styleRunOffset, slop, direction, textBufferPtr, lineStart, pTE, hTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppNWidthHookProcInfo, (styleRunLen), (styleRunOffset), (slop), (direction), (textBufferPtr), (lineStart), (pTE), (hTE))
#define CallDrawHookProc(userRoutine, textOffset, drawLen, textBufferPtr, pTE, hTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDrawHookProcInfo, (textOffset), (drawLen), (textBufferPtr), (pTE), (hTE))
#define CallHitTestHookProc(userRoutine, styleRunLen, styleRunOffset, slop, textBufferPtr, pTE, hTE, pixelWidth, charOffset, pixelInChar)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppHitTestHookProcInfo, (styleRunLen), (styleRunOffset), (slop), (textBufferPtr), (pTE), (hTE), (pixelWidth), (charOffset), (pixelInChar))
#define CallTEFindWordProc(userRoutine, currentPos, caller, pTE, hTE, wordStart, wordEnd)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTEFindWordProcInfo, (currentPos), (caller), (pTE), (hTE), (wordStart), (wordEnd))
#define CallTERecalcProc(userRoutine, pTE, changeLength, lineStart, firstChar, lastChar)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTERecalcProcInfo, (pTE), (changeLength), (lineStart), (firstChar), (lastChar))
#define CallTEDoTextProc(userRoutine, pTE, firstChar, lastChar, selector, currentGrafPort, charPosition)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTEDoTextProcInfo, (pTE), (firstChar), (lastChar), (selector), (currentGrafPort), (charPosition))
#define CallTEClickLoopProc(userRoutine, pTE)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTEClickLoopProcInfo, (pTE))
#define CallWordBreakProc(userRoutine, text, charPos)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppWordBreakProcInfo, (text), (charPos))
#else
/* (*HighHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*EOLHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*CaretHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*WidthHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*TextWidthHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*NWidthHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*DrawHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*HitTestHookProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*TEFindWordProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*TERecalcProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*TEDoTextProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*TEClickLoopProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
/* (*WordBreakProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#endif

extern pascal Handle TEScrapHandle( void )
	TWOWORDINLINE( 0x2EB8, 0x0AB4 ); /* MOVE.l $0AB4,(SP) */
#if GENERATINGCFM
extern pascal long TEGetScrapLength(void);
#else
#define TEGetScrapLength() ((long) * (unsigned short *) 0x0AB0)
#endif
extern pascal void TEInit(void)
 ONEWORDINLINE(0xA9CC);
extern pascal TEHandle TENew(const Rect *destRect, const Rect *viewRect)
 ONEWORDINLINE(0xA9D2);
extern pascal void TEDispose(TEHandle hTE)
 ONEWORDINLINE(0xA9CD);
extern pascal void TESetText(const void *text, long length, TEHandle hTE)
 ONEWORDINLINE(0xA9CF);
extern pascal CharsHandle TEGetText(TEHandle hTE)
 ONEWORDINLINE(0xA9CB);
extern pascal void TEIdle(TEHandle hTE)
 ONEWORDINLINE(0xA9DA);
extern pascal void TESetSelect(long selStart, long selEnd, TEHandle hTE)
 ONEWORDINLINE(0xA9D1);
extern pascal void TEActivate(TEHandle hTE)
 ONEWORDINLINE(0xA9D8);
extern pascal void TEDeactivate(TEHandle hTE)
 ONEWORDINLINE(0xA9D9);
extern pascal void TEKey(short key, TEHandle hTE)
 ONEWORDINLINE(0xA9DC);
extern pascal void TECut(TEHandle hTE)
 ONEWORDINLINE(0xA9D6);
extern pascal void TECopy(TEHandle hTE)
 ONEWORDINLINE(0xA9D5);
extern pascal void TEPaste(TEHandle hTE)
 ONEWORDINLINE(0xA9DB);
extern pascal void TEDelete(TEHandle hTE)
 ONEWORDINLINE(0xA9D7);
extern pascal void TEInsert(const void *text, long length, TEHandle hTE)
 ONEWORDINLINE(0xA9DE);
extern pascal void TESetAlignment(short just, TEHandle hTE)
 ONEWORDINLINE(0xA9DF);
extern pascal void TEUpdate(const Rect *rUpdate, TEHandle hTE)
 ONEWORDINLINE(0xA9D3);
extern pascal void TETextBox(const void *text, long length, const Rect *box, short just)
 ONEWORDINLINE(0xA9CE);
extern pascal void TEScroll(short dh, short dv, TEHandle hTE)
 ONEWORDINLINE(0xA9DD);
extern pascal void TESelView(TEHandle hTE)
 ONEWORDINLINE(0xA811);
extern pascal void TEPinScroll(short dh, short dv, TEHandle hTE)
 ONEWORDINLINE(0xA812);
extern pascal void TEAutoView(Boolean fAuto, TEHandle hTE)
 ONEWORDINLINE(0xA813);
extern pascal void TECalText(TEHandle hTE)
 ONEWORDINLINE(0xA9D0);
extern pascal short TEGetOffset(Point pt, TEHandle hTE)
 ONEWORDINLINE(0xA83C);
extern pascal Point TEGetPoint(short offset, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0008, 0xA83D);
extern pascal void TEClick(Point pt, Boolean fExtend, TEHandle h)
 ONEWORDINLINE(0xA9D4);
extern pascal TEHandle TEStyleNew(const Rect *destRect, const Rect *viewRect)
 ONEWORDINLINE(0xA83E);
extern pascal void TESetStyleHandle(TEStyleHandle theHandle, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0005, 0xA83D);
extern pascal TEStyleHandle TEGetStyleHandle(TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xA83D);
extern pascal void TEGetStyle(short offset, TextStyle *theStyle, short *lineHeight, short *fontAscent, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0003, 0xA83D);
extern pascal void TEStylePaste(TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0000, 0xA83D);
extern pascal void TESetStyle(short mode, const TextStyle *newStyle, Boolean fRedraw, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0001, 0xA83D);
extern pascal void TEReplaceStyle(short mode, const TextStyle *oldStyle, const TextStyle *newStyle, Boolean fRedraw, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0002, 0xA83D);
extern pascal StScrpHandle TEGetStyleScrapHandle(TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0006, 0xA83D);
extern pascal void TEStyleInsert(const void *text, long length, StScrpHandle hST, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0007, 0xA83D);
extern pascal long TEGetHeight(long endLine, long startLine, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x0009, 0xA83D);
extern pascal Boolean TEContinuousStyle(short *mode, TextStyle *aStyle, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000A, 0xA83D);
extern pascal void TEUseStyleScrap(long rangeStart, long rangeEnd, StScrpHandle newStyles, Boolean fRedraw, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000B, 0xA83D);
extern pascal void TECustomHook(TEIntHook which, UniversalProcPtr *addr, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000C, 0xA83D);
extern pascal long TENumStyles(long rangeStart, long rangeEnd, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000D, 0xA83D);
extern pascal short TEFeatureFlag(short feature, short action, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000E, 0xA83D);
extern pascal OSErr TEGetHiliteRgn(RgnHandle region, TEHandle hTE)
 THREEWORDINLINE(0x3F3C, 0x000F, 0xA83D);
extern pascal void TESetScrapLength(long length);
extern pascal OSErr TEFromScrap(void);
extern pascal OSErr TEToScrap(void);
extern pascal void TESetClickLoop(TEClickLoopUPP clikProc, TEHandle hTE);
extern pascal void TESetWordBreak(WordBreakUPP wBrkProc, TEHandle hTE);
/* 
	There is no function to get/set the low-mem for FindWordHook at 0x07F8.
	This is because it is not a low-mem ProcPtr. That address is the entry
	in the OS TrapTable for trap 0xA0FE.  You can use Get/SetTrapAddress to 
	acccess it.	
*/
#if CGLUESUPPORTED
extern void teclick(Point *pt, Boolean fExtend, TEHandle h);
#endif
#if OLDROUTINENAMES
#define TESetJust(just, hTE) TESetAlignment(just, hTE)
#define TextBox(text, length, box, just) TETextBox(text, length, box, just)
#define TEStylNew(destRect, viewRect) TEStyleNew(destRect, viewRect)
#define SetStylHandle(theHandle, hTE) TESetStyleHandle(theHandle, hTE)
#define SetStyleHandle(theHandle, hTE) TESetStyleHandle (theHandle, hTE)
#define GetStylHandle(hTE) TEGetStyleHandle(hTE)
#define GetStyleHandle(hTE) TEGetStyleHandle(hTE)
#define TEStylPaste(hTE) TEStylePaste(hTE)
#define GetStylScrap(hTE) TEGetStyleScrapHandle(hTE)
#define GetStyleScrap(hTE) TEGetStyleScrapHandle(hTE)
#define SetStylScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)  \
	TEUseStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)
#define SetStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)  \
	TEUseStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)
#define TEStylInsert(text, length, hST, hTE) TEStyleInsert(text, length, hST, hTE)
#define TESetScrapLen(length) TESetScrapLength(length)
#define TEGetScrapLen() TEGetScrapLength()
#define SetClikLoop(clikProc, hTE) TESetClickLoop(clikProc, hTE)
#define SetWordBreak(wBrkProc, hTE) TESetWordBreak(wBrkProc, hTE)
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

#endif /* __TEXTEDIT__ */

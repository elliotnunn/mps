/*
	Textedit.h -- Text Edit

	C Interface to the Macintosh Libraries
	Copyright (c) 1985,1986 Apple Computer,Inc. All rights reserved.
*/

#ifndef __TEXTEDIT__
#define __TEXTEDIT__
#ifndef __TYPES__
#include <Types.h>
#endif

#define teJustLeft 0
#define teJustCenter 1
#define teJustRight (-1)
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
	Style txFace;
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
#endif

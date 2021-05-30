/************************************************************

Created: Thursday, September 7, 1989 at 9:11 PM
	CursorCtl.h
	C Interface to the Macintosh Libraries


	
	<<< CursorCtl - Cursor Control Header File >>>
	
	Copyright Apple Computer, Inc. 1985-1989
	All rights reserved
	
	This file contains:
	
	InitCursorCtl(newCursors) - Init CursorCtl to load the 'acur' resource
	RotateCursor(counter)	  - Sequence through cursor frames for counter mod 32
	SpinCursor(increment)	  - Sequence mod 32 incrementing internal counter
	Hide_Cursor()			  - Hide the current cursor
	Show_Cursor(cursorKind)   - Show the cursor

************************************************************/


#ifndef __CURSORCTL__
#define __CURSORCTL__

enum {HIDDEN_CURSOR,I_BEAM_CURSOR,CROSS_CURSOR,PLUS_CURSOR,WATCH_CURSOR,
	ARROW_CURSOR};
typedef unsigned char Cursors;

struct Acur {
	short n;		/*Number of cursors ("frames of film")*/
	short index;	/* Next frame to show <for internal use>*/
	short frame1;	/*'CURS' resource id for frame #1*/
	short fill1;	/*<for internal use>*/
	short frame2;	/*'CURS' resource id for frame #2*/
	short fill2;	/*<for internal use>*/
	short frameN;	/*'CURS' resource id for frame #N*/
	short fillN;	/*<for internal use>*/
};

typedef struct Acur acur,*acurPtr,**acurHandle;

#ifdef __cplusplus
extern "C" {
#endif
pascal void InitCursorCtl(acurHandle newCursors);
pascal void RotateCursor(long counter); 
pascal void SpinCursor(short increment);
pascal void Hide_Cursor(void);
pascal void Show_Cursor(Cursors cursorKind);
#ifdef __cplusplus
}
#endif

#endif

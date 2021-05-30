/*
	File:		InlineInputSample.h

	Contains:	Rez and C definitions shared between InlineInputSample.r and InlineInputSample.c

	Copyright:	© 1993 Apple Computer, Inc. All rights reserved.

*/


#ifndef __INLINEINPUTSAMPLE__
#define __INLINEINPUTSAMPLE__


//	Menus and menu items. Menu IDs use the prefix "m", menu items "i"

#define	mApple					128		// Apple menu
#define	iAbout					1

#define	mFile					129		// File menu
#define	iNew					1
#define iOpen					2
#define	iClose					4
#define iSave					5
#define iPageSetup				7
#define iPrint					8
#define	iQuit					10

#define	mEdit					130		// Edit menu
#define	iUndo					1
#define	iCut					3
#define	iCopy					4
#define	iPaste					5
#define	iClear					6
#define iSelectAll				8

#define mFont					131		// Font menu

#define mFontSize				132		// Size menu
#define iNine					1
#define iTen					2
#define iTwelve					3
#define iFourteen				4
#define iEighteen				5
#define iTwentyFour				6

#define mStyle					133		// Style menu
#define iPlain					1
#define iBold					3
#define iItalic					4
#define	iUnderline				5
#define iOutline				6
#define iShadow					7


// Other resources, using prefix "r"

#define	rMenuBar				128		// application's menu bar
#define	rAboutAlert				128		// about alert
#define	rUserAlert				129		// user error alert
#define	rDocWindow				128		// text document window
#define	rVScroll				128		// vertical scrollbar control
#define	rHScroll				129		// horizontal scrollbar control
#define	rErrorStrings			128		// error string list


// Indices into STR# rErrorStrings, using prefix "e"

#define	eOldROM					1
#define eOldSystemSoftware		2
#define	eSmallSize				3
#define	eNoMemory				4
#define	eNoSpaceCut				5
#define	eNoCut					6
#define	eNoCopy					7
#define	eExceedPaste			8
#define	eNoSpacePaste			9
#define	eNoWindow				10
#define	eExceedChar				11
#define	eNoPaste				12

#endif

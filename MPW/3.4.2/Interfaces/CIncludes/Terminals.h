/*
 	File:		Terminals.h
 
 	Contains:	Communications Toolbox Terminal tool Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __TERMINALS__
#define __TERMINALS__


#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Memory.h>											*/
/*		#include <Types.h>										*/
/*		#include <MixedMode.h>									*/
/*	#include <Menus.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifndef __CTBUTILITIES__
#include <CTBUtilities.h>
#endif
/*	#include <StandardFile.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*	#include <AppleTalk.h>										*/

#ifndef __CONNECTIONS__
#include <Connections.h>
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
/* current Terminal Manager version 	*/
	curTMVersion				= 2,
/* current Terminal Manager Environment Record version 	*/
	curTermEnvRecVers			= 0,
/* error codes    */
	tmGenericError				= -1,
	tmNoErr						= 0,
	tmNotSent					= 1,
	tmEnvironsChanged			= 2,
	tmNotSupported				= 7,
	tmNoTools					= 8
};

typedef OSErr TMErr;


enum {
	tmInvisible					= 1 << 0,
	tmSaveBeforeClear			= 1 << 1,
	tmNoMenus					= 1 << 2,
	tmAutoScroll				= 1 << 3,
	tmConfigChanged				= 1 << 4
};

typedef unsigned long TMFlags;


enum {
	selTextNormal				= 1 << 0,
	selTextBoxed				= 1 << 1,
	selGraphicsMarquee			= 1 << 2,
	selGraphicsLasso			= 1 << 3,
	tmSearchNoDiacrit			= 1 << 8,
	tmSearchNoCase				= 1 << 9
};

typedef unsigned short TMSearchTypes;

typedef short TMSelTypes;


enum {
	cursorText					= 1,
	cursorGraphics				= 2
};

typedef unsigned short TMCursorTypes;


enum {
	tmTextTerminal				= 1 << 0,
	tmGraphicsTerminal			= 1 << 1
};

typedef unsigned short TMTermTypes;

struct TermDataBlock {
	TMTermTypes						flags;
	Handle							theData;
	Handle							auxData;
	long							reserved;
};
typedef struct TermDataBlock TermDataBlock;

typedef TermDataBlock *TermDataBlockPtr, **TermDataBlockH, **TermDataBlockHandle;

struct TermEnvironRec {
	short							version;
	TMTermTypes						termType;
	short							textRows;
	short							textCols;
	Point							cellSize;
	Rect							graphicSize;
	Point							slop;
	Rect							auxSpace;
};
typedef struct TermEnvironRec TermEnvironRec;

typedef TermEnvironRec *TermEnvironPtr;

union TMSelection {
	Rect							selRect;
	RgnHandle						selRgnHandle;
};
typedef union TMSelection TMSelection;

typedef struct TermRecord TermRecord, *TermPtr, **TermHandle;

typedef pascal long (*TerminalSendProcPtr)(Ptr thePtr, long theSize, long refCon, CMFlags flags);
typedef pascal void (*TerminalBreakProcPtr)(long duration, long refCon);
typedef pascal long (*TerminalCacheProcPtr)(long refCon, TermDataBlockPtr theTermData);
typedef pascal void (*TerminalSearchCallBackProcPtr)(TermHandle hTerm, short refNum, Rect *foundRect);
typedef pascal Boolean (*TerminalClikLoopProcPtr)(long refCon);
typedef pascal CMErr (*TerminalEnvironsProcPtr)(long refCon, ConnEnvironRec *theEnvirons);
typedef pascal void (*TerminalChooseIdleProcPtr)(void);
typedef pascal long (*TerminalToolDefProcPtr)(TermHandle hTerm, short msg, long p1, long p2, long p3);

#if GENERATINGCFM
typedef UniversalProcPtr TerminalSendUPP;
typedef UniversalProcPtr TerminalBreakUPP;
typedef UniversalProcPtr TerminalCacheUPP;
typedef UniversalProcPtr TerminalSearchCallBackUPP;
typedef UniversalProcPtr TerminalClikLoopUPP;
typedef UniversalProcPtr TerminalEnvironsUPP;
typedef UniversalProcPtr TerminalChooseIdleUPP;
typedef UniversalProcPtr TerminalToolDefUPP;
#else
typedef TerminalSendProcPtr TerminalSendUPP;
typedef TerminalBreakProcPtr TerminalBreakUPP;
typedef TerminalCacheProcPtr TerminalCacheUPP;
typedef TerminalSearchCallBackProcPtr TerminalSearchCallBackUPP;
typedef TerminalClikLoopProcPtr TerminalClikLoopUPP;
typedef TerminalEnvironsProcPtr TerminalEnvironsUPP;
typedef TerminalChooseIdleProcPtr TerminalChooseIdleUPP;
typedef TerminalToolDefProcPtr TerminalToolDefUPP;
#endif

struct TermRecord {
	short							procID;
	TMFlags							flags;
	TMErr							errCode;
	long							refCon;
	long							userData;
	TerminalToolDefUPP				defProc;
	Ptr								config;
	Ptr								oldConfig;
	TerminalEnvironsUPP				environsProc;
	long							reserved1;
	long							reserved2;
	Ptr								tmPrivate;
	TerminalSendUPP					sendProc;
	TerminalBreakUPP				breakProc;
	TerminalCacheUPP				cacheProc;
	TerminalClikLoopUPP				clikLoop;
	WindowPtr						owner;
	Rect							termRect;
	Rect							viewRect;
	Rect							visRect;
	long							lastIdle;
	TMSelection						selection;
	TMSelTypes						selType;
	long							mluField;
};
enum {
	uppTerminalSendProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(CMFlags))),
	uppTerminalBreakProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppTerminalCacheProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(TermDataBlockPtr))),
	uppTerminalSearchCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TermHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Rect*))),
	uppTerminalClikLoopProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long))),
	uppTerminalEnvironsProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(CMErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(ConnEnvironRec*))),
	uppTerminalChooseIdleProcInfo = kPascalStackBased,
	uppTerminalToolDefProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TermHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewTerminalSendProc(userRoutine)		\
		(TerminalSendUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalSendProcInfo, GetCurrentArchitecture())
#define NewTerminalBreakProc(userRoutine)		\
		(TerminalBreakUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalBreakProcInfo, GetCurrentArchitecture())
#define NewTerminalCacheProc(userRoutine)		\
		(TerminalCacheUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalCacheProcInfo, GetCurrentArchitecture())
#define NewTerminalSearchCallBackProc(userRoutine)		\
		(TerminalSearchCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalSearchCallBackProcInfo, GetCurrentArchitecture())
#define NewTerminalClikLoopProc(userRoutine)		\
		(TerminalClikLoopUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalClikLoopProcInfo, GetCurrentArchitecture())
#define NewTerminalEnvironsProc(userRoutine)		\
		(TerminalEnvironsUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalEnvironsProcInfo, GetCurrentArchitecture())
#define NewTerminalChooseIdleProc(userRoutine)		\
		(TerminalChooseIdleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalChooseIdleProcInfo, GetCurrentArchitecture())
#define NewTerminalToolDefProc(userRoutine)		\
		(TerminalToolDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTerminalToolDefProcInfo, GetCurrentArchitecture())
#else
#define NewTerminalSendProc(userRoutine)		\
		((TerminalSendUPP) (userRoutine))
#define NewTerminalBreakProc(userRoutine)		\
		((TerminalBreakUPP) (userRoutine))
#define NewTerminalCacheProc(userRoutine)		\
		((TerminalCacheUPP) (userRoutine))
#define NewTerminalSearchCallBackProc(userRoutine)		\
		((TerminalSearchCallBackUPP) (userRoutine))
#define NewTerminalClikLoopProc(userRoutine)		\
		((TerminalClikLoopUPP) (userRoutine))
#define NewTerminalEnvironsProc(userRoutine)		\
		((TerminalEnvironsUPP) (userRoutine))
#define NewTerminalChooseIdleProc(userRoutine)		\
		((TerminalChooseIdleUPP) (userRoutine))
#define NewTerminalToolDefProc(userRoutine)		\
		((TerminalToolDefUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallTerminalSendProc(userRoutine, thePtr, theSize, refCon, flags)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalSendProcInfo, (thePtr), (theSize), (refCon), (flags))
#define CallTerminalBreakProc(userRoutine, duration, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalBreakProcInfo, (duration), (refCon))
#define CallTerminalCacheProc(userRoutine, refCon, theTermData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalCacheProcInfo, (refCon), (theTermData))
#define CallTerminalSearchCallBackProc(userRoutine, hTerm, refNum, foundRect)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalSearchCallBackProcInfo, (hTerm), (refNum), (foundRect))
#define CallTerminalClikLoopProc(userRoutine, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalClikLoopProcInfo, (refCon))
#define CallTerminalEnvironsProc(userRoutine, refCon, theEnvirons)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalEnvironsProcInfo, (refCon), (theEnvirons))
#define CallTerminalChooseIdleProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalChooseIdleProcInfo)
#define CallTerminalToolDefProc(userRoutine, hTerm, msg, p1, p2, p3)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTerminalToolDefProcInfo, (hTerm), (msg), (p1), (p2), (p3))
#else
#define CallTerminalSendProc(userRoutine, thePtr, theSize, refCon, flags)		\
		(*(userRoutine))((thePtr), (theSize), (refCon), (flags))
#define CallTerminalBreakProc(userRoutine, duration, refCon)		\
		(*(userRoutine))((duration), (refCon))
#define CallTerminalCacheProc(userRoutine, refCon, theTermData)		\
		(*(userRoutine))((refCon), (theTermData))
#define CallTerminalSearchCallBackProc(userRoutine, hTerm, refNum, foundRect)		\
		(*(userRoutine))((hTerm), (refNum), (foundRect))
#define CallTerminalClikLoopProc(userRoutine, refCon)		\
		(*(userRoutine))((refCon))
#define CallTerminalEnvironsProc(userRoutine, refCon, theEnvirons)		\
		(*(userRoutine))((refCon), (theEnvirons))
#define CallTerminalChooseIdleProc(userRoutine)		\
		(*(userRoutine))()
#define CallTerminalToolDefProc(userRoutine, hTerm, msg, p1, p2, p3)		\
		(*(userRoutine))((hTerm), (msg), (p1), (p2), (p3))
#endif

extern pascal TMErr InitTM(void);
extern pascal Handle TMGetVersion(TermHandle hTerm);
extern pascal short TMGetTMVersion(void);
extern pascal TermHandle TMNew(const Rect *termRect, const Rect *viewRect, TMFlags flags, short procID, WindowPtr owner, TerminalSendUPP sendProc, TerminalCacheUPP cacheProc, TerminalBreakUPP breakProc, TerminalClikLoopUPP clikLoop, TerminalEnvironsUPP environsProc, long refCon, long userData);
extern pascal void TMDispose(TermHandle hTerm);
extern pascal void TMKey(TermHandle hTerm, const EventRecord *theEvent);
extern pascal void TMUpdate(TermHandle hTerm, RgnHandle visRgn);
extern pascal void TMPaint(TermHandle hTerm, const TermDataBlock *theTermData, const Rect *theRect);
extern pascal void TMActivate(TermHandle hTerm, Boolean activate);
extern pascal void TMResume(TermHandle hTerm, Boolean resume);
extern pascal void TMClick(TermHandle hTerm, const EventRecord *theEvent);
extern pascal void TMIdle(TermHandle hTerm);
extern pascal long TMStream(TermHandle hTerm, void *theBuffer, long theLength, CMFlags flags);
extern pascal Boolean TMMenu(TermHandle hTerm, short menuID, short item);
extern pascal void TMReset(TermHandle hTerm);
extern pascal void TMClear(TermHandle hTerm);
extern pascal void TMResize(TermHandle hTerm, const Rect *newViewRect);
extern pascal long TMGetSelect(TermHandle hTerm, Handle theData, ResType *theType);
extern pascal void TMGetLine(TermHandle hTerm, short lineNo, TermDataBlock *theTermData);
extern pascal void TMSetSelection(TermHandle hTerm, const TMSelection *theSelection, TMSelTypes selType);
extern pascal void TMScroll(TermHandle hTerm, short dh, short dv);
extern pascal Boolean TMValidate(TermHandle hTerm);
extern pascal void TMDefault(Ptr *theConfig, short procID, Boolean allocate);
extern pascal Handle TMSetupPreflight(short procID, long *magicCookie);
extern pascal void TMSetupSetup(short procID, const void *theConfig, short count, DialogPtr theDialog, long *magicCookie);
extern pascal Boolean TMSetupFilter(short procID, const void *theConfig, short count, DialogPtr theDialog, EventRecord *theEvent, short *theItem, long *magicCookie);
extern pascal void TMSetupItem(short procID, const void *theConfig, short count, DialogPtr theDialog, short *theItem, long *magicCookie);
extern pascal void TMSetupXCleanup(short procID, const void *theConfig, short count, DialogPtr theDialog, Boolean OKed, long *magicCookie);
extern pascal void TMSetupPostflight(short procID);
extern pascal Ptr TMGetConfig(TermHandle hTerm);
extern pascal short TMSetConfig(TermHandle hTerm, const void *thePtr);
extern pascal OSErr TMIntlToEnglish(TermHandle hTerm, const void *inputPtr, Ptr *outputPtr, short language);
extern pascal OSErr TMEnglishToIntl(TermHandle hTerm, const void *inputPtr, Ptr *outputPtr, short language);
extern pascal void TMGetToolName(short id, Str255 name);
extern pascal short TMGetProcID(ConstStr255Param name);
extern pascal void TMSetRefCon(TermHandle hTerm, long refCon);
extern pascal long TMGetRefCon(TermHandle hTerm);
extern pascal void TMSetUserData(TermHandle hTerm, long userData);
extern pascal long TMGetUserData(TermHandle hTerm);
extern pascal short TMAddSearch(TermHandle hTerm, ConstStr255Param theString, const Rect *where, TMSearchTypes searchType, TerminalSearchCallBackUPP callBack);
extern pascal void TMRemoveSearch(TermHandle hTerm, short refnum);
extern pascal void TMClearSearch(TermHandle hTerm);
extern pascal Point TMGetCursor(TermHandle hTerm, TMCursorTypes cursType);
extern pascal TMErr TMGetTermEnvirons(TermHandle hTerm, TermEnvironRec *theEnvirons);
extern pascal short TMChoose(TermHandle *hTerm, Point where, TerminalChooseIdleUPP idleProc);
extern pascal void TMEvent(TermHandle hTerm, const EventRecord *theEvent);
extern pascal Boolean TMDoTermKey(TermHandle hTerm, ConstStr255Param theKey);
extern pascal short TMCountTermKeys(TermHandle hTerm);
extern pascal void TMGetIndTermKey(TermHandle hTerm, short id, Str255 theKey);
extern pascal void TMGetErrorString(TermHandle hTerm, short id, Str255 errMsg);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TERMINALS__ */

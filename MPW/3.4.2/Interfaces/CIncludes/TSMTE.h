/*
 	File:		TSMTE.h
 
 	Contains:	Text Services Managerfor TextEdit Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __TSMTE__
#define __TSMTE__


#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Memory.h>											*/
/*	#include <Menus.h>											*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __TEXTSERVICES__
#include <TextServices.h>
#endif
/*	#include <Components.h>										*/

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
	kTSMTESignature				= 'tmTE',
	kTSMTEInterfaceType			= 'tmTE',
	kTSMTEDialog				= 'tmDI'
};

/* update flag for TSMTERec*/
enum {
	kTSMTEAutoScroll			= 1
};

/* callback procedure definitions*/
typedef pascal void (*TSMTEPreUpdateProcPtr)(TEHandle textH, long refCon);
typedef pascal void (*TSMTEPostUpdateProcPtr)(TEHandle textH, long fixLen, long inputAreaStart, long inputAreaEnd, long pinStart, long pinEnd, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr TSMTEPreUpdateUPP;
typedef UniversalProcPtr TSMTEPostUpdateUPP;
#else
typedef TSMTEPreUpdateProcPtr TSMTEPreUpdateUPP;
typedef TSMTEPostUpdateProcPtr TSMTEPostUpdateUPP;
#endif

struct TSMTERec {
	TEHandle						textH;
	TSMTEPreUpdateUPP				preUpdateProc;
	TSMTEPostUpdateUPP				postUpdateProc;
	long							updateFlag;
	long							refCon;
};
typedef struct TSMTERec TSMTERec, *TSMTERecPtr, **TSMTERecHandle;

struct TSMDialogRecord {
	DialogRecord					fDialog;
	TSMDocumentID					fDocID;
	TSMTERecHandle					fTSMTERecH;
	long							fTSMTERsvd[3];				/* reserved*/
};
typedef struct TSMDialogRecord TSMDialogRecord, *TSMDialogPeek;


#if GENERATINGCFM
#else
#endif

enum {
	uppTSMTEPreUpdateProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TEHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppTSMTEPostUpdateProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TEHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewTSMTEPreUpdateProc(userRoutine)		\
		(TSMTEPreUpdateUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTSMTEPreUpdateProcInfo, GetCurrentArchitecture())
#define NewTSMTEPostUpdateProc(userRoutine)		\
		(TSMTEPostUpdateUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTSMTEPostUpdateProcInfo, GetCurrentArchitecture())
#else
#define NewTSMTEPreUpdateProc(userRoutine)		\
		((TSMTEPreUpdateUPP) (userRoutine))
#define NewTSMTEPostUpdateProc(userRoutine)		\
		((TSMTEPostUpdateUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallTSMTEPreUpdateProc(userRoutine, textH, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTSMTEPreUpdateProcInfo, (textH), (refCon))
#define CallTSMTEPostUpdateProc(userRoutine, textH, fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTSMTEPostUpdateProcInfo, (textH), (fixLen), (inputAreaStart), (inputAreaEnd), (pinStart), (pinEnd), (refCon))
#else
#define CallTSMTEPreUpdateProc(userRoutine, textH, refCon)		\
		(*(userRoutine))((textH), (refCon))
#define CallTSMTEPostUpdateProc(userRoutine, textH, fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd, refCon)		\
		(*(userRoutine))((textH), (fixLen), (inputAreaStart), (inputAreaEnd), (pinStart), (pinEnd), (refCon))
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

#endif /* __TSMTE__ */

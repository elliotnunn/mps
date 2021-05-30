/*
	File:		TSMTE.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/


/*
	File:		TSMTE.h

	Contains:	Definitions for TSMTE

	Written by:	Kida Yasuo, Hara Keisuke

	Copyright:	©1991-1993 Apple Technology, Inc.
				All rights reserved.

	Change History (most recent first):

		 <8>	  94.1.7	Kda		Modified for the Interfacer tool.  Sync with TSMTE tech note.
		 <7>	  92.9.4	Kda		Moved gestaltTSMTEVersion and kTSMTEDialog from the private
									header.  Updated the version from 0.1 to 1.0.
		 <6>	 92.7.31	Kda		Moved gestaltTSMTEAttr from TSMTEPriv.h
		 <5>	 92.7.31	Kda		Modified TSMTERec and added a preUpdateProc.
		 <4>	 92.7.16	Kda		
		 <3>	 92.7.16	Kda		Added kTSMTEInterfaceType for interface type used in
									NewTSMDocument.
		 <2>	  92.6.5	Kda		Removed the signature field from TSMTERec.
		 <1>	  92.6.5	Kda		first checked in

*/

#ifndef __TSMTE__
#define __TSMTE__

#ifndef __TEXTEDIT__
#include <TextEdit.h>
/*	#include <Quickdraw.h>										*/
/*		#include <Types.h>										*/
/*			#include <ConditionalMacros.h>						*/
/*			#include <MixedMode.h>								*/
/*				#include <Traps.h>								*/
/*		#include <QuickdrawText.h>								*/
/*			#include <IntlResources.h>							*/
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*		#include <Controls.h>									*/
/*			#include <Menus.h>									*/
#endif

#ifndef __TEXTSERVICES__
#include <TextServices.h>
/*	#include <AppleEvents.h>									*/
/*		#include <Memory.h>										*/
/*		#include <EPPC.h>										*/
/*			#include <PPCToolBox.h>								*/
/*				#include <AppleTalk.h>							*/
/*			#include <Processes.h>								*/
/*				#include <Files.h>								*/
/*					#include <SegLoad.h>						*/
/*		#include <Notification.h>								*/
/*	#include <Errors.h>											*/
/*	#include <Components.h>										*/
#endif

enum  {
	kTSMTESignature				= 'tmTE',
	kTSMTEInterfaceType			= kTSMTESignature,
	kTSMTEDialog				= 'tmDI'
};


// Gestalt

enum  {
	gestaltTSMTEAttr			= kTSMTESignature,
	gestaltTSMTEPresent			= 0,
	gestaltTSMTE				= gestaltTSMTEPresent,
	gestaltTSMTEVersion			= 'tmTV',
	gestaltTSMTE1				= 0x100
};


// update flag for TSMTERec

enum  {
	kTSMTEAutoScroll			= 1
};


// callback procedure definitions

typedef pascal void (*TSMTEPreUpdateProcPtr)(TEHandle textH, long refCon);

enum {
	uppTSMTEPreUpdateProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TEHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr TSMTEPreUpdateUPP;

#define CallTSMTEPreUpdateProc(userRoutine, textH, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTSMTEPreUpdateProcInfo, (textH), (refCon))
#define NewTSMTEPreUpdateProc(userRoutine)		\
		(TSMTEPreUpdateUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTSMTEPreUpdateProcInfo, GetCurrentISA())
#else
typedef TSMTEPreUpdateProcPtr TSMTEPreUpdateUPP;

#define CallTSMTEPreUpdateProc(userRoutine, textH, refCon)		\
		(*(userRoutine))((textH), (refCon))
#define NewTSMTEPreUpdateProc(userRoutine)		\
		(TSMTEPreUpdateUPP)(userRoutine)
#endif

typedef pascal void (*TSMTEPostUpdateProcPtr)(TEHandle textH, long fixLen, long inputAreaStart, long inputAreaEnd, long pinStart, long pinEnd, long refCon);

enum {
	uppTSMTEPostUpdateProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TEHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr TSMTEPostUpdateUPP;

#define CallTSMTEPostUpdateProc(userRoutine, textH, fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTSMTEPostUpdateProcInfo, (textH), (fixLen), (inputAreaStart), (inputAreaEnd), (pinStart), (pinEnd), (refCon))
#define NewTSMTEPostUpdateProc(userRoutine)		\
		(TSMTEPostUpdateUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTSMTEPostUpdateProcInfo, GetCurrentISA())
#else
typedef TSMTEPostUpdateProcPtr TSMTEPostUpdateUPP;

#define CallTSMTEPostUpdateProc(userRoutine, textH, fixLen, inputAreaStart, inputAreaEnd, pinStart, pinEnd, refCon)		\
		(*(userRoutine))((textH), (fixLen), (inputAreaStart), (inputAreaEnd), (pinStart), (pinEnd), (refCon))
#define NewTSMTEPostUpdateProc(userRoutine)		\
		(TSMTEPostUpdateUPP)(userRoutine)
#endif


// data types

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct TSMTERec {
	TEHandle					textH;
	TSMTEPreUpdateUPP			preUpdateProc;
	TSMTEPostUpdateUPP			postUpdateProc;
	long						updateFlag;
	long						refCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct TSMTERec TSMTERec, *TSMTERecPtr, **TSMTERecHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct TSMDialogRecord {
	DialogRecord				fDialog;
	TSMDocumentID				fDocID;
	TSMTERecHandle				fTSMTERecH;
	long						fTSMTERsvd[3];					// reserved
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct TSMDialogRecord TSMDialogRecord, *TSMDialogPeek;

#endif


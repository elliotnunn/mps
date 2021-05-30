/*
 	File:		StandardFile.h
 
 	Contains:	Standard File package Interfaces.
 
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

#ifndef __STANDARDFILE__
#define __STANDARDFILE__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <Menus.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <Finder.h>											*/

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
/* resource IDs and item offsets of pre-7.0 dialogs */
	putDlgID					= -3999,
	putSave						= 1,
	putCancel					= 2,
	putEject					= 5,
	putDrive					= 6,
	putName						= 7,
	getDlgID					= -4000,
	getOpen						= 1,
	getCancel					= 3,
	getEject					= 5,
	getDrive					= 6,
	getNmList					= 7,
	getScroll					= 8,
/* resource IDs and item offsets of 7.0 dialogs */
	sfPutDialogID				= -6043,
	sfGetDialogID				= -6042,
	sfItemOpenButton			= 1,
	sfItemCancelButton			= 2,
	sfItemBalloonHelp			= 3,
	sfItemVolumeUser			= 4,
	sfItemEjectButton			= 5
};

enum {
	sfItemDesktopButton			= 6,
	sfItemFileListUser			= 7,
	sfItemPopUpMenuUser			= 8,
	sfItemDividerLinePict		= 9,
	sfItemFileNameTextEdit		= 10,
	sfItemPromptStaticText		= 11,
	sfItemNewFolderUser			= 12,
/* pseudo-item hits for use in DlgHook */
	sfHookFirstCall				= -1,
	sfHookCharOffset			= 0x1000,
	sfHookNullEvent				= 100,
	sfHookRebuildList			= 101,
	sfHookFolderPopUp			= 102,
	sfHookOpenFolder			= 103,
/* the following are only in system 7.0+ */
	sfHookOpenAlias				= 104,
	sfHookGoToDesktop			= 105,
	sfHookGoToAliasTarget		= 106,
	sfHookGoToParent			= 107,
	sfHookGoToNextDrive			= 108,
	sfHookGoToPrevDrive			= 109,
	sfHookChangeSelection		= 110
};

enum {
	sfHookSetActiveOffset		= 200,
	sfHookLastCall				= -2
};

/* the refcon field of the dialog record during a
 modalfilter or dialoghook contains one of the following */
enum {
	sfMainDialogRefCon			= 'stdf',
	sfNewFolderDialogRefCon		= 'nfdr',
	sfReplaceDialogRefCon		= 'rplc',
	sfStatWarnDialogRefCon		= 'stat',
	sfLockWarnDialogRefCon		= 'lock',
	sfErrorDialogRefCon			= 'err '
};

struct SFReply {
	Boolean							good;
	Boolean							copy;
	OSType							fType;
	short							vRefNum;
	short							version;
	Str63							fName;
};
typedef struct SFReply SFReply;

struct StandardFileReply {
	Boolean							sfGood;
	Boolean							sfReplacing;
	OSType							sfType;
	FSSpec							sfFile;
	ScriptCode						sfScript;
	short							sfFlags;
	Boolean							sfIsFolder;
	Boolean							sfIsVolume;
	long							sfReserved1;
	short							sfReserved2;
};
typedef struct StandardFileReply StandardFileReply;

/* for CustomXXXFile, ActivationOrderListPtr parameter is a pointer to an array of item numbers */
typedef const short *ActivationOrderListPtr;

/* the following also include an extra parameter of "your data pointer" */
typedef pascal short (*DlgHookProcPtr)(short item, DialogPtr theDialog);
typedef pascal Boolean (*FileFilterProcPtr)(CInfoPBPtr pb);
typedef pascal short (*DlgHookYDProcPtr)(short item, DialogPtr theDialog, void *yourDataPtr);
typedef pascal Boolean (*ModalFilterYDProcPtr)(DialogPtr theDialog, EventRecord *theEvent, short *itemHit, void *yourDataPtr);
typedef pascal Boolean (*FileFilterYDProcPtr)(CInfoPBPtr pb, void *yourDataPtr);
typedef pascal void (*ActivateYDProcPtr)(DialogPtr theDialog, short itemNo, Boolean activating, void *yourDataPtr);

#if GENERATINGCFM
typedef UniversalProcPtr DlgHookUPP;
typedef UniversalProcPtr FileFilterUPP;
typedef UniversalProcPtr DlgHookYDUPP;
typedef UniversalProcPtr ModalFilterYDUPP;
typedef UniversalProcPtr FileFilterYDUPP;
typedef UniversalProcPtr ActivateYDUPP;
#else
typedef DlgHookProcPtr DlgHookUPP;
typedef FileFilterProcPtr FileFilterUPP;
typedef DlgHookYDProcPtr DlgHookYDUPP;
typedef ModalFilterYDProcPtr ModalFilterYDUPP;
typedef FileFilterYDProcPtr FileFilterYDUPP;
typedef ActivateYDProcPtr ActivateYDUPP;
#endif

enum {
	uppDlgHookProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DialogPtr))),
	uppFileFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(CInfoPBPtr))),
	uppDlgHookYDProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*))),
	uppModalFilterYDProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*))),
	uppFileFilterYDProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(CInfoPBPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*))),
	uppActivateYDProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewDlgHookProc(userRoutine)		\
		(DlgHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDlgHookProcInfo, GetCurrentArchitecture())
#define NewFileFilterProc(userRoutine)		\
		(FileFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFileFilterProcInfo, GetCurrentArchitecture())
#define NewDlgHookYDProc(userRoutine)		\
		(DlgHookYDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDlgHookYDProcInfo, GetCurrentArchitecture())
#define NewModalFilterYDProc(userRoutine)		\
		(ModalFilterYDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppModalFilterYDProcInfo, GetCurrentArchitecture())
#define NewFileFilterYDProc(userRoutine)		\
		(FileFilterYDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFileFilterYDProcInfo, GetCurrentArchitecture())
#define NewActivateYDProc(userRoutine)		\
		(ActivateYDUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppActivateYDProcInfo, GetCurrentArchitecture())
#else
#define NewDlgHookProc(userRoutine)		\
		((DlgHookUPP) (userRoutine))
#define NewFileFilterProc(userRoutine)		\
		((FileFilterUPP) (userRoutine))
#define NewDlgHookYDProc(userRoutine)		\
		((DlgHookYDUPP) (userRoutine))
#define NewModalFilterYDProc(userRoutine)		\
		((ModalFilterYDUPP) (userRoutine))
#define NewFileFilterYDProc(userRoutine)		\
		((FileFilterYDUPP) (userRoutine))
#define NewActivateYDProc(userRoutine)		\
		((ActivateYDUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDlgHookProc(userRoutine, item, theDialog)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDlgHookProcInfo, (item), (theDialog))
#define CallFileFilterProc(userRoutine, pb)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFileFilterProcInfo, (pb))
#define CallDlgHookYDProc(userRoutine, item, theDialog, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDlgHookYDProcInfo, (item), (theDialog), (yourDataPtr))
#define CallModalFilterYDProc(userRoutine, theDialog, theEvent, itemHit, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppModalFilterYDProcInfo, (theDialog), (theEvent), (itemHit), (yourDataPtr))
#define CallFileFilterYDProc(userRoutine, pb, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFileFilterYDProcInfo, (pb), (yourDataPtr))
#define CallActivateYDProc(userRoutine, theDialog, itemNo, activating, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppActivateYDProcInfo, (theDialog), (itemNo), (activating), (yourDataPtr))
#else
#define CallDlgHookProc(userRoutine, item, theDialog)		\
		(*(userRoutine))((item), (theDialog))
#define CallFileFilterProc(userRoutine, pb)		\
		(*(userRoutine))((pb))
#define CallDlgHookYDProc(userRoutine, item, theDialog, yourDataPtr)		\
		(*(userRoutine))((item), (theDialog), (yourDataPtr))
#define CallModalFilterYDProc(userRoutine, theDialog, theEvent, itemHit, yourDataPtr)		\
		(*(userRoutine))((theDialog), (theEvent), (itemHit), (yourDataPtr))
#define CallFileFilterYDProc(userRoutine, pb, yourDataPtr)		\
		(*(userRoutine))((pb), (yourDataPtr))
#define CallActivateYDProc(userRoutine, theDialog, itemNo, activating, yourDataPtr)		\
		(*(userRoutine))((theDialog), (itemNo), (activating), (yourDataPtr))
#endif

typedef OSType SFTypeList[4];

/*
	The GetFile "typeList" parameter type has changed from "SFTypeList" to "ConstSFTypeListPtr".
	For C, this will add "const" and make it an in-only parameter.
	For Pascal, this will require client code to use the @ operator, but make it easier to specify long lists.

	ConstSFTypeListPtr is a pointer to an array of OSTypes.
*/
typedef const OSType *ConstSFTypeListPtr;

extern pascal void SFPutFile(Point where, ConstStr255Param prompt, ConstStr255Param origName, DlgHookUPP dlgHook, SFReply *reply)
 THREEWORDINLINE(0x3F3C, 0x0001, 0xA9EA);
extern pascal void SFGetFile(Point where, ConstStr255Param prompt, FileFilterUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, DlgHookUPP dlgHook, SFReply *reply)
 THREEWORDINLINE(0x3F3C, 0x0002, 0xA9EA);
extern pascal void SFPPutFile(Point where, ConstStr255Param prompt, ConstStr255Param origName, DlgHookUPP dlgHook, SFReply *reply, short dlgID, ModalFilterUPP filterProc)
 THREEWORDINLINE(0x3F3C, 0x0003, 0xA9EA);
extern pascal void SFPGetFile(Point where, ConstStr255Param prompt, FileFilterUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, DlgHookUPP dlgHook, SFReply *reply, short dlgID, ModalFilterUPP filterProc)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xA9EA);
extern pascal void StandardPutFile(ConstStr255Param prompt, ConstStr255Param defaultName, StandardFileReply *reply)
 THREEWORDINLINE(0x3F3C, 0x0005, 0xA9EA);
extern pascal void StandardGetFile(FileFilterUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, StandardFileReply *reply)
 THREEWORDINLINE(0x3F3C, 0x0006, 0xA9EA);
extern pascal void CustomPutFile(ConstStr255Param prompt, ConstStr255Param defaultName, StandardFileReply *reply, short dlgID, Point where, DlgHookYDUPP dlgHook, ModalFilterYDUPP filterProc, ActivationOrderListPtr activeList, ActivateYDUPP activate, void *yourDataPtr)
 THREEWORDINLINE(0x3F3C, 0x0007, 0xA9EA);
extern pascal void CustomGetFile(FileFilterYDUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, StandardFileReply *reply, short dlgID, Point where, DlgHookYDUPP dlgHook, ModalFilterYDUPP filterProc, ActivationOrderListPtr activeList, ActivateYDUPP activate, void *yourDataPtr)
 THREEWORDINLINE(0x3F3C, 0x0008, 0xA9EA);
extern pascal OSErr StandardOpenDialog(StandardFileReply *reply);
#if CGLUESUPPORTED
extern void sfpputfile(Point *where, const char *prompt, const char *origName, DlgHookUPP dlgHook, SFReply *reply, short dlgID, ModalFilterUPP filterProc);
extern void sfgetfile(Point *where, const char *prompt, FileFilterUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, DlgHookUPP dlgHook, SFReply *reply);
extern void sfpgetfile(Point *where, const char *prompt, FileFilterUPP fileFilter, short numTypes, ConstSFTypeListPtr typeList, DlgHookUPP dlgHook, SFReply *reply, short dlgID, ModalFilterUPP filterProc);
extern void sfputfile(Point *where, const char *prompt, const char *origName, DlgHookUPP dlgHook, SFReply *reply);
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

#endif /* __STANDARDFILE__ */

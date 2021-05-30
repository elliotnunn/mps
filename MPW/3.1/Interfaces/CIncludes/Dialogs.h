/************************************************************

Created: Thursday, September 7, 1989 at 3:41 PM
	Dialogs.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	 1985-1989
	All rights reserved

************************************************************/


#ifndef __DIALOGS__
#define __DIALOGS__

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#define ctrlItem 4
#define btnCtrl 0
#define chkCtrl 1
#define radCtrl 2
#define resCtrl 3
#define statText 8
#define editText 16
#define iconItem 32
#define picItem 64
#define userItem 0
#define itemDisable 128
#define ok 1
#define cancel 2
#define stopIcon 0
#define noteIcon 1
#define cautionIcon 2

typedef short StageList;

typedef WindowPtr DialogPtr;

typedef pascal void (*ResumeProcPtr)(void);
typedef pascal void (*SoundProcPtr)(void);
typedef pascal Boolean (*ModalFilterProcPtr)(DialogPtr theDialog, EventRecord *theEvent, short *itemHit);


struct DialogRecord {
	WindowRecord window;
	Handle items;
	TEHandle textH;
	short editField;
	short editOpen;
	short aDefItem;
};

typedef struct DialogRecord DialogRecord;
typedef DialogRecord *DialogPeek;

struct DialogTemplate {
	Rect boundsRect;
	short procID;
	Boolean visible;
	Boolean filler1;
	Boolean goAwayFlag;
	Boolean filler2;
	long refCon;
	short itemsID;
	Str255 title;
};

typedef struct DialogTemplate DialogTemplate;
typedef DialogTemplate *DialogTPtr, **DialogTHndl;

struct AlertTemplate {
	Rect boundsRect;
	short itemsID;
	StageList stages;
};

typedef struct AlertTemplate AlertTemplate;
typedef AlertTemplate *AlertTPtr, **AlertTHndl;

#ifdef __cplusplus
extern "C" {
#endif
pascal void InitDialogs(ResumeProcPtr resumeProc)
	= 0xA97B;
pascal void ErrorSound(SoundProcPtr soundProc)
	= 0xA98C;
pascal DialogPtr NewDialog(Ptr wStorage,const Rect *boundsRect,const Str255 title,
	Boolean visible,short procID,WindowPtr behind,Boolean goAwayFlag,long refCon,
	Handle itmLstHndl)
	= 0xA97D;
DialogPtr newdialog(Ptr wStorage,const Rect *boundsRect,char *title,Boolean visible,
	short procID,WindowPtr behind,Boolean goAwayFlag,long refCon,Handle itmLstHndl);
pascal DialogPtr GetNewDialog(short dialogID,Ptr dStorage,WindowPtr behind)
	= 0xA97C;
pascal void CloseDialog(DialogPtr theDialog)
	= 0xA982;
pascal void DisposDialog(DialogPtr theDialog)
	= 0xA983;
pascal void CouldDialog(short dialogID)
	= 0xA979;
pascal void FreeDialog(short dialogID)
	= 0xA97A;
pascal void ParamText(const Str255 param0,const Str255 param1,const Str255 param2,
	const Str255 param3)
	= 0xA98B;
pascal void ModalDialog(ModalFilterProcPtr filterProc,short *itemHit)
	= 0xA991;
pascal Boolean IsDialogEvent(const EventRecord *theEvent)
	= 0xA97F;
pascal Boolean DialogSelect(const EventRecord *theEvent,DialogPtr *theDialog,
	short *itemHit)
	= 0xA980;
pascal void DrawDialog(DialogPtr theDialog)
	= 0xA981;
pascal void UpdtDialog(DialogPtr theDialog,RgnHandle updateRgn)
	= 0xA978;
pascal short Alert(short alertID,ModalFilterProcPtr filterProc)
	= 0xA985;
pascal short StopAlert(short alertID,ModalFilterProcPtr filterProc)
	= 0xA986;
pascal short NoteAlert(short alertID,ModalFilterProcPtr filterProc)
	= 0xA987;
pascal short CautionAlert(short alertID,ModalFilterProcPtr filterProc)
	= 0xA988;
pascal void CouldAlert(short alertID)
	= 0xA989;
pascal void FreeAlert(short alertID)
	= 0xA98A;
pascal void GetDItem(DialogPtr theDialog,short itemNo,short *itemType,Handle *item,
	Rect *box)
	= 0xA98D;
pascal void SetDItem(DialogPtr theDialog,short itemNo,short itemType,Handle item,
	const Rect *box)
	= 0xA98E;
pascal void HideDItem(DialogPtr theDialog,short itemNo)
	= 0xA827;
pascal void ShowDItem(DialogPtr theDialog,short itemNo)
	= 0xA828;
pascal void SelIText(DialogPtr theDialog,short itemNo,short strtSel,short endSel)
	= 0xA97E;
pascal void GetIText(Handle item,Str255 text)
	= 0xA990;
pascal void SetIText(Handle item,const Str255 text)
	= 0xA98F;
pascal short FindDItem(DialogPtr theDialog,Point thePt)
	= 0xA984;
pascal DialogPtr NewCDialog(Ptr dStorage,const Rect *boundsRect,const Str255 title,
	Boolean visible,short procID,WindowPtr behind,Boolean goAwayFlag,long refCon,
	Handle items)
	= 0xAA4B;
DialogPtr newcdialog(Ptr dStorage,const Rect *boundsRect,char *title,Boolean visible,
	short procID,WindowPtr behind,Boolean goAwayFlag,long refCon,Handle items); 
pascal short GetAlrtStage(void)
	= {0x3EB8,0x0A9A};
pascal void ResetAlrtStage(void)
	= {0x4278,0x0A9A};
pascal void DlgCut(DialogPtr theDialog);
pascal void DlgPaste(DialogPtr theDialog);
pascal void DlgCopy(DialogPtr theDialog);
pascal void DlgDelete(DialogPtr theDialog); 
pascal void SetDAFont(short fontNum);
void paramtext(char *param0,char *param1,char *param2,char *param3);
void getitext(Handle item,char *text);
void setitext(Handle item,char *text);
short findditem(DialogPtr theDialog,Point *thePt);
#ifdef __cplusplus
}
#endif

#endif

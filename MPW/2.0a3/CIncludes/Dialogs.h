/*
	Dialogs.h -- Dialog Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __DIALOGS__
#define __DIALOGS__
#ifndef __WINDOWS__
#include <Windows.h>
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

typedef WindowPtr DialogPtr;
typedef struct DialogRecord {
	WindowRecord window;
	Handle items;
	struct TERec **textH;
	short editField;
	short editOpen;
	short aDefItem;
} DialogRecord,*DialogPeek;
typedef struct DialogTemplate {
	Rect boundsRect;
	short procID;
	Boolean visible;
	Boolean filler1;
	Boolean goAwayFlag;
	Boolean filler2;
	long refCon;
	short itemsID;
	Str255 title;
} DialogTemplate,*DialogTPtr,**DialogTHndl;
typedef short StageList;
typedef struct AlertTemplate {
	Rect boundsRect;
	short itemsID;
	StageList stages;
} AlertTemplate,*AlertTPtr,**AlertTHndl;

pascal void InitDialogs(restartProc)
	ProcPtr restartProc;
	extern 0xA97B;
pascal void ErrorSound(soundProc)
	ProcPtr soundProc;
	extern 0xA98C;
DialogPtr NewDialog();
pascal DialogPtr GetNewDialog(dialogID,dStorage,behind)
	short dialogID;
	Ptr dStorage;
	WindowPtr behind;
	extern 0xA97C;
pascal void CloseDialog(theDialog)
	DialogPtr theDialog;
	extern 0xA982;
pascal void DisposDialog(theDialog)
	DialogPtr theDialog;
	extern 0xA983;
pascal void CouldDialog(dialogID)
	short dialogID;
	extern 0xA979;
pascal void FreeDialog(dialogID)
	short dialogID;
	extern 0xA97A;
pascal void ModalDialog(filterProc,itemHit)
	ProcPtr filterProc;
	short *itemHit;
	extern 0xA991;
pascal Boolean IsDialogEvent(theEvent)
	struct EventRecord *theEvent;
	extern 0xA97F;
pascal Boolean DialogSelect(theEvent,theDialog,itemHit)
	struct EventRecord *theEvent;
	DialogPtr *theDialog;
	short *itemHit;
	extern 0xA980;
pascal void DrawDialog(theDialog)
	DialogPtr theDialog;
	extern 0xA981;
pascal void UpdtDialog(theDialog,updateRgn)
	DialogPtr theDialog;
	RgnHandle updateRgn;
	extern 0xA978;
pascal short Alert(alertID,filterProc)
	short alertID;
	ProcPtr filterProc;
	extern 0xA985;
pascal short StopAlert(alertID,filterProc)
	short alertID;
	ProcPtr filterProc;
	extern 0xA986;
pascal short NoteAlert(alertID,filterProc)
	short alertID;
	ProcPtr filterProc;
	extern 0xA987;
pascal short CautionAlert(alertID,filterProc)
	short alertID;
	ProcPtr filterProc;
	extern 0xA988;
pascal void CouldAlert(alertID)
	short alertID;
	extern 0xA989;
pascal void FreeAlert(alertID)
	short alertID;
	extern 0xA98A;
pascal void GetDItem(theDialog,itemNo,itemType,item,box)
	DialogPtr theDialog;
	short itemNo;
	short *itemType;
	Handle *item;
	Rect *box;
	extern 0xA98D;
pascal void SetDItem(theDialog,itemNo,itemType,item,box)
	DialogPtr theDialog;
	short itemNo;
	short itemType;
	Handle item;
	Rect *box;
	extern 0xA98E;
pascal void HideDItem(theDialog,itemNo)
	DialogPtr theDialog;
	short itemNo;
	extern 0xA827;
pascal void ShowDItem(theDialog,itemNo)
	DialogPtr theDialog;
	short itemNo;
	extern 0xA828;
pascal void SelIText(theDialog,itemNo,strtSel,endSel)
	DialogPtr theDialog;
	short itemNo;
	short strtSel;
	short endSel;
	extern 0xA97E;



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


pascal DialogPtr NewCDialog(dStorage,boundsRect,title,visible,
				procID,behind,goAwayFlag,refCon,items)
	Ptr dStorage;
	Rect *boundsRect;
	Str255 *title;
	Boolean visible;
	short procID;
	WindowPtr behind;
	Boolean goAwayFlag;
	long refCon;
	Handle items;
	extern 0xAA4B;

#endif
#endif

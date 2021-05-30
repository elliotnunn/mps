{
	File:		Dialogs.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Dialogs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingDialogs}
{$SETC UsingDialogs := 1}

{$I+}
{$SETC DialogsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingWindows}
{$I $$Shell(PInterfaces)Windows.p}
{$ENDC}
{$IFC UNDEFINED UsingTextEdit}
{$I $$Shell(PInterfaces)TextEdit.p}
{$ENDC}
{$SETC UsingIncludes := DialogsIncludes}

CONST
ctrlItem = 4;
btnCtrl = 0;
chkCtrl = 1;
radCtrl = 2;
resCtrl = 3;
statText = 8;
editText = 16;
iconItem = 32;
picItem = 64;
userItem = 0;
itemDisable = 128;
ok = 1;
cancel = 2;
stopIcon = 0;
noteIcon = 1;
cautionIcon = 2;

TYPE
{ Dialog Item List Manipulation Constants }
DITLMethod = INTEGER;

CONST
overlayDITL = 0;
appendDITLRight = 1;
appendDITLBottom = 2;

TYPE
StageList = PACKED RECORD
 boldItm4: 0..1;				{default button item number - 1}
 boxDrwn4: BOOLEAN;      	    {true if alert box to be drawn}
 sound4: 0..3;           	    {sound number}
 boldItm3: 0..1;
 boxDrwn3: BOOLEAN;
 sound3: 0..3;
 boldItm2: 0..1;
 boxDrwn2: BOOLEAN;
 sound2: 0..3;
 boldItm1: 0..1;
 boxDrwn1: BOOLEAN;
 sound1: 0..3;
 END;


DialogPtr = WindowPtr;
ResumeProcPtr = ProcPtr;		{ PROCEDURE Resume; } 
SoundProcPtr = ProcPtr;			{ PROCEDURE DoSound; } 
ModalFilterProcPtr = ProcPtr;   { FUNCTION Filter(theDialog: DialogPtr; VAR theEvent: EventRecord; VAR itemHit: INTEGER): BOOLEAN; }

DialogPeek = ^DialogRecord;
DialogRecord = RECORD
 window: WindowRecord;
 items: Handle;
 textH: TEHandle;
 editField: INTEGER;
 editOpen: INTEGER;
 aDefItem: INTEGER;
 END;

DialogTPtr = ^DialogTemplate;
DialogTHndl = ^DialogTPtr;
DialogTemplate = RECORD
 boundsRect: Rect;
 procID: INTEGER;
 visible: BOOLEAN;
 filler1: BOOLEAN;
 goAwayFlag: BOOLEAN;
 filler2: BOOLEAN;
 refCon: LONGINT;
 itemsID: INTEGER;
 title: Str255;
 END;

AlertTPtr = ^AlertTemplate;
AlertTHndl = ^AlertTPtr;
AlertTemplate = RECORD
 boundsRect: Rect;
 itemsID: INTEGER;
 stages: StageList;
 END;


PROCEDURE InitDialogs(resumeProc: ResumeProcPtr);
 INLINE $A97B;
PROCEDURE ErrorSound(soundProc: SoundProcPtr);
 INLINE $A98C;
FUNCTION NewDialog(wStorage: Ptr;boundsRect: Rect;title: Str255;visible: BOOLEAN;
 procID: INTEGER;behind: WindowPtr;goAwayFlag: BOOLEAN;refCon: LONGINT;
 itmLstHndl: Handle): DialogPtr;
 INLINE $A97D;
FUNCTION GetNewDialog(dialogID: INTEGER;dStorage: Ptr;behind: WindowPtr): DialogPtr;
 INLINE $A97C;
PROCEDURE CloseDialog(theDialog: DialogPtr);
 INLINE $A982;
PROCEDURE DisposDialog(theDialog: DialogPtr);
 INLINE $A983;
PROCEDURE DisposeDialog(theDialog: DialogPtr);
 INLINE $A983;
PROCEDURE ParamText(param0: Str255;param1: Str255;param2: Str255;param3: Str255);
 INLINE $A98B;
PROCEDURE ModalDialog(filterProc: ModalFilterProcPtr;VAR itemHit: INTEGER);
 INLINE $A991;
FUNCTION IsDialogEvent(theEvent: EventRecord): BOOLEAN;
 INLINE $A97F;
FUNCTION DialogSelect(theEvent: EventRecord;VAR theDialog: DialogPtr;VAR itemHit: INTEGER): BOOLEAN;
 INLINE $A980;
PROCEDURE DrawDialog(theDialog: DialogPtr);
 INLINE $A981;
PROCEDURE UpdateDialog(theDialog: DialogPtr;updateRgn: RgnHandle);
 INLINE $A978;
PROCEDURE UpdtDialog(theDialog: DialogPtr;updateRgn: RgnHandle);
 INLINE $A978;
FUNCTION Alert(alertID: INTEGER;filterProc: ModalFilterProcPtr): INTEGER;
 INLINE $A985;
FUNCTION StopAlert(alertID: INTEGER;filterProc: ModalFilterProcPtr): INTEGER;
 INLINE $A986;
FUNCTION NoteAlert(alertID: INTEGER;filterProc: ModalFilterProcPtr): INTEGER;
 INLINE $A987;
FUNCTION CautionAlert(alertID: INTEGER;filterProc: ModalFilterProcPtr): INTEGER;
 INLINE $A988;
PROCEDURE GetDialogItem(theDialog: DialogPtr;itemNo: INTEGER;VAR itemType: INTEGER;
 VAR item: Handle;VAR box: Rect);
 INLINE $A98D;
PROCEDURE GetDItem(theDialog: DialogPtr;itemNo: INTEGER;VAR itemType: INTEGER;
 VAR item: Handle;VAR box: Rect);
 INLINE $A98D;
PROCEDURE SetDialogItem(theDialog: DialogPtr;itemNo: INTEGER;itemType: INTEGER;
 item: Handle;box: Rect);
 INLINE $A98E;
PROCEDURE SetDItem(theDialog: DialogPtr;itemNo: INTEGER;itemType: INTEGER;
 item: Handle;box: Rect);
 INLINE $A98E;
PROCEDURE HideDialogItem(theDialog: DialogPtr;itemNo: INTEGER);
 INLINE $A827;
PROCEDURE HideDItem(theDialog: DialogPtr;itemNo: INTEGER);
 INLINE $A827;
PROCEDURE ShowDialogItem(theDialog: DialogPtr;itemNo: INTEGER);
 INLINE $A828;
PROCEDURE ShowDItem(theDialog: DialogPtr;itemNo: INTEGER);
 INLINE $A828;
PROCEDURE SelectDialogItemText(theDialog: DialogPtr;itemNo: INTEGER;strtSel: INTEGER;
 endSel: INTEGER);
 INLINE $A97E;
PROCEDURE SelIText(theDialog: DialogPtr;itemNo: INTEGER;strtSel: INTEGER;
 endSel: INTEGER);
 INLINE $A97E;
PROCEDURE GetDialogItemText(item: Handle;VAR text: Str255);
 INLINE $A990;
PROCEDURE GetIText(item: Handle;VAR text: Str255);
 INLINE $A990;
PROCEDURE SetDialogItemText(item: Handle;text: Str255);
 INLINE $A98F;
PROCEDURE SetIText(item: Handle;text: Str255);
 INLINE $A98F;
FUNCTION FindDialogItem(theDialog: DialogPtr;thePt: Point): INTEGER;
 INLINE $A984;
FUNCTION FindDItem(theDialog: DialogPtr;thePt: Point): INTEGER;
 INLINE $A984;
FUNCTION NewColorDialog(dStorage: Ptr;boundsRect: Rect;title: Str255;visible: BOOLEAN;
 procID: INTEGER;behind: WindowPtr;goAwayFlag: BOOLEAN;refCon: LONGINT;
 items: Handle): DialogPtr;
 INLINE $AA4B;
FUNCTION NewCDialog(dStorage: Ptr;boundsRect: Rect;title: Str255;visible: BOOLEAN;
 procID: INTEGER;behind: WindowPtr;goAwayFlag: BOOLEAN;refCon: LONGINT;
 items: Handle): DialogPtr;
 INLINE $AA4B;
FUNCTION GetAlertStage: INTEGER;
 INLINE $3EB8,$0A9A;
FUNCTION GetAlrtStage: INTEGER;
 INLINE $3EB8,$0A9A;
PROCEDURE ResetAlertStage;
 INLINE $4278,$0A9A;
PROCEDURE ResetAlrtStage;
 INLINE $4278,$0A9A;
PROCEDURE DialogCut(theDialog: DialogPtr);
PROCEDURE DlgCut(theDialog: DialogPtr);
PROCEDURE DialogPaste(theDialog: DialogPtr);
PROCEDURE DlgPaste(theDialog: DialogPtr);
PROCEDURE DialogCopy(theDialog: DialogPtr);
PROCEDURE DlgCopy(theDialog: DialogPtr);
PROCEDURE DialogDelete(theDialog: DialogPtr);
PROCEDURE DlgDelete(theDialog: DialogPtr);
PROCEDURE SetDialogFont(fontNum: INTEGER);
 INLINE $31DF,$0AFA;
PROCEDURE SetDAFont(fontNum: INTEGER);
 INLINE $31DF,$0AFA;

PROCEDURE AppendDITL(theDialog: DialogPtr;theHandle: Handle;method: DITLMethod);
FUNCTION CountDITL(theDialog: DialogPtr): INTEGER;
PROCEDURE ShortenDITL(theDialog: DialogPtr;numberItems: INTEGER);




{$ENDC} { UsingDialogs }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


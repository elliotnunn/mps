(************************************************************

	File:		TSMTE.p

	Contains:	Definitions for TSMTE

	Copyright:	©1991-1993 Apple Technology, Inc.
				All rights reserved.

************************************************************)

unit TSMTE;

interface

uses TextEdit, Dialogs, TextServices;

const

	{ signature, interface types }
	
	kTSMTESignature = 'tmTE';
	kTSMTEInterfaceType = kTSMTESignature;
	kTSMTEDialog = 'tmDI';
	
	{ Gestalt }
	
	gestaltTSMTEAttr = kTSMTESignature;
	gestaltTSMTEPresent = 0;
	gestaltTSMTE = gestaltTSMTEPresent;	{ old name, for compatibility only }
	gestaltTSMTEVersion = 'tmTV';
	gestaltTSMTE1 = $0100;
	
	{ update flag for TSMTERec }

	kTSMTEAutoScroll = 1;

type

	TSMTERec = record
		textH:			TEHandle;
		preUpdateProc:	ProcPtr;
		postUpdateProc:	ProcPtr;
		updateFlag:		Longint;
		refCon:			Longint;
		end;
	
	TSMTERecPtr = ^TSMTERec;
	TSMTERecHandle = ^TSMTERecPtr;

	TSMDialogRecord = record
		fDialog:		DialogRecord;
		fDocID:			TSMDocumentID;
		fTSMTERecH:		TSMTERecHandle;
		fTSMTERsvd:		array [0..2] of Longint;
		end;

	TSMDialogPeek = ^TSMDialogRecord;

end.

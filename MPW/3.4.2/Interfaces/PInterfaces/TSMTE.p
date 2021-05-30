{
 	File:		TSMTE.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TSMTE;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TSMTE__}
{$SETC __TSMTE__ := 1}

{$I+}
{$SETC TSMTEIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Errors.p													}
{	Memory.p													}
{	Menus.p														}
{	Controls.p													}
{	Windows.p													}
{		Events.p												}
{			OSUtils.p											}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __TEXTSERVICES__}
{$I TextServices.p}
{$ENDC}
{	Components.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kTSMTESignature				= 'tmTE';
	kTSMTEInterfaceType			= 'tmTE';
	kTSMTEDialog				= 'tmDI';

{ update flag for TSMTERec}
	kTSMTEAutoScroll			= 1;

{ callback procedure definitions}
TYPE
	TSMTEPreUpdateProcPtr = ProcPtr;  { PROCEDURE TSMTEPreUpdate(textH: TEHandle; refCon: LONGINT); }
	TSMTEPostUpdateProcPtr = ProcPtr;  { PROCEDURE TSMTEPostUpdate(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT); }
	TSMTEPreUpdateUPP = UniversalProcPtr;
	TSMTEPostUpdateUPP = UniversalProcPtr;

	TSMTERec = RECORD
		textH:					TEHandle;
		preUpdateProc:			TSMTEPreUpdateUPP;
		postUpdateProc:			TSMTEPostUpdateUPP;
		updateFlag:				LONGINT;
		refCon:					LONGINT;
	END;

	TSMTERecPtr = ^TSMTERec;
	TSMTERecHandle = ^TSMTERecPtr;

	TSMDialogRecord = RECORD
		fDialog:				DialogRecord;
		fDocID:					TSMDocumentID;
		fTSMTERecH:				TSMTERecHandle;
		fTSMTERsvd:				ARRAY [0..2] OF LONGINT;				{ reserved}
	END;

	TSMDialogPeek = ^TSMDialogRecord;


CONST
	uppTSMTEPreUpdateProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppTSMTEPostUpdateProcInfo = $000FFFC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param); }

FUNCTION NewTSMTEPreUpdateProc(userRoutine: TSMTEPreUpdateProcPtr): TSMTEPreUpdateUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTSMTEPostUpdateProc(userRoutine: TSMTEPostUpdateProcPtr): TSMTEPostUpdateUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallTSMTEPreUpdateProc(textH: TEHandle; refCon: LONGINT; userRoutine: TSMTEPreUpdateUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTSMTEPostUpdateProc(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT; userRoutine: TSMTEPostUpdateUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TSMTEIncludes}

{$ENDC} {__TSMTE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

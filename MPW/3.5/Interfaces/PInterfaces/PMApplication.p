{
     File:       PMApplication.p
 
     Contains:   Carbon Printing Manager Interfaces.
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PMApplication;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PMAPPLICATION__}
{$SETC __PMAPPLICATION__ := 1}

{$I+}
{$SETC PMApplicationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __PMCORE__}
{$I PMCore.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Callbacks }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PMItemProcPtr = PROCEDURE(theDialog: DialogRef; item: INTEGER);
{$ELSEC}
	PMItemProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMPrintDialogInitProcPtr = PROCEDURE(printSettings: PMPrintSettings; VAR theDialog: PMDialog);
{$ELSEC}
	PMPrintDialogInitProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMPageSetupDialogInitProcPtr = PROCEDURE(pageFormat: PMPageFormat; VAR theDialog: PMDialog);
{$ELSEC}
	PMPageSetupDialogInitProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMSheetDoneProcPtr = PROCEDURE(printSession: PMPrintSession; documentWindow: WindowRef; accepted: BOOLEAN);
{$ELSEC}
	PMSheetDoneProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PMItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PMPrintDialogInitUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMPrintDialogInitUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PMPageSetupDialogInitUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMPageSetupDialogInitUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PMSheetDoneUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMSheetDoneUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPMItemProcInfo = $000002C0;
	uppPMPrintDialogInitProcInfo = $000003C0;
	uppPMPageSetupDialogInitProcInfo = $000003C0;
	uppPMSheetDoneProcInfo = $000007C0;
	{
	 *  NewPMItemUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewPMItemUPP(userRoutine: PMItemProcPtr): PMItemUPP;
{
 *  NewPMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPMPrintDialogInitUPP(userRoutine: PMPrintDialogInitProcPtr): PMPrintDialogInitUPP;
{
 *  NewPMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPMPageSetupDialogInitUPP(userRoutine: PMPageSetupDialogInitProcPtr): PMPageSetupDialogInitUPP;
{
 *  NewPMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPMSheetDoneUPP(userRoutine: PMSheetDoneProcPtr): PMSheetDoneUPP;
{
 *  DisposePMItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMItemUPP(userUPP: PMItemUPP);
{
 *  DisposePMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMPrintDialogInitUPP(userUPP: PMPrintDialogInitUPP);
{
 *  DisposePMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMPageSetupDialogInitUPP(userUPP: PMPageSetupDialogInitUPP);
{
 *  DisposePMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMSheetDoneUPP(userUPP: PMSheetDoneUPP);
{
 *  InvokePMItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMItemUPP(theDialog: DialogRef; item: INTEGER; userRoutine: PMItemUPP);
{
 *  InvokePMPrintDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMPrintDialogInitUPP(printSettings: PMPrintSettings; VAR theDialog: PMDialog; userRoutine: PMPrintDialogInitUPP);
{
 *  InvokePMPageSetupDialogInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMPageSetupDialogInitUPP(pageFormat: PMPageFormat; VAR theDialog: PMDialog; userRoutine: PMPageSetupDialogInitUPP);
{
 *  InvokePMSheetDoneUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMSheetDoneUPP(printSession: PMPrintSession; documentWindow: WindowRef; accepted: BOOLEAN; userRoutine: PMSheetDoneUPP);
{$IFC PM_USE_SESSION_APIS }
{ Print loop }
{
 *  PMSessionBeginDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionBeginDocument(printSession: PMPrintSession; printSettings: PMPrintSettings; pageFormat: PMPageFormat): OSStatus;

{
 *  PMSessionEndDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionEndDocument(printSession: PMPrintSession): OSStatus;

{
 *  PMSessionBeginPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionBeginPage(printSession: PMPrintSession; pageFormat: PMPageFormat; {CONST}VAR pageFrame: PMRect): OSStatus;

{
 *  PMSessionEndPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionEndPage(printSession: PMPrintSession): OSStatus;

{ Session Printing Dialogs }
{
 *  PMSessionPageSetupDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPageSetupDialog(printSession: PMPrintSession; pageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;

{
 *  PMSessionPrintDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPrintDialog(printSession: PMPrintSession; printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;

{
 *  PMSessionPageSetupDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPageSetupDialogInit(printSession: PMPrintSession; pageFormat: PMPageFormat; VAR newDialog: PMDialog): OSStatus;

{
 *  PMSessionPrintDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPrintDialogInit(printSession: PMPrintSession; printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR newDialog: PMDialog): OSStatus;

{
 *  PMSessionPrintDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPrintDialogMain(printSession: PMPrintSession; printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPrintDialogInitUPP): OSStatus;

{
 *  PMSessionPageSetupDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionPageSetupDialogMain(printSession: PMPrintSession; pageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPageSetupDialogInitUPP): OSStatus;

{**********************}
{  Sheets are not available on classic. }
{**********************}
{
 *  PMSessionUseSheets()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSessionUseSheets(printSession: PMPrintSession; documentWindow: WindowRef; sheetDoneProc: PMSheetDoneUPP): OSStatus;

{$ELSEC}
{ Print loop }
{
 *  PMBeginDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMBeginDocument(printSettings: PMPrintSettings; pageFormat: PMPageFormat; VAR printContext: PMPrintContext): OSStatus;

{
 *  PMEndDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMEndDocument(printContext: PMPrintContext): OSStatus;

{
 *  PMBeginPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMBeginPage(printContext: PMPrintContext; {CONST}VAR pageFrame: PMRect): OSStatus;

{
 *  PMEndPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMEndPage(printContext: PMPrintContext): OSStatus;

{ Printing Dialogs }
{
 *  PMPageSetupDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPageSetupDialog(pageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;

{
 *  PMPrintDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrintDialog(printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN): OSStatus;

{
 *  PMPageSetupDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPageSetupDialogInit(pageFormat: PMPageFormat; VAR newDialog: PMDialog): OSStatus;

{**********************}
{  PMPrintDialogInit is not recommended. You should instead use }
{  PMPrintDialogInitWithPageFormat or PMSessionPrintDialogInit }
{**********************}
{
 *  PMPrintDialogInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrintDialogInit(printSettings: PMPrintSettings; VAR newDialog: PMDialog): OSStatus;

{
 *  PMPrintDialogInitWithPageFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrintDialogInitWithPageFormat(printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR newDialog: PMDialog): OSStatus;

{
 *  PMPrintDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPrintDialogMain(printSettings: PMPrintSettings; constPageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPrintDialogInitUPP): OSStatus;

{
 *  PMPageSetupDialogMain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMPageSetupDialogMain(pageFormat: PMPageFormat; VAR accepted: BOOLEAN; myInitProc: PMPageSetupDialogInitUPP): OSStatus;

{$ENDC}  {PM_USE_SESSION_APIS}

{ Printing Dialog accessors }
{
 *  PMGetDialogPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDialogPtr(pmDialog: PMDialog; VAR theDialog: DialogRef): OSStatus;

{
 *  PMGetModalFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetModalFilterProc(pmDialog: PMDialog; VAR filterProc: ModalFilterUPP): OSStatus;

{
 *  PMSetModalFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetModalFilterProc(pmDialog: PMDialog; filterProc: ModalFilterUPP): OSStatus;

{
 *  PMGetItemProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetItemProc(pmDialog: PMDialog; VAR itemProc: PMItemUPP): OSStatus;

{
 *  PMSetItemProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetItemProc(pmDialog: PMDialog; itemProc: PMItemUPP): OSStatus;

{
 *  PMGetDialogAccepted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDialogAccepted(pmDialog: PMDialog; VAR process: BOOLEAN): OSStatus;

{
 *  PMSetDialogAccepted()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetDialogAccepted(pmDialog: PMDialog; process: BOOLEAN): OSStatus;

{
 *  PMGetDialogDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMGetDialogDone(pmDialog: PMDialog; VAR done: BOOLEAN): OSStatus;

{
 *  PMSetDialogDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSetDialogDone(pmDialog: PMDialog; done: BOOLEAN): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PMApplicationIncludes}

{$ENDC} {__PMAPPLICATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

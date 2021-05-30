{
     File:       TSMTE.p
 
     Contains:   Text Services Managerfor TextEdit Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __TEXTSERVICES__}
{$I TextServices.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  signature, interface types }

CONST
	kTSMTESignature				= 'tmTE';
	kTSMTEInterfaceType			= 'tmTE';

	{
	    In Carbon, since DialogRef is opaque, the TSMDialogRecord is removed.
	    Only one kind of TSMTE dialog remains, with extended data managed by TSMTE.
	    Use kTSMTESignature for the dialog refCon, and use the accessors below,
	    i.e. GetTSMTEDialogTSMTERecHandle, to get at the old TSMDialogRecord info.
	}
{$IFC CALL_NOT_IN_CARBON }
	kTSMTEDialog				= 'tmDI';

{$ENDC}  {CALL_NOT_IN_CARBON}

	{  update flag for TSMTERec }
	kTSMTEAutoScroll			= 1;


	{  callback procedure definitions }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TSMTEPreUpdateProcPtr = PROCEDURE(textH: TEHandle; refCon: LONGINT);
{$ELSEC}
	TSMTEPreUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TSMTEPostUpdateProcPtr = PROCEDURE(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT);
{$ELSEC}
	TSMTEPostUpdateProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TSMTEPreUpdateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TSMTEPreUpdateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TSMTEPostUpdateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TSMTEPostUpdateUPP = UniversalProcPtr;
{$ENDC}	


	{  data types }
	TSMTERecPtr = ^TSMTERec;
	TSMTERec = RECORD
		textH:					TEHandle;
		preUpdateProc:			TSMTEPreUpdateUPP;
		postUpdateProc:			TSMTEPostUpdateUPP;
		updateFlag:				LONGINT;
		refCon:					LONGINT;
	END;

	TSMTERecHandle						= ^TSMTERecPtr;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	TSMDialogRecordPtr = ^TSMDialogRecord;
	TSMDialogRecord = RECORD
		fDialog:				DialogRecord;
		fDocID:					TSMDocumentID;
		fTSMTERecH:				TSMTERecHandle;
		fTSMTERsvd:				ARRAY [0..2] OF LONGINT;				{  reserved }
	END;

	TSMDialogPtr						= ^TSMDialogRecord;
	TSMDialogPeek						= TSMDialogPtr;
{$ENDC}


CONST
	uppTSMTEPreUpdateProcInfo = $000003C0;
	uppTSMTEPostUpdateProcInfo = $000FFFC0;
	{
	 *  NewTSMTEPreUpdateUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewTSMTEPreUpdateUPP(userRoutine: TSMTEPreUpdateProcPtr): TSMTEPreUpdateUPP; { old name was NewTSMTEPreUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTSMTEPostUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTSMTEPostUpdateUPP(userRoutine: TSMTEPostUpdateProcPtr): TSMTEPostUpdateUPP; { old name was NewTSMTEPostUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTSMTEPreUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTSMTEPreUpdateUPP(userUPP: TSMTEPreUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTSMTEPostUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTSMTEPostUpdateUPP(userUPP: TSMTEPostUpdateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTSMTEPreUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTSMTEPreUpdateUPP(textH: TEHandle; refCon: LONGINT; userRoutine: TSMTEPreUpdateUPP); { old name was CallTSMTEPreUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTSMTEPostUpdateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTSMTEPostUpdateUPP(textH: TEHandle; fixLen: LONGINT; inputAreaStart: LONGINT; inputAreaEnd: LONGINT; pinStart: LONGINT; pinEnd: LONGINT; refCon: LONGINT; userRoutine: TSMTEPostUpdateUPP); { old name was CallTSMTEPostUpdateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{
 *  IsTSMTEDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsTSMTEDialog(dialog: DialogRef): BOOLEAN;

{ Getters }
{
 *  GetTSMTEDialogDocumentID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTSMTEDialogDocumentID(dialog: DialogRef): TSMDocumentID;

{
 *  GetTSMTEDialogTSMTERecHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTSMTEDialogTSMTERecHandle(dialog: DialogRef): TSMTERecHandle;

{ Setters }
{
 *  SetTSMTEDialogDocumentID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetTSMTEDialogDocumentID(dialog: DialogRef; documentID: TSMDocumentID);

{
 *  SetTSMTEDialogTSMTERecHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetTSMTEDialogTSMTERecHandle(dialog: DialogRef; tsmteRecHandle: TSMTERecHandle);

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TSMTEIncludes}

{$ENDC} {__TSMTE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

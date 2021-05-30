{
     File:       StandardFile.p
 
     Contains:   Standard File package Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT StandardFile;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STANDARDFILE__}
{$SETC __STANDARDFILE__ := 1}

{$I+}
{$SETC StandardFileIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  resource IDs of pre-7.0 get and put dialogs  }
	putDlgID					= -3999;
	getDlgID					= -4000;

																{  item offsets of pre-7.0 get and put dialogs  }
	putSave						= 1;
	putCancel					= 2;
	putEject					= 5;
	putDrive					= 6;
	putName						= 7;
	getOpen						= 1;
	getCancel					= 3;
	getEject					= 5;
	getDrive					= 6;
	getNmList					= 7;
	getScroll					= 8;

																{  resource IDs of 7.0 get and put dialogs  }
	sfPutDialogID				= -6043;
	sfGetDialogID				= -6042;

																{  item offsets of 7.0 get and put dialogs  }
	sfItemOpenButton			= 1;
	sfItemCancelButton			= 2;
	sfItemBalloonHelp			= 3;
	sfItemVolumeUser			= 4;
	sfItemEjectButton			= 5;
	sfItemDesktopButton			= 6;
	sfItemFileListUser			= 7;
	sfItemPopUpMenuUser			= 8;
	sfItemDividerLinePict		= 9;
	sfItemFileNameTextEdit		= 10;
	sfItemPromptStaticText		= 11;
	sfItemNewFolderUser			= 12;

																{  pseudo-item hits for use in DlgHook  }
	sfHookFirstCall				= -1;
	sfHookCharOffset			= $1000;
	sfHookNullEvent				= 100;
	sfHookRebuildList			= 101;
	sfHookFolderPopUp			= 102;
	sfHookOpenFolder			= 103;							{  the following are only in system 7.0+  }
	sfHookLastCall				= -2;
	sfHookOpenAlias				= 104;
	sfHookGoToDesktop			= 105;
	sfHookGoToAliasTarget		= 106;
	sfHookGoToParent			= 107;
	sfHookGoToNextDrive			= 108;
	sfHookGoToPrevDrive			= 109;
	sfHookChangeSelection		= 110;
	sfHookSetActiveOffset		= 200;


	{	 the refcon field of the dialog record during a
	 modalfilter or dialoghook contains one of the following 	}
	sfMainDialogRefCon			= 'stdf';
	sfNewFolderDialogRefCon		= 'nfdr';
	sfReplaceDialogRefCon		= 'rplc';
	sfStatWarnDialogRefCon		= 'stat';
	sfLockWarnDialogRefCon		= 'lock';
	sfErrorDialogRefCon			= 'err ';



TYPE
	SFReplyPtr = ^SFReply;
	SFReply = RECORD
		good:					BOOLEAN;
		copy:					BOOLEAN;
		fType:					OSType;
		vRefNum:				INTEGER;
		version:				INTEGER;
		fName:					StrFileName;							{  a Str63 on MacOS  }
	END;

	StandardFileReplyPtr = ^StandardFileReply;
	StandardFileReply = RECORD
		sfGood:					BOOLEAN;
		sfReplacing:			BOOLEAN;
		sfType:					OSType;
		sfFile:					FSSpec;
		sfScript:				ScriptCode;
		sfFlags:				INTEGER;
		sfIsFolder:				BOOLEAN;
		sfIsVolume:				BOOLEAN;
		sfReserved1:			LONGINT;
		sfReserved2:			INTEGER;
	END;

	{	 for CustomXXXFile, ActivationOrderListPtr parameter is a pointer to an array of item numbers 	}
	ActivationOrderListPtr				= ^INTEGER;
{$IFC TYPED_FUNCTION_POINTERS}
	DlgHookProcPtr = FUNCTION(item: INTEGER; theDialog: DialogRef): INTEGER;
{$ELSEC}
	DlgHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	FileFilterProcPtr = FUNCTION(pb: CInfoPBPtr): BOOLEAN;
{$ELSEC}
	FileFilterProcPtr = ProcPtr;
{$ENDC}

	{	 the following also include an extra parameter of "your data pointer" 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DlgHookYDProcPtr = FUNCTION(item: INTEGER; theDialog: DialogRef; yourDataPtr: UNIV Ptr): INTEGER;
{$ELSEC}
	DlgHookYDProcPtr = ProcPtr;
{$ENDC}

	{	 ModalFilterYDProcPtr moved to Dialogs.h 	}
{$IFC TYPED_FUNCTION_POINTERS}
	FileFilterYDProcPtr = FUNCTION(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr): BOOLEAN;
{$ELSEC}
	FileFilterYDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ActivateYDProcPtr = PROCEDURE(theDialog: DialogRef; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr);
{$ELSEC}
	ActivateYDProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DlgHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DlgHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DlgHookYDUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DlgHookYDUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	FileFilterYDUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FileFilterYDUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ActivateYDUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ActivateYDUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDlgHookProcInfo = $000003A0;
	uppFileFilterProcInfo = $000000D0;
	uppDlgHookYDProcInfo = $00000FA0;
	uppFileFilterYDProcInfo = $000003D0;
	uppActivateYDProcInfo = $000036C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewDlgHookUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewDlgHookUPP(userRoutine: DlgHookProcPtr): DlgHookUPP; { old name was NewDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileFilterUPP(userRoutine: FileFilterProcPtr): FileFilterUPP; { old name was NewFileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDlgHookYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDlgHookYDUPP(userRoutine: DlgHookYDProcPtr): DlgHookYDUPP; { old name was NewDlgHookYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewFileFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewFileFilterYDUPP(userRoutine: FileFilterYDProcPtr): FileFilterYDUPP; { old name was NewFileFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewActivateYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewActivateYDUPP(userRoutine: ActivateYDProcPtr): ActivateYDUPP; { old name was NewActivateYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDlgHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDlgHookUPP(userUPP: DlgHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileFilterUPP(userUPP: FileFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDlgHookYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDlgHookYDUPP(userUPP: DlgHookYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeFileFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFileFilterYDUPP(userUPP: FileFilterYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeActivateYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeActivateYDUPP(userUPP: ActivateYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDlgHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDlgHookUPP(item: INTEGER; theDialog: DialogRef; userRoutine: DlgHookUPP): INTEGER; { old name was CallDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileFilterUPP(pb: CInfoPBPtr; userRoutine: FileFilterUPP): BOOLEAN; { old name was CallFileFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDlgHookYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDlgHookYDUPP(item: INTEGER; theDialog: DialogRef; yourDataPtr: UNIV Ptr; userRoutine: DlgHookYDUPP): INTEGER; { old name was CallDlgHookYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeFileFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFileFilterYDUPP(pb: CInfoPBPtr; yourDataPtr: UNIV Ptr; userRoutine: FileFilterYDUPP): BOOLEAN; { old name was CallFileFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeActivateYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeActivateYDUPP(theDialog: DialogRef; itemNo: INTEGER; activating: BOOLEAN; yourDataPtr: UNIV Ptr; userRoutine: ActivateYDUPP); { old name was CallActivateYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	SFTypeList							= ARRAY [0..3] OF OSType;
	{	
	    The GetFile "typeList" parameter type has changed from "SFTypeList" to "ConstSFTypeListPtr".
	    For C, this will add "const" and make it an in-only parameter.
	    For Pascal, this will require client code to use the @ operator, but make it easier to specify long lists.
	
	    ConstSFTypeListPtr is a pointer to an array of OSTypes.
		}
	ConstSFTypeListPtr					= ^OSType;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SFPutFile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE SFPutFile(where: Point; prompt: ConstStringPtr; origName: Str255; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A9EA;
	{$ENDC}

{
 *  SFGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SFGetFile(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A9EA;
	{$ENDC}

{
 *  SFPPutFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SFPPutFile(where: Point; prompt: ConstStringPtr; origName: Str255; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A9EA;
	{$ENDC}

{
 *  SFPGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SFPGetFile(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9EA;
	{$ENDC}

{
 *  StandardPutFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StandardPutFile(prompt: ConstStringPtr; defaultName: Str255; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0005, $A9EA;
	{$ENDC}

{
 *  StandardGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StandardGetFile(fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0006, $A9EA;
	{$ENDC}

{
 *  CustomPutFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CustomPutFile(prompt: ConstStringPtr; defaultName: Str255; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0007, $A9EA;
	{$ENDC}

{
 *  CustomGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CustomGetFile(fileFilter: FileFilterYDUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activate: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A9EA;
	{$ENDC}

{
 *  StandardOpenDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in Translation 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StandardOpenDialog(VAR reply: StandardFileReply): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StandardFileIncludes}

{$ENDC} {__STANDARDFILE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

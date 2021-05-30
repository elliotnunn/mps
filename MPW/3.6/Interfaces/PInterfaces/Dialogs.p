{
     File:       Dialogs.p
 
     Contains:   Dialog Manager interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Dialogs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DIALOGS__}
{$SETC __DIALOGS__ := 1}

{$I+}
{$SETC DialogsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CARBONEVENTS__}
{$I CarbonEvents.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  new, more standard names for dialog item types }
	kControlDialogItem			= 4;
	kButtonDialogItem			= 4;
	kCheckBoxDialogItem			= 5;
	kRadioButtonDialogItem		= 6;
	kResourceControlDialogItem	= 7;
	kStaticTextDialogItem		= 8;
	kEditTextDialogItem			= 16;
	kIconDialogItem				= 32;
	kPictureDialogItem			= 64;
	kUserDialogItem				= 0;
	kHelpDialogItem				= 1;
	kItemDisableBit				= 128;

																{  old names for dialog item types }
	ctrlItem					= 4;
	btnCtrl						= 0;
	chkCtrl						= 1;
	radCtrl						= 2;
	resCtrl						= 3;
	statText					= 8;
	editText					= 16;
	iconItem					= 32;
	picItem						= 64;
	userItem					= 0;
	itemDisable					= 128;

																{  standard dialog item numbers }
	kStdOkItemIndex				= 1;
	kStdCancelItemIndex			= 2;							{  old names }
	ok							= 1;
	cancel						= 2;

																{  standard icon resource id's     }
	kStopIcon					= 0;
	kNoteIcon					= 1;
	kCautionIcon				= 2;							{  old names }
	stopIcon					= 0;
	noteIcon					= 1;
	cautionIcon					= 2;




{$IFC OLDROUTINENAMES }
	{
	   These constants lived briefly on ETO 16.  They suggest
	   that there is only one index you can use for the OK 
	   item, which is not true.  You can put the ok item 
	   anywhere you want in the DITL.
	}
	kOkItemIndex				= 1;
	kCancelItemIndex			= 2;

{$ENDC}  {OLDROUTINENAMES}

	{	  Dialog Item List Manipulation Constants 	}

TYPE
	DITLMethod							= SInt16;

CONST
	overlayDITL					= 0;
	appendDITLRight				= 1;
	appendDITLBottom			= 2;


TYPE
	StageList							= SInt16;
	{  DialogPtr is obsolete. Use DialogRef instead. }
	DialogRef							= DialogPtr;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	DialogRecordPtr = ^DialogRecord;
	DialogRecord = RECORD
		window:					WindowRecord;							{  in Carbon use GetDialogWindow or GetDialogPort }
		items:					Handle;									{  in Carbon use Get/SetDialogItem }
		textH:					TEHandle;								{  in Carbon use GetDialogTextEditHandle }
		editField:				SInt16;									{  in Carbon use SelectDialogItemText/GetDialogKeyboardFocusItem }
		editOpen:				SInt16;									{  not available in Carbon  }
		aDefItem:				SInt16;									{  in Carbon use Get/SetDialogDefaultItem }
	END;

	DialogPeek							= ^DialogRecord;
{$ENDC}

	DialogTemplatePtr = ^DialogTemplate;
	DialogTemplate = RECORD
		boundsRect:				Rect;
		procID:					SInt16;
		visible:				BOOLEAN;
		filler1:				BOOLEAN;
		goAwayFlag:				BOOLEAN;
		filler2:				BOOLEAN;
		refCon:					SInt32;
		itemsID:				SInt16;
		title:					Str255;
	END;

	DialogTPtr							= ^DialogTemplate;
	DialogTHndl							= ^DialogTPtr;
	AlertTemplatePtr = ^AlertTemplate;
	AlertTemplate = RECORD
		boundsRect:				Rect;
		itemsID:				SInt16;
		stages:					StageList;
	END;

	AlertTPtr							= ^AlertTemplate;
	AlertTHndl							= ^AlertTPtr;
	{	 new type abstractions for the dialog manager 	}
	DialogItemIndexZeroBased			= SInt16;
	DialogItemIndex						= SInt16;
	DialogItemType						= SInt16;
	{	 dialog manager callbacks 	}
{$IFC TYPED_FUNCTION_POINTERS}
	SoundProcPtr = PROCEDURE(soundNumber: SInt16);
{$ELSEC}
	SoundProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ModalFilterProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;
{$ELSEC}
	ModalFilterProcPtr = ProcPtr;
{$ENDC}

	{	 ModalFilterYDProcPtr was previously in StandardFile.h 	}
{$IFC TYPED_FUNCTION_POINTERS}
	ModalFilterYDProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr): BOOLEAN;
{$ELSEC}
	ModalFilterYDProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	UserItemProcPtr = PROCEDURE(theDialog: DialogRef; itemNo: DialogItemIndex);
{$ELSEC}
	UserItemProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SoundUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SoundUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ModalFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ModalFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ModalFilterYDUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ModalFilterYDUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	UserItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	UserItemUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSoundProcInfo = $00000080;
	uppModalFilterProcInfo = $00000FD0;
	uppModalFilterYDProcInfo = $00003FD0;
	uppUserItemProcInfo = $000002C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewSoundUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewSoundUPP(userRoutine: SoundProcPtr): SoundUPP; { old name was NewSoundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewModalFilterUPP(userRoutine: ModalFilterProcPtr): ModalFilterUPP; { old name was NewModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewModalFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewModalFilterYDUPP(userRoutine: ModalFilterYDProcPtr): ModalFilterYDUPP; { old name was NewModalFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewUserItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewUserItemUPP(userRoutine: UserItemProcPtr): UserItemUPP; { old name was NewUserItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposeSoundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeSoundUPP(userUPP: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DisposeModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeModalFilterUPP(userUPP: ModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeModalFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeModalFilterYDUPP(userUPP: ModalFilterYDUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeUserItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeUserItemUPP(userUPP: UserItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InvokeSoundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeSoundUPP(soundNumber: SInt16; userRoutine: SoundUPP); { old name was CallSoundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  InvokeModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeModalFilterUPP(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: DialogItemIndex; userRoutine: ModalFilterUPP): BOOLEAN; { old name was CallModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeModalFilterYDUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeModalFilterYDUPP(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; yourDataPtr: UNIV Ptr; userRoutine: ModalFilterYDUPP): BOOLEAN; { old name was CallModalFilterYDProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeUserItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeUserItemUPP(theDialog: DialogRef; itemNo: DialogItemIndex; userRoutine: UserItemUPP); { old name was CallUserItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTModelessCallbackProcPtr = PROCEDURE(VAR theEvent: EventRecord; theDialog: DialogRef; itemHit: DialogItemIndex); C;
{$ELSEC}
	QTModelessCallbackProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SetModelessDialogCallbackProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE SetModelessDialogCallbackProc(theDialog: DialogRef; callbackProc: QTModelessCallbackProcPtr);

{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
	QTModelessCallbackUPP				= QTModelessCallbackProcPtr;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  GetDialogControlNotificationProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION GetDialogControlNotificationProc(theProc: UNIV Ptr): OSErr;

{
 *  SetDialogMovableModal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetDialogMovableModal(theDialog: DialogRef);

{
 *  GetDialogParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetDialogParent(theDialog: DialogRef): Ptr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Following types are valid with Appearance 1.0 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

CONST
																{  Alert types to pass into StandardAlert  }
	kAlertStopAlert				= 0;
	kAlertNoteAlert				= 1;
	kAlertCautionAlert			= 2;
	kAlertPlainAlert			= 3;


TYPE
	AlertType							= SInt16;

CONST
	kAlertDefaultOKText			= -1;							{  "OK" }
	kAlertDefaultCancelText		= -1;							{  "Cancel" }
	kAlertDefaultOtherText		= -1;							{  "Don't Save" }

	{	 StandardAlert alert button numbers 	}
	kAlertStdAlertOKButton		= 1;
	kAlertStdAlertCancelButton	= 2;
	kAlertStdAlertOtherButton	= 3;
	kAlertStdAlertHelpButton	= 4;

																{  Dialog Flags for use in NewFeaturesDialog or dlgx resource  }
	kDialogFlagsUseThemeBackground = $01;
	kDialogFlagsUseControlHierarchy = $02;
	kDialogFlagsHandleMovableModal = $04;
	kDialogFlagsUseThemeControls = $08;

																{  Alert Flags for use in alrx resource  }
	kAlertFlagsUseThemeBackground = $01;
	kAlertFlagsUseControlHierarchy = $02;
	kAlertFlagsAlertIsMovable	= $04;
	kAlertFlagsUseThemeControls	= $08;

	{	 For dftb resource 	}
	kDialogFontNoFontStyle		= 0;
	kDialogFontUseFontMask		= $0001;
	kDialogFontUseFaceMask		= $0002;
	kDialogFontUseSizeMask		= $0004;
	kDialogFontUseForeColorMask	= $0008;
	kDialogFontUseBackColorMask	= $0010;
	kDialogFontUseModeMask		= $0020;
	kDialogFontUseJustMask		= $0040;
	kDialogFontUseAllMask		= $00FF;
	kDialogFontAddFontSizeMask	= $0100;
	kDialogFontUseFontNameMask	= $0200;
	kDialogFontAddToMetaFontMask = $0400;

	{	 Also for dftb resource. This one is available in Mac OS X or later. 	}
	{	 It corresponds directly to kControlUseThemeFontIDMask from Controls.h. 	}
	kDialogFontUseThemeFontIDMask = $0080;


TYPE
	AlertStdAlertParamRecPtr = ^AlertStdAlertParamRec;
	AlertStdAlertParamRec = RECORD
		movable:				BOOLEAN;								{  Make alert movable modal  }
		helpButton:				BOOLEAN;								{  Is there a help button?  }
		filterProc:				ModalFilterUPP;							{  Event filter  }
		defaultText:			ConstStringPtr;							{  Text for button in OK position  }
		cancelText:				ConstStringPtr;							{  Text for button in cancel position  }
		otherText:				ConstStringPtr;							{  Text for button in left position  }
		defaultButton:			SInt16;									{  Which button behaves as the default  }
		cancelButton:			SInt16;									{  Which one behaves as cancel (can be 0)  }
		position:				UInt16;									{  Position (kWindowDefaultPosition in this case  }
																		{  equals kWindowAlertPositionParentWindowScreen)  }
	END;

	AlertStdAlertParamPtr				= ^AlertStdAlertParamRec;

CONST
	kHICommandOther				= 'othr';						{  sent by standard sheet dialogs when the "other" button is pressed  }

	kStdCFStringAlertVersionOne	= 1;							{  current version of AlertStdCFStringAlertParamRec  }

	{  flags to CreateStandardAlert that are specified in the AlertStdCFStringAlertParamRec.flags field }
	kStdAlertDoNotDisposeSheet	= $01;							{  applies to StandardSheet only; do not dispose of sheet after closing it.  }


TYPE
	AlertStdCFStringAlertParamRecPtr = ^AlertStdCFStringAlertParamRec;
	AlertStdCFStringAlertParamRec = RECORD
		version:				UInt32;									{  kStdCFStringAlertVersionOne  }
		movable:				BOOLEAN;								{  Make alert movable modal  }
		helpButton:				BOOLEAN;								{  Is there a help button?  }
		defaultText:			CFStringRef;							{  Text for button in OK position  }
		cancelText:				CFStringRef;							{  Text for button in cancel position  }
		otherText:				CFStringRef;							{  Text for button in left position  }
		defaultButton:			SInt16;									{  Which button behaves as the default  }
		cancelButton:			SInt16;									{  Which one behaves as cancel (can be 0)  }
		position:				UInt16;									{  Position (kWindowDefaultPosition in this case  }
																		{  equals kWindowAlertPositionParentWindowScreen)  }
		flags:					OptionBits;								{  Options for the behavior of the alert or sheet  }
	END;

	AlertStdCFStringAlertParamPtr		= ^AlertStdCFStringAlertParamRec;
	{  ——— end Appearance 1.0 or later stuff }


	{	
	    NOTE: Code running under MultiFinder or System 7.0 or newer
	    should always pass NULL to InitDialogs.
		}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitDialogs()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE InitDialogs(ignored: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97B;
	{$ENDC}

{
 *  ErrorSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ErrorSound(soundProc: SoundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98C;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97D;
	{$ENDC}

{
 *  GetNewDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewDialog(dialogID: SInt16; dStorage: UNIV Ptr; behind: WindowRef): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97C;
	{$ENDC}

{
 *  NewColorDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewColorDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  CloseDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CloseDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A982;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DisposeDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A983;
	{$ENDC}

{
 *  ModalDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ModalDialog(modalFilter: ModalFilterUPP; VAR itemHit: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A991;
	{$ENDC}

{
 *  IsDialogEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsDialogEvent({CONST}VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97F;
	{$ENDC}

{
 *  DialogSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DialogSelect({CONST}VAR theEvent: EventRecord; VAR theDialog: DialogRef; VAR itemHit: DialogItemIndex): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A980;
	{$ENDC}

{
 *  DrawDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A981;
	{$ENDC}

{
 *  UpdateDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UpdateDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}

{
 *  HideDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HideDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}

{
 *  ShowDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}

{
 *  FindDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindDialogItem(theDialog: DialogRef; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}

{
 *  DialogCut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DialogCut(theDialog: DialogRef);

{
 *  DialogPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DialogPaste(theDialog: DialogRef);

{
 *  DialogCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DialogCopy(theDialog: DialogRef);

{
 *  DialogDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DialogDelete(theDialog: DialogRef);

{
 *  Alert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION Alert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A985;
	{$ENDC}

{
 *  StopAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StopAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A986;
	{$ENDC}

{
 *  NoteAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NoteAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A987;
	{$ENDC}

{
 *  CautionAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CautionAlert(alertID: SInt16; modalFilter: ModalFilterUPP): DialogItemIndex;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A988;
	{$ENDC}

{
 *  GetDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}

{
 *  SetDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDialogItem(theDialog: DialogRef; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}

{
 *  ParamText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ParamText(param0: Str255; param1: Str255; param2: Str255; param3: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98B;
	{$ENDC}

{
 *  SelectDialogItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SelectDialogItemText(theDialog: DialogRef; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97E;
	{$ENDC}

{
 *  GetDialogItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetDialogItemText(item: Handle; VAR text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A990;
	{$ENDC}

{
 *  SetDialogItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDialogItemText(item: Handle; text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98F;
	{$ENDC}

{
 *  GetAlertStage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetAlertStage: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0A9A;
	{$ENDC}

{
 *  SetDialogFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDialogFont(fontNum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}

{
 *  ResetAlertStage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ResetAlertStage;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4278, $0A9A;
	{$ENDC}

{  APIs in Carbon }
{
 *  GetParamText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetParamText(param0: StringPtr; param1: StringPtr; param2: StringPtr; param3: StringPtr);


{
 *  AppendDITL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AppendDITL(theDialog: DialogRef; theHandle: Handle; method: DITLMethod);

{
 *  CountDITL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountDITL(theDialog: DialogRef): DialogItemIndex;

{
 *  ShortenDITL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShortenDITL(theDialog: DialogRef; numberItems: DialogItemIndex);

{
 *  InsertDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InsertDialogItem(theDialog: DialogRef; afterItem: DialogItemIndex; itemType: DialogItemType; itemHandle: Handle; {CONST}VAR box: Rect): OSStatus;

{
 *  RemoveDialogItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveDialogItems(theDialog: DialogRef; itemNo: DialogItemIndex; amountToRemove: DialogItemIndex; disposeItemData: BOOLEAN): OSStatus;

{
 *  StdFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StdFilterProc(theDialog: DialogRef; VAR event: EventRecord; VAR itemHit: DialogItemIndex): BOOLEAN;

{
 *  GetStdFilterProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetStdFilterProc(VAR theProc: ModalFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0203, $AA68;
	{$ENDC}

{
 *  SetDialogDefaultItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDialogDefaultItem(theDialog: DialogRef; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0304, $AA68;
	{$ENDC}

{
 *  SetDialogCancelItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDialogCancelItem(theDialog: DialogRef; newItem: DialogItemIndex): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0305, $AA68;
	{$ENDC}

{
 *  SetDialogTracksCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDialogTracksCursor(theDialog: DialogRef; tracks: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0306, $AA68;
	{$ENDC}



{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Appearance Dialog Routines (available only with Appearance 1.0 and later)
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

{
 *  NewFeaturesDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewFeaturesDialog(inStorage: UNIV Ptr; {CONST}VAR inBoundsRect: Rect; inTitle: Str255; inIsVisible: BOOLEAN; inProcID: SInt16; inBehind: WindowRef; inGoAwayFlag: BOOLEAN; inRefCon: SInt32; inItemListHandle: Handle; inFlags: UInt32): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $110C, $AA68;
	{$ENDC}

{
 *  AutoSizeDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AutoSizeDialog(inDialog: DialogRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AA68;
	{$ENDC}

{
    Regarding StandardAlert and constness:
    Even though the inAlertParam parameter is marked const here, there was
    a chance Dialog Manager would modify it on versions of Mac OS prior to 9.
}
{
 *  StandardAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StandardAlert(inAlertType: AlertType; inError: Str255; inExplanation: Str255; inAlertParam: {Const}AlertStdAlertParamRecPtr; VAR outItemHit: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090E, $AA68;
	{$ENDC}

{  CFString-based StandardAlert and StandardSheet APIs are only available on Mac OS X and later }

{
 *  GetStandardAlertDefaultParams()
 *  
 *  Summary:
 *    Fills out an AlertStdCFStringAlertParamRec with default values: -
 *      not movable -   no help button -   default button with title
 *    "OK" -   no cancel or other buttons
 *  
 *  Parameters:
 *    
 *    param:
 *      The parameter block to initialize.
 *    
 *    version:
 *      The parameter block version; pass kStdCFStringAlertVersionOne.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetStandardAlertDefaultParams(param: AlertStdCFStringAlertParamPtr; version: UInt32): OSStatus;

{
 *  CreateStandardAlert()
 *  
 *  Summary:
 *    Creates an alert containing standard elements and using standard
 *    formatting rules.
 *  
 *  Discussion:
 *    CreateStandardAlert should be used in conjunction with
 *    RunStandardAlert. After CreateStandardAlert returns, the alert is
 *    still invisible. RunStandardAlert will show the alert and run a
 *    modal dialog loop to process events in the alert.
 *  
 *  Parameters:
 *    
 *    alertType:
 *      The type of alert to create.
 *    
 *    error:
 *      The error string to display.
 *    
 *    explanation:
 *      The explanation string to display. May be NULL or empty to
 *      display no explanation.
 *    
 *    param:
 *      The parameter block describing how to create the alert. May be
 *      NULL.
 *    
 *    outAlert:
 *      On exit, contains the new alert.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateStandardAlert(alertType: AlertType; error: CFStringRef; explanation: CFStringRef; param: {Const}AlertStdCFStringAlertParamRecPtr; VAR outAlert: DialogRef): OSStatus;

{
 *  RunStandardAlert()
 *  
 *  Summary:
 *    Shows and runs a standard alert using a modal dialog loop.
 *  
 *  Parameters:
 *    
 *    inAlert:
 *      The alert to display.
 *    
 *    filterProc:
 *      An event filter function for handling events that do not apply
 *      to the alert. May be NULL.
 *    
 *    outItemHit:
 *      On exit, contains the item index of the button that was pressed
 *      to close the alert.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RunStandardAlert(inAlert: DialogRef; filterProc: ModalFilterUPP; VAR outItemHit: DialogItemIndex): OSStatus;

{
 *  CreateStandardSheet()
 *  
 *  Summary:
 *    Creates an alert containing standard elements and using standard
 *    formatting rules, and prepares it to be displayed as a sheet.
 *  
 *  Discussion:
 *    CreateStandardSheet should be used in conjunction with
 *    ShowSheetWindow. After CreateStandardSheet returns, the alert is
 *    still invisible. ShowSheetWindow will show the alert and then
 *    return. Events in the sheet are handled asynchronously; the
 *    application should be prepared for the sheet window to be part of
 *    its windowlist while running its own event loop. When a button in
 *    the sheet is pressed, the EventTargetRef passed to
 *    CreateStandardSheet will receive a command event with one of the
 *    command IDs kHICommandOK, kHICommandCancel, or kHICommandOther.
 *    The sheet is closed before the command is sent.
 *  
 *  Parameters:
 *    
 *    alertType:
 *      The type of alert to create.
 *    
 *    error:
 *      The error string to display.
 *    
 *    explanation:
 *      The explanation string to display. May be NULL or empty to
 *      display no explanation.
 *    
 *    param:
 *      The parameter block describing how to create the alert. May be
 *      NULL.
 *    
 *    notifyTarget:
 *      The event target to be notified when the sheet is closed. The
 *      caller should install an event handler on this target for the
 *      [kEventClassCommand, kEventProcessCommand] event.
 *    
 *    outSheet:
 *      On exit, contains the new alert.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateStandardSheet(alertType: AlertType; error: CFStringRef; explanation: CFStringRef; param: {Const}AlertStdCFStringAlertParamRecPtr; notifyTarget: EventTargetRef; VAR outSheet: DialogRef): OSStatus;

{
 *  CloseStandardSheet()
 *  
 *  Summary:
 *    Closes a standard sheet dialog and releases the dialog data
 *    structures.
 *  
 *  Discussion:
 *    CloseStandardSheet is meant to be used when you need to remove a
 *    sheet because of a higher-priority request to close the sheet's
 *    document window. For example, you might have a Save Changes sheet
 *    open on a document window. Meanwhile, the user drags the document
 *    into the trash. When your application sees that the document has
 *    been moved to the trash, it knows that it should close the
 *    document window, but first it needs to close the sheet.
 *    CloseStandardSheet should not be used by your Carbon event
 *    handler in response to a click in one of the sheet buttons; the
 *    Dialog Manager will close the sheet automatically in that case.
 *    If kStdAlertDoNotDisposeSheet was specified when the sheet was
 *    created, the sheet dialog will be hidden but not released, and
 *    you can reuse the sheet later.
 *  
 *  Parameters:
 *    
 *    inSheet:
 *      The sheet to close.
 *    
 *    inResultCommand:
 *      This command, if not zero, will be sent to the EventTarget
 *      specified when the sheet was created.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloseStandardSheet(inSheet: DialogRef; inResultCommand: UInt32): OSStatus;

{
 *  GetDialogItemAsControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogItemAsControl(inDialog: DialogRef; inItemNo: SInt16; VAR outControl: ControlRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050F, $AA68;
	{$ENDC}

{
 *  MoveDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MoveDialogItem(inDialog: DialogRef; inItemNo: SInt16; inHoriz: SInt16; inVert: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $AA68;
	{$ENDC}

{
 *  SizeDialogItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SizeDialogItem(inDialog: DialogRef; inItemNo: SInt16; inWidth: SInt16; inHeight: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $AA68;
	{$ENDC}

{
 *  AppendDialogItemList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DialogsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AppendDialogItemList(dialog: DialogRef; ditlID: SInt16; method: DITLMethod): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $AA68;
	{$ENDC}

{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Dialog Routines available only with Appearance 1.1 and later
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}

{
 *  SetDialogTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DialogsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDialogTimeout(inDialog: DialogRef; inButtonToPress: SInt16; inSecondsToWait: UInt32): OSStatus;

{
 *  GetDialogTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DialogsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogTimeout(inDialog: DialogRef; VAR outButtonToPress: SInt16; VAR outSecondsToWait: UInt32; VAR outSecondsRemaining: UInt32): OSStatus;

{
 *  SetModalDialogEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DialogsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetModalDialogEventMask(inDialog: DialogRef; inMask: EventMask): OSStatus;

{
 *  GetModalDialogEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DialogsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetModalDialogEventMask(inDialog: DialogRef; VAR outMask: EventMask): OSStatus;



{
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
    • Accessor functions
  —————————————————————————————————————————————————————————————————————————————————————————————————————————
}


{
 *  GetDialogWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogWindow(dialog: DialogRef): WindowRef;


{
 *  GetDialogTextEditHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogTextEditHandle(dialog: DialogRef): TEHandle;


{
 *  GetDialogDefaultItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogDefaultItem(dialog: DialogRef): SInt16;


{
 *  GetDialogCancelItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogCancelItem(dialog: DialogRef): SInt16;


{
 *  GetDialogKeyboardFocusItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogKeyboardFocusItem(dialog: DialogRef): SInt16;


{
 *  SetPortDialogPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortDialogPort(dialog: DialogRef);


{
 *  GetDialogPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogPort(dialog: DialogRef): CGrafPtr;


{
 *  GetDialogFromWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDialogFromWindow(window: WindowRef): DialogRef;



{$IFC CALL_NOT_IN_CARBON }
{
 *  CouldDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CouldDialog(dialogID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A979;
	{$ENDC}

{
 *  FreeDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FreeDialog(dialogID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97A;
	{$ENDC}

{
 *  CouldAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CouldAlert(alertID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A989;
	{$ENDC}

{
 *  FreeAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FreeAlert(alertID: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98A;
	{$ENDC}



{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposDialog(theDialog: DialogRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A983;
	{$ENDC}

{
 *  UpdtDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UpdtDialog(theDialog: DialogRef; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A978;
	{$ENDC}

{
 *  GetDItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetDItem(theDialog: DialogRef; itemNo: DialogItemIndex; VAR itemType: DialogItemType; VAR item: Handle; VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98D;
	{$ENDC}

{
 *  SetDItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetDItem(theDialog: DialogRef; itemNo: DialogItemIndex; itemType: DialogItemType; item: Handle; {CONST}VAR box: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98E;
	{$ENDC}

{
 *  HideDItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE HideDItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A827;
	{$ENDC}

{
 *  ShowDItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShowDItem(theDialog: DialogRef; itemNo: DialogItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A828;
	{$ENDC}

{
 *  SelIText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SelIText(theDialog: DialogRef; itemNo: DialogItemIndex; strtSel: SInt16; endSel: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A97E;
	{$ENDC}

{
 *  GetIText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetIText(item: Handle; VAR text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A990;
	{$ENDC}

{
 *  SetIText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetIText(item: Handle; text: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A98F;
	{$ENDC}

{
 *  FindDItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FindDItem(theDialog: DialogRef; thePt: Point): DialogItemIndexZeroBased;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A984;
	{$ENDC}

{
 *  NewCDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewCDialog(dStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: SInt16; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: SInt32; items: Handle): DialogRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4B;
	{$ENDC}

{
 *  DlgCut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DlgCut(theDialog: DialogRef);

{
 *  DlgPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DlgPaste(theDialog: DialogRef);

{
 *  DlgCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DlgCopy(theDialog: DialogRef);

{
 *  DlgDelete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DlgDelete(theDialog: DialogRef);

{
 *  SetDAFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetDAFont(fontNum: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0AFA;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}






{$IFC NOT TARGET_OS_MAC }
{$ENDC}





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DialogsIncludes}

{$ENDC} {__DIALOGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

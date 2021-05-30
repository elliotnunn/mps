{
     File:       Navigation.p
 
     Contains:   Navigation Services Interfaces
 
     Version:    Technology: Navigation 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Navigation;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __NAVIGATION__}
{$SETC __NAVIGATION__ := 1}

{$I+}
{$SETC NavigationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __TRANSLATION__}
{$I Translation.p}
{$ENDC}
{$I+}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	NavAskSaveChangesAction 	= UInt32;
CONST
																{  input action codes for NavAskSaveChanges()  }
	kNavSaveChangesClosingDocument = 1;
	kNavSaveChangesQuittingApplication = 2;
	kNavSaveChangesOther		= 0;



TYPE
	NavAskSaveChangesResult 	= UInt32;
CONST
																{  result codes for NavAskSaveChanges()  }
	kNavAskSaveChangesSave		= 1;
	kNavAskSaveChangesCancel	= 2;
	kNavAskSaveChangesDontSave	= 3;



TYPE
	NavAskDiscardChangesResult 	= UInt32;
CONST
																{  result codes for NavAskDiscardChanges()  }
	kNavAskDiscardChanges		= 1;
	kNavAskDiscardChangesCancel	= 2;



TYPE
	NavFilterModes 				= SInt16;
CONST
																{  which elements are being filtered for objects:  }
	kNavFilteringBrowserList	= 0;
	kNavFilteringFavorites		= 1;
	kNavFilteringRecents		= 2;
	kNavFilteringShortCutVolumes = 3;
	kNavFilteringLocationPopup	= 4;							{  for v1.1 or greater  }


	kNavFileOrFolderVersion		= 1;


TYPE
	NavFileOrFolderInfoPtr = ^NavFileOrFolderInfo;
	NavFileOrFolderInfo = RECORD
		version:				UInt16;
		isFolder:				BOOLEAN;
		visible:				BOOLEAN;
		creationDate:			UInt32;
		modificationDate:		UInt32;
		CASE INTEGER OF
		0: (
			locked:				BOOLEAN;								{  file is locked  }
			resourceOpen:		BOOLEAN;								{  resource fork is opened  }
			dataOpen:			BOOLEAN;								{  data fork is opened  }
			reserved1:			BOOLEAN;
			dataSize:			UInt32;									{  size of the data fork  }
			resourceSize:		UInt32;									{  size of the resource fork  }
			finderInfo:			FInfo;									{  more file info:  }
			finderXInfo:		FXInfo;
		   );
		1: (
			shareable:			BOOLEAN;
			sharePoint:			BOOLEAN;
			mounted:			BOOLEAN;
			readable:			BOOLEAN;
			writeable:			BOOLEAN;
			reserved2:			BOOLEAN;
			numberOfFiles:		UInt32;
			finderDInfo:		DInfo;
			finderDXInfo:		DXInfo;
			folderType:			OSType;									{  package type, For struct version >= 1  }
			folderCreator:		OSType;									{  package creator, For struct version >= 1  }
			reserved3:			PACKED ARRAY [0..205] OF CHAR;
		   );
	END;

	NavEventDataInfoPtr = ^NavEventDataInfo;
	NavEventDataInfo = RECORD
		CASE INTEGER OF
		0: (
			event:				EventRecordPtr;							{  for event processing  }
			);
		1: (
			param:				Ptr;									{  points to event specific data  }
			);
	END;

	NavEventDataPtr = ^NavEventData;
	NavEventData = RECORD
		eventDataParms:			NavEventDataInfo;						{  the event data  }
		itemHit:				SInt16;									{  the dialog item number, for v1.1 or greater  }
	END;


	{
	 *  NavDialogRef
	 *  
	 *  Summary:
	 *    Opaque Navigation Services dialog identifier
	 *  
	 *  Discussion:
	 *    A NavDialogRef is an opaque reference to an instance of a
	 *    Navigation Services dialog. A new NavDialogRef is returned from
	 *    any of the NavCreateXXXDialog functions and is later disposed
	 *    with the NavDialogDispose function. NavDialogRef is the new name
	 *    for the NavContext type, and thus when a client's event proc is
	 *    called, the value of the NavCBRec.context field is the same as
	 *    the NavDialogRef returned from the corresponding
	 *    NavCreateXXXDialog. A NavDialogRef is distinct from, and is not
	 *    interchangable with, a Dialog Manager DialogRef.
	 	}
	NavDialogRef    = ^LONGINT; { an opaque 32-bit type }
	NavDialogRefPtr = ^NavDialogRef;  { when a VAR xx:NavDialogRef parameter can be nil, it is changed to xx: NavDialogRefPtr }
{$IFC CALL_NOT_IN_CARBON }
	{	 NavContext is the old name for NavDialogRef 	}
	NavContext							= NavDialogRef;
{$ENDC}  {CALL_NOT_IN_CARBON}


	{
	 *  NavUserAction
	 *  
	 *  Summary:
	 *    Indicates which user action dismissed a dialog
	 *  
	 *  Discussion:
	 *    The following values indicate which action was taken by the user
	 *    to dismiss a Navigation Services dialog. NavUserAction is used
	 *    only with Carbon dialogs (dialogs created with the
	 *    NavCreateXXXDialog functions).
	 	}
	NavUserAction 				= UInt32;
CONST
	kNavUserActionNone			= 0;
	kNavUserActionCancel		= 1;
	kNavUserActionOpen			= 2;
	kNavUserActionSaveAs		= 3;
	kNavUserActionChoose		= 4;
	kNavUserActionNewFolder		= 5;
	kNavUserActionSaveChanges	= 6;
	kNavUserActionDontSaveChanges = 7;
	kNavUserActionDiscardChanges = 8;


	kNavCBRecVersion			= 1;


	{
	 *  NavCBRec
	 *  
	 *  Summary:
	 *    A structure passed to event and preview callbacks
	 *  
	 *  Discussion:
	 *    The NavCBRec structure is passed to the client's event proc or
	 *    custom preview proc. It provides information that is specific to
	 *    each event type. New for Carbon: the userAction field.
	 	}

TYPE
	NavCBRecPtr = ^NavCBRec;
	NavCBRec = RECORD
		version:				UInt16;
		context:				NavDialogRef;
		window:					WindowRef;
		customRect:				Rect;
		previewRect:			Rect;
		eventData:				NavEventData;
		userAction:				NavUserAction;
		reserved:				PACKED ARRAY [0..217] OF CHAR;
	END;


	{
	 *  NavEventCallbackMessage
	 *  
	 *  Summary:
	 *    Identifies the message type being sent to the client's event proc
	 	}
	NavEventCallbackMessage 	= SInt32;
CONST
	kNavCBEvent					= 0;
	kNavCBCustomize				= 1;
	kNavCBStart					= 2;
	kNavCBTerminate				= 3;
	kNavCBAdjustRect			= 4;
	kNavCBNewLocation			= 5;
	kNavCBShowDesktop			= 6;
	kNavCBSelectEntry			= 7;
	kNavCBPopupMenuSelect		= 8;
	kNavCBAccept				= 9;
	kNavCBCancel				= 10;
	kNavCBAdjustPreview			= 11;
	kNavCBUserAction			= 12;
	kNavCBOpenSelection			= $80000000;


TYPE
	NavCallBackUserData					= Ptr;
	{	 for events and customization: 	}
{$IFC TYPED_FUNCTION_POINTERS}
	NavEventProcPtr = PROCEDURE(callBackSelector: NavEventCallbackMessage; callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr);
{$ELSEC}
	NavEventProcPtr = ProcPtr;
{$ENDC}

	{	 for preview support: 	}
{$IFC TYPED_FUNCTION_POINTERS}
	NavPreviewProcPtr = FUNCTION(callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr): BOOLEAN;
{$ELSEC}
	NavPreviewProcPtr = ProcPtr;
{$ENDC}

	{	 filtering callback information: 	}
{$IFC TYPED_FUNCTION_POINTERS}
	NavObjectFilterProcPtr = FUNCTION(VAR theItem: AEDesc; info: UNIV Ptr; callBackUD: UNIV Ptr; filterMode: NavFilterModes): BOOLEAN;
{$ELSEC}
	NavObjectFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	NavEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NavEventUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NavPreviewUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NavPreviewUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NavObjectFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NavObjectFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppNavEventProcInfo = $00000FC0;
	uppNavPreviewProcInfo = $000003D0;
	uppNavObjectFilterProcInfo = $00002FD0;
	{
	 *  NewNavEventUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewNavEventUPP(userRoutine: NavEventProcPtr): NavEventUPP; { old name was NewNavEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewNavPreviewUPP(userRoutine: NavPreviewProcPtr): NavPreviewUPP; { old name was NewNavPreviewProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewNavObjectFilterUPP(userRoutine: NavObjectFilterProcPtr): NavObjectFilterUPP; { old name was NewNavObjectFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeNavEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNavEventUPP(userUPP: NavEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNavPreviewUPP(userUPP: NavPreviewUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeNavObjectFilterUPP(userUPP: NavObjectFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeNavEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeNavEventUPP(callBackSelector: NavEventCallbackMessage; callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr; userRoutine: NavEventUPP); { old name was CallNavEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNavPreviewUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeNavPreviewUPP(callBackParms: NavCBRecPtr; callBackUD: UNIV Ptr; userRoutine: NavPreviewUPP): BOOLEAN; { old name was CallNavPreviewProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNavObjectFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeNavObjectFilterUPP(VAR theItem: AEDesc; info: UNIV Ptr; callBackUD: UNIV Ptr; filterMode: NavFilterModes; userRoutine: NavObjectFilterUPP): BOOLEAN; { old name was CallNavObjectFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
	NavCustomControlMessage 	= SInt32;
CONST
	kNavCtlShowDesktop			= 0;							{     show desktop,           parms = nil  }
	kNavCtlSortBy				= 1;							{     sort key field,       parms->NavSortKeyField  }
	kNavCtlSortOrder			= 2;							{     sort order,              parms->NavSortOrder  }
	kNavCtlScrollHome			= 3;							{     scroll list home,       parms = nil  }
	kNavCtlScrollEnd			= 4;							{     scroll list end,      parms = nil  }
	kNavCtlPageUp				= 5;							{     page list up,          parms = nil  }
	kNavCtlPageDown				= 6;							{     page list down,          parms = nil  }
	kNavCtlGetLocation			= 7;							{     get current location,   parms<-AEDesc*  }
	kNavCtlSetLocation			= 8;							{     set current location,   parms->AEDesc*  }
	kNavCtlGetSelection			= 9;							{     get current selection,     parms<-AEDescList*  }
	kNavCtlSetSelection			= 10;							{     set current selection,     parms->AEDescList*  }
	kNavCtlShowSelection		= 11;							{     make selection visible,       parms = nil  }
	kNavCtlOpenSelection		= 12;							{     open view of selection,       parms = nil  }
	kNavCtlEjectVolume			= 13;							{     eject volume,          parms->vRefNum  }
	kNavCtlNewFolder			= 14;							{     create a new folder,     parms->StringPtr  }
	kNavCtlCancel				= 15;							{     cancel dialog,          parms = nil  }
	kNavCtlAccept				= 16;							{     accept dialog default,     parms = nil  }
	kNavCtlIsPreviewShowing		= 17;							{     query preview status,   parms<-Boolean  }
	kNavCtlAddControl			= 18;							{   add one control to dialog,    parms->ControlHandle  }
	kNavCtlAddControlList		= 19;							{     add control list to dialog,    parms->Handle (DITL rsrc)  }
	kNavCtlGetFirstControlID	= 20;							{     get 1st control ID,         parms<-UInt16  }
	kNavCtlSelectCustomType		= 21;							{     select a custom menu item  parms->NavMenuItemSpec*  }
	kNavCtlSelectAllType		= 22;							{   select an "All" menu item parms->SInt16  }
	kNavCtlGetEditFileName		= 23;							{     get save dlog's file name  parms<-StringPtr  }
	kNavCtlSetEditFileName		= 24;							{     set save dlog's file name  parms->StringPtr  }
	kNavCtlSelectEditFileName	= 25;							{     select save dlog file name parms->ControlEditTextSelectionRec*, v1.1 or greater  }
	kNavCtlBrowserSelectAll		= 26;							{   re-scan the browser list  parms = nil, v2.0 or greater  }
	kNavCtlGotoParent			= 27;							{   navigate to parent         parms = nil, v2.0 or greater  }
	kNavCtlSetActionState		= 28;							{   restrict navigation      parms->NavActionState (flags), v2.0 or greater  }
	kNavCtlBrowserRedraw		= 29;							{   rescan browser list      parms = nil, v2.0 or greater  }
	kNavCtlTerminate			= 30;							{   terminate/dismiss dialog  parms = nil, v2.0 or greater  }


TYPE
	NavActionState 				= UInt32;
CONST
	kNavNormalState				= $00000000;					{  normal/default state  }
	kNavDontOpenState			= $00000001;					{  disallow opening files/folders  }
	kNavDontSaveState			= $00000002;					{  disallow saving files  }
	kNavDontChooseState			= $00000004;					{  disallow choosing objects  }
	kNavDontNewFolderState		= $00000010;					{  disallow creating new folders  }


TYPE
	NavPopupMenuItem 			= UInt16;
CONST
	kNavAllKnownFiles			= 0;
	kNavAllReadableFiles		= 1;
	kNavAllFiles				= 2;


TYPE
	NavSortKeyField 			= UInt16;
CONST
	kNavSortNameField			= 0;
	kNavSortDateField			= 1;



TYPE
	NavSortOrder 				= UInt16;
CONST
	kNavSortAscending			= 0;
	kNavSortDescending			= 1;



TYPE
	NavDialogOptionFlags 		= UInt32;
CONST
	kNavDefaultNavDlogOptions	= $000000E4;					{  use defaults for all the options  }
	kNavNoTypePopup				= $00000001;					{  don't show file type/extension popup on Open/Save  }
	kNavDontAutoTranslate		= $00000002;					{  don't automatically translate on Open  }
	kNavDontAddTranslateItems	= $00000004;					{  don't add translation choices on Open/Save  }
	kNavAllFilesInPopup			= $00000010;					{  "All Files" menu item in the type popup on Open  }
	kNavAllowStationery			= $00000020;					{  allow saving of stationery files  }
	kNavAllowPreviews			= $00000040;					{  allow preview to show  }
	kNavAllowMultipleFiles		= $00000080;					{  allow multiple items to be selected  }
	kNavAllowInvisibleFiles		= $00000100;					{  allow invisible items to be shown  }
	kNavDontResolveAliases		= $00000200;					{  don't resolve aliases  }
	kNavSelectDefaultLocation	= $00000400;					{  make the default location the browser selection  }
	kNavSelectAllReadableItem	= $00000800;					{  make the dialog select "All Readable Documents" on open  }
	kNavSupportPackages			= $00001000;					{  recognize file system packages, v2.0 or greater  }
	kNavAllowOpenPackages		= $00002000;					{  allow opening of packages, v2.0 or greater  }
	kNavDontAddRecents			= $00004000;					{  don't add chosen objects to the recents list, v2.0 or greater  }
	kNavDontUseCustomFrame		= $00008000;					{  don't draw the custom area bevel frame, v2.0 or greater  }
	kNavDontConfirmReplacement	= $00010000;					{  don't show the "Replace File?" alert on save conflict, v3.0 or greater  }


TYPE
	NavTranslationOptions 		= UInt32;
CONST
	kNavTranslateInPlace		= 0;							{     translate in place, replacing translation source file (default for Save)  }
	kNavTranslateCopy			= 1;							{     translate to a copy of the source file (default for Open)  }


	kNavMenuItemSpecVersion		= 0;


TYPE
	NavMenuItemSpecPtr = ^NavMenuItemSpec;
	NavMenuItemSpec = RECORD
		version:				UInt16;
		menuCreator:			OSType;
		menuType:				OSType;
		menuItemName:			Str255;
		reserved:				PACKED ARRAY [0..244] OF CHAR;
	END;

	NavMenuItemSpecArray				= ARRAY [0..0] OF NavMenuItemSpec;
	NavMenuItemSpecArrayPtr				= ^NavMenuItemSpecArray;
	NavMenuItemSpecArrayHandle			= ^NavMenuItemSpecArrayPtr;
	NavMenuItemSpecHandle				= NavMenuItemSpecArrayHandle;

CONST
	kNavGenericSignature		= '****';


TYPE
	NavTypeListPtr = ^NavTypeList;
	NavTypeList = RECORD
		componentSignature:		OSType;
		reserved:				INTEGER;
		osTypeCount:			INTEGER;
		osType:					ARRAY [0..0] OF OSType;
	END;

	NavTypeListHandle					= ^NavTypeListPtr;

CONST
	kNavDialogOptionsVersion	= 0;


TYPE
	NavDialogOptionsPtr = ^NavDialogOptions;
	NavDialogOptions = RECORD
		version:				UInt16;
		dialogOptionFlags:		NavDialogOptionFlags;					{  option flags for affecting the dialog's behavior  }
		location:				Point;									{  top-left location of the dialog, or (-1,-1) for default position  }
		clientName:				Str255;
		windowTitle:			Str255;
		actionButtonLabel:		Str255;									{  label of the default button (or null string for default)  }
		cancelButtonLabel:		Str255;									{  label of the cancel button (or null string for default)  }
		savedFileName:			Str255;									{  default name for text box in NavPutFile (or null string for default)  }
		message:				Str255;									{  custom message prompt (or null string for default)  }
		preferenceKey:			UInt32;									{  a key for to managing preferences for using multiple utility dialogs  }
		popupExtension:			NavMenuItemSpecArrayHandle;				{  extended popup menu items, an array of NavMenuItemSpecs  }
		reserved:				PACKED ARRAY [0..493] OF CHAR;
	END;


CONST
	kNavReplyRecordVersion		= 1;


	{
	 *  NavReplyRecord
	 *  
	 *  Summary:
	 *    A structure describing the results of a Nav Services dialog
	 *  
	 *  Discussion:
	 *    A reply record is the result of a Nav Services file dialog. Using
	 *    the older API, which is always modal, the client passes the
	 *    address of a reply record when invoking the dialog. In the Carbon
	 *    API, dialogs may also be window modal or modeless, so the client
	 *    requests the reply record when the dialog is complete using
	 *    NavDialogGetReply. Either way, a reply record should be disposed
	 *    of using NavDisposeReply.
	 	}

TYPE
	NavReplyRecordPtr = ^NavReplyRecord;
	NavReplyRecord = RECORD
		version:				UInt16;
		validRecord:			BOOLEAN;
		replacing:				BOOLEAN;
		isStationery:			BOOLEAN;
		translationNeeded:		BOOLEAN;
		selection:				AEDescList;
		keyScript:				ScriptCode;
		fileTranslation:		FileTranslationSpecArrayHandle;
		reserved1:				UInt32;
		saveFileName:			CFStringRef;
		reserved:				PACKED ARRAY [0..226] OF CHAR;
	END;

	{
	 *  NavLoad()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         not available
	 	}
FUNCTION NavLoad: OSErr;

{
 *  NavUnload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NavUnload: OSErr;

{
 *  NavLibraryVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavLibraryVersion: UInt32;

{
 *  NavGetDefaultDialogOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavGetDefaultDialogOptions(VAR dialogOptions: NavDialogOptions): OSErr;


{
 *  NavGetFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavGetFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; previewProc: NavPreviewUPP; filterProc: NavObjectFilterUPP; typeList: NavTypeListHandle; callBackUD: UNIV Ptr): OSErr;

{
 *  NavPutFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavPutFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; fileType: OSType; fileCreator: OSType; callBackUD: UNIV Ptr): OSErr;

{
 *  NavAskSaveChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavAskSaveChanges(VAR dialogOptions: NavDialogOptions; action: NavAskSaveChangesAction; VAR reply: NavAskSaveChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavCustomAskSaveChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCustomAskSaveChanges(VAR dialogOptions: NavDialogOptions; VAR reply: NavAskSaveChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavAskDiscardChanges()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavAskDiscardChanges(VAR dialogOptions: NavDialogOptions; VAR reply: NavAskDiscardChangesResult; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavChooseFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavChooseFile(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; previewProc: NavPreviewUPP; filterProc: NavObjectFilterUPP; typeList: NavTypeListHandle; callBackUD: UNIV Ptr): OSErr;

{
 *  NavChooseFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavChooseFolder(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavChooseVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavChooseVolume(defaultSelection: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavChooseObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavChooseObject(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; filterProc: NavObjectFilterUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavNewFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavNewFolder(defaultLocation: AEDescPtr; VAR reply: NavReplyRecord; dialogOptions: NavDialogOptionsPtr; eventProc: NavEventUPP; callBackUD: UNIV Ptr): OSErr;

{
 *  NavTranslateFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavTranslateFile(VAR reply: NavReplyRecord; howToTranslate: NavTranslationOptions): OSErr;

{
 *  NavCompleteSave()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCompleteSave(VAR reply: NavReplyRecord; howToTranslate: NavTranslationOptions): OSErr;

{
 *  NavCustomControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCustomControl(dialog: NavDialogRef; selector: NavCustomControlMessage; parms: UNIV Ptr): OSErr;

{
 *  NavCreatePreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreatePreview(VAR theObject: AEDesc; previewDataType: OSType; previewData: UNIV Ptr; previewDataSize: Size): OSErr;

{
 *  NavDisposeReply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDisposeReply(VAR reply: NavReplyRecord): OSErr;

{
 *  NavServicesCanRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NavigationLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION NavServicesCanRun: BOOLEAN;


{$IFC TARGET_RT_MAC_CFM }
{
        NavServicesAvailable() is a macro available only in C/C++.
        To get the same functionality from pascal or assembly, you need
        to test if NavigationLib functions are not NULL and call NavServicesCanRun()
        which will test if NavServices is properly installed.  For instance:

            gNavServicesAvailable = FALSE;
            IF @NavLibraryVersion <> kUnresolvedCFragSymbolAddress THEN
                gNavServicesAvailable = NavServicesCanRun;
            END

}
{$ELSEC}
  {$IFC TARGET_RT_MAC_MACHO }
{ Navigation is always available on OS X }
  {$ELSEC}
{  NavServicesAvailable() is implemented in Navigation.o for classic 68K clients }
  {$IFC CALL_NOT_IN_CARBON }
{
 *  NavServicesAvailable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NavServicesAvailable: BOOLEAN;

  {$ENDC}  {CALL_NOT_IN_CARBON}
  {$ENDC}
{$ENDC}

{ Carbon API }
{ Includes support for Unicode and long file names (where available). }


CONST
	kNavDialogCreationOptionsVersion = 0;



	{
	 *  NavDialogCreationOptions
	 *  
	 *  Summary:
	 *    Options used to control the appearance and operation of a Nav
	 *    Services dialog
	 *  
	 *  Discussion:
	 *    NavDialogCreationOptions is a preferred replacement for
	 *    NavDialogOptions. The new structure uses CFStrings in place of
	 *    Pascal strings, and adds fields for setting the dialog modality
	 *    and the parent window (for sheet dialogs). A
	 *    NavDialogCreationOptions structure can be initialized using
	 *    NavDialogGetDefaultCreationOptions. Each of the
	 *    NavCreateXXXDialog functions accepts a pointer to the client's
	 *    NavDialogCreationOptions structure.
	 	}

TYPE
	NavDialogCreationOptionsPtr = ^NavDialogCreationOptions;
	NavDialogCreationOptions = RECORD
		version:				UInt16;
		optionFlags:			NavDialogOptionFlags;
		location:				Point;
		clientName:				CFStringRef;
		windowTitle:			CFStringRef;
		actionButtonLabel:		CFStringRef;
		cancelButtonLabel:		CFStringRef;
		saveFileName:			CFStringRef;
		message:				CFStringRef;
		preferenceKey:			UInt32;
		popupExtension:			CFArrayRef;
		modality:				WindowModality;
		parentWindow:			WindowRef;
		reserved:				PACKED ARRAY [0..15] OF CHAR;
	END;

	{
	 *  NavGetDefaultDialogCreationOptions()
	 *  
	 *  Summary:
	 *    Initialize the input structure to default values
	 *  
	 *  Discussion:
	 *    Provided as a convenience to obtain the preferred default options
	 *    for use in creating any Nav Services dialog.
	 *  
	 *  Parameters:
	 *    
	 *    outOptions:
	 *      A pointer to the client-allocated options structure to
	 *      initialize
	 *  
	 *  Result:
	 *    A status code
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NavGetDefaultDialogCreationOptions(VAR outOptions: NavDialogCreationOptions): OSStatus; C;


{
 *  NavCreateGetFileDialog()
 *  
 *  Summary:
 *    Create a GetFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for opening
 *    document files. This function replaces NavGetFile, allowing new
 *    window modalities, and adding Unicode support. Upon successful
 *    creation, the dialog is not visible. Present and run the dialog
 *    with NavDialogRun. After the dialog is complete, dispose of it
 *    with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inTypeList:
 *      A creator signature and list of file types to show in the
 *      dialog file browser. If NULL, show all files.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateGetFileDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inTypeList: NavTypeListHandle; inEventProc: NavEventUPP; inPreviewProc: NavPreviewUPP; inFilterProc: NavObjectFilterUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreatePutFileDialog()
 *  
 *  Summary:
 *    Create a PutFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for setting the
 *    name and location of a document file prior to saving. This
 *    function replaces NavPutFile, allowing new window modalities, and
 *    adding Unicode support. Upon successful creation, the dialog is
 *    not visible. Present and run the dialog with NavDialogRun. After
 *    the dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inFileType:
 *      The type of the file to be saved. This parameter is used in
 *      conjunction with the inFileCreator parameter to look up the
 *      kind string for the Format popup menu, and to drive the
 *      identification of translation options.
 *    
 *    inFileCreator:
 *      The creator signature of the file to be saved (see inFileType
 *      parameter)
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreatePutFileDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inFileType: OSType; inFileCreator: OSType; inEventProc: NavEventUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateAskSaveChangesDialog()
 *  
 *  Summary:
 *    Create an AskSaveChanges dialog
 *  
 *  Discussion:
 *    Use this function to create dialog which asks the user to save,
 *    don't save or cancel closing a document with unsaved changes.
 *    This function replaces NavAskSaveChanges and
 *    NavCustomAskSaveChanges, allowing new window modalities, and
 *    adding Unicode support. Upon successful creation, the dialog is
 *    not visible. Present and run the dialog with NavDialogRun. After
 *    the dialog is complete, dispose of it with NavDialogDispose. To
 *    provide a customized message for the alert, specify an non-NULL
 *    message value in the options structure.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inAction:
 *      Indicates this usage context for this dialog: closing a
 *      document or quitting an application. This setting affects the
 *      message text displayed to the user.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateAskSaveChangesDialog({CONST}VAR inOptions: NavDialogCreationOptions; inAction: NavAskSaveChangesAction; inEventProc: NavEventUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateAskDiscardChangesDialog()
 *  
 *  Summary:
 *    Create an AskDiscardChanges dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog which asks the user to
 *    discard changes to a document or cancel. This is most often use
 *    when the user wants to revert a a document to the last saved
 *    revision. This function replaces NavAskDiscardChanges, allowing
 *    new window modalities, and adding Unicode support. Upon
 *    successful creation, the dialog is not visible. Present and run
 *    the dialog with NavDialogRun. After the dialog is complete,
 *    dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateAskDiscardChangesDialog({CONST}VAR inOptions: NavDialogCreationOptions; inEventProc: NavEventUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateChooseFileDialog()
 *  
 *  Summary:
 *    Create a ChooseFile dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting one
 *    file as the target of an operation. A ChooseFile dialog is a
 *    simple version a GetFile dialog. This function replaces
 *    NavChooseFile, allowing new window modalities, and adding Unicode
 *    support. Upon successful creation, the dialog is not visible.
 *    Present and run the dialog with NavDialogRun. After the dialog is
 *    complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inTypeList:
 *      A creator signature and list of file types to show in the
 *      dialog file browser. If NULL, show all files.
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateChooseFileDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inTypeList: NavTypeListHandle; inEventProc: NavEventUPP; inPreviewProc: NavPreviewUPP; inFilterProc: NavObjectFilterUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateChooseFolderDialog()
 *  
 *  Summary:
 *    Create a ChooseFolder dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    folder as the target of an operation. This function replaces
 *    NavChooseFolder, allowing new window modalities, and adding
 *    Unicode support. Upon successful creation, the dialog is not
 *    visible. Present and run the dialog with NavDialogRun. After the
 *    dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateChooseFolderDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inEventProc: NavEventUPP; inFilterProc: NavObjectFilterUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateChooseVolumeDialog()
 *  
 *  Summary:
 *    Create a ChooseVolume dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    volume as the target of an operation. This function replaces
 *    NavChooseVolume, allowing new window modalities, and adding
 *    Unicode support. Upon successful creation, the dialog is not
 *    visible. Present and run the dialog with NavDialogRun. After the
 *    dialog is complete, dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateChooseVolumeDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inEventProc: NavEventUPP; inFilterProc: NavObjectFilterUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateChooseObjectDialog()
 *  
 *  Summary:
 *    Create a ChooseObject dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for selecting a
 *    file, folder, or volume as the target of an operation. This
 *    function replaces NavChooseObject, allowing new window
 *    modalities, and adding Unicode support. Upon successful creation,
 *    the dialog is not visible. Present and run the dialog with
 *    NavDialogRun. After the dialog is complete, dispose of it with
 *    NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inPreviewProc:
 *      The UPP for the client's custom file preview callback, or NULL
 *      for standard previews
 *    
 *    inFilterProc:
 *      The UPP for the client's custom filter callback, or NULL for no
 *      custom file filtering
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateChooseObjectDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inEventProc: NavEventUPP; inPreviewProc: NavPreviewUPP; inFilterProc: NavObjectFilterUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavCreateNewFolderDialog()
 *  
 *  Summary:
 *    Create a NewFolder dialog
 *  
 *  Discussion:
 *    Use this function to create a dialog designed for creating a new
 *    folder. Nav Services creates the folder as specified by the user
 *    and returns a reference to the folder in the selection field of
 *    the reply record. This function replaces NavNewFolder, allowing
 *    new window modalities, and adding Unicode support. Upon
 *    successful creation, the dialog is not visible. Present and run
 *    the dialog with NavDialogRun. After the dialog is complete,
 *    dispose of it with NavDialogDispose.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Options controlling the appearance and behavior of the dialog
 *    
 *    inEventProc:
 *      The UPP for the client's event callack, or NULL for no event
 *      callback
 *    
 *    inClientData:
 *      A client-defined context value passed to all callback functions
 *    
 *    outDialog:
 *      Upon successful completion, a reference to the created dialog
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavCreateNewFolderDialog(inOptions: {Const}NavDialogCreationOptionsPtr; inEventProc: NavEventUPP; inClientData: UNIV Ptr; VAR outDialog: NavDialogRef): OSStatus; C;


{
 *  NavDialogRun()
 *  
 *  Summary:
 *    Show and run a Nav Services dialog
 *  
 *  Discussion:
 *    After a dialog is created with a NavCreateXXXDialog function, the
 *    client can modify the dialog target folder or save file name
 *    using NavCustomControl with the appropriate selectors. The dialog
 *    is finally presented to the user by calling NavDialogRun. If the
 *    dialog is system modal or application modal
 *    (kWindowModalitySystemModal, kWindowModalityAppModal),
 *    NavDialogRun does not return until the dialog has been dismissed.
 *    If the dialog is modeless or window modal (kWindowModalityNone,
 *    kWindowModalityWindowModal), NavDialogRun shows the dialog and
 *    returns immediately. In order to know when the dialog has been
 *    dismissed, the client must watch for the kNavCBUserAction event
 *    sent to the client event proc. Note that on Mac OS 9 and earlier,
 *    all dialogs are modal, even if a modeless or window modal dialog
 *    is requested. However, the kNavCBUserAction event is still sent
 *    to the event proc, so it's possible to use a single programming
 *    model on OS 9 and OS X provided the client assumes NavDialogRun
 *    returns immediately after showing the dialog.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      The dialog to run
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogRun(inDialog: NavDialogRef): OSStatus; C;


{
 *  NavDialogDispose()
 *  
 *  Summary:
 *    Dispose of a Nav Services dialog
 *  
 *  Discussion:
 *    Call this function when completely finished with a Nav Services
 *    dialog. After calling NavDialogDispose, the dialog reference is
 *    no longer valid.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      The dialog to dispose
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE NavDialogDispose(inDialog: NavDialogRef); C;


{
 *  NavDialogGetWindow()
 *  
 *  Summary:
 *    Return the window in which a Nav Services dialog appears
 *  
 *  Discussion:
 *    Note that a valid NavDialogRef may not have a window until
 *    NavDialogRun has been called. If no window exists for the dialog,
 *    NavDialogGetWindow returns NULL.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *  
 *  Result:
 *    The window reference
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogGetWindow(inDialog: NavDialogRef): WindowRef; C;


{
 *  NavDialogGetUserAction()
 *  
 *  Summary:
 *    Return the user action taken to dismiss a Nav Services dialog
 *  
 *  Discussion:
 *    The user action indicates which button was used to dismiss the
 *    dialog. If a dialog has not been dismissed,
 *    NavDialogGetUserAction returns kNavUserActionNone. If the dialog
 *    is terminated using the kNavCtlTerminate NavCustomControl
 *    selector, the final user action is kNavUserActionNone. For file
 *    dialogs, if the final user action is not kNavUserActionCancel,
 *    then there is a valid reply record which can be obtained with
 *    NavDialogGetReply. Although the user action is sent to the client
 *    event proc as a kNavCBUserAction event, this function is provided
 *    as a convenience for clients of modal dialogs who may find it
 *    easier to get the user action immediately after returning from
 *    NavDialogRun.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *  
 *  Result:
 *    The user action
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogGetUserAction(inDialog: NavDialogRef): NavUserAction; C;


{
 *  NavDialogGetReply()
 *  
 *  Summary:
 *    Fill in the provided reply record with the results of the
 *    dismissed dialog.
 *  
 *  Discussion:
 *    Call this function when a file dialog receives a user action
 *    other than kNavUserActionCancel. Upon successful completion, the
 *    reply record contains the results of the dialog session. The
 *    reply record should later be disposed of with NavDisposeReply.
 *  
 *  Parameters:
 *    
 *    inDialog:
 *      Which dialog
 *    
 *    outReply:
 *      A pointer to the client-allocated reply record to be filled in
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogGetReply(inDialog: NavDialogRef; VAR outReply: NavReplyRecord): OSStatus; C;


{
 *  NavDialogGetSaveFileName()
 *  
 *  Summary:
 *    Return the current value of the file name edit text field in a
 *    PutFile dialog
 *  
 *  Discussion:
 *    This function can be called at any time on a valid PutFile dialog
 *    to obtain the current value of the save file name. This function
 *    is a Unicode-based replacement for the kNavCtlGetEditFileName
 *    NavCustomControl selector.
 *  
 *  Parameters:
 *    
 *    inPutFileDialog:
 *      Which dialog
 *  
 *  Result:
 *    The save file name as a CFStringRef. The string is immutable. The
 *    client should retain the string if the reference is to be held
 *    beyond the life of the dialog (standard CF retain/release
 *    semantics).
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogGetSaveFileName(inPutFileDialog: NavDialogRef): CFStringRef; C;


{
 *  NavDialogSetSaveFileName()
 *  
 *  Summary:
 *    Set the current value of the file name edit text field in a
 *    PutFile dialog
 *  
 *  Discussion:
 *    This function can be called at any time to set the current save
 *    file name. Use it to set an initial name before calling
 *    NavDialogRun or to change the file name dynamically while a
 *    dialog is running. This function is a Unicode-based replacement
 *    for the kNavCtlSetEditFileName NavCustomControl selector.
 *  
 *  Parameters:
 *    
 *    inPutFileDialog:
 *      Which PutFile dialog
 *    
 *    inFileName:
 *      The file name to use
 *  
 *  Result:
 *    A status code
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NavDialogSetSaveFileName(inPutFileDialog: NavDialogRef; inFileName: CFStringRef): OSStatus; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := NavigationIncludes}

{$ENDC} {__NAVIGATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

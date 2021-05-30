{
     File:       Editions.p
 
     Contains:   Edition Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Editions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __EDITIONS__}
{$SETC __EDITIONS__ := 1}

{$I+}
{$SETC EditionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  resource types   }
	rSectionType				= 'sect';						{  ResType of saved SectionRecords  }
																{  Finder types for edition files  }
	kPICTEditionFileType		= 'edtp';
	kTEXTEditionFileType		= 'edtt';
	ksndEditionFileType			= 'edts';
	kUnknownEditionFileType		= 'edtu';
	kPublisherDocAliasFormat	= 'alis';
	kPreviewFormat				= 'prvw';
	kFormatListFormat			= 'fmts';

																{  section types  }
	stSubscriber				= $01;
	stPublisher					= $0A;

	sumAutomatic				= 0;							{  subscriber update mode - Automatically      }
	sumManual					= 1;							{  subscriber update mode - Manually  }
	pumOnSave					= 0;							{  publisher update mode - OnSave             }
	pumManual					= 1;							{  publisher update mode - Manually  }

	kPartsNotUsed				= 0;
	kPartNumberUnknown			= -1;

	kPreviewWidth				= 120;
	kPreviewHeight				= 120;

																{  bits for formatsMask  }
	kPICTformatMask				= 1;
	kTEXTformatMask				= 2;
	ksndFormatMask				= 4;


																{  pseudo-item hits for dialogHooks the first is for NewPublisher or NewSubscriber Dialogs  }
	emHookRedrawPreview			= 150;							{  the following are for SectionOptions Dialog  }
	emHookCancelSection			= 160;
	emHookGoToPublisher			= 161;
	emHookGetEditionNow			= 162;
	emHookSendEditionNow		= 162;
	emHookManualUpdateMode		= 163;
	emHookAutoUpdateMode		= 164;


																{  the refcon field of the dialog record during a modalfilter or dialoghook contains one the following  }
	emOptionsDialogRefCon		= 'optn';
	emCancelSectionDialogRefCon	= 'cncl';
	emGoToPubErrDialogRefCon	= 'gerr';

	kFormatLengthUnknown		= -1;

	{	 one byte, stSubscriber or stPublisher 	}

TYPE
	SectionType							= SignedByte;
	{	 seconds since 1904 	}
	TimeStamp							= UInt32;
	{	 similar to ResType 	}
	FormatType							= FourCharCode;
	{	 used in Edition I/O 	}
	EditionRefNum						= Handle;
	{	 update modes 	}
	{	 sumAutomatic, pumSuspend, etc 	}
	UpdateMode							= INTEGER;
	SectionRecordPtr = ^SectionRecord;
	SectionPtr							= ^SectionRecord;
	SectionHandle						= ^SectionPtr;
	SectionRecord = RECORD
		version:				SignedByte;								{  always 0x01 in system 7.0  }
		kind:					SectionType;							{  stSubscriber or stPublisher  }
		mode:					UpdateMode;								{  auto or manual  }
		mdDate:					TimeStamp;								{  last change in document  }
		sectionID:				LONGINT;								{  app. specific, unique per document  }
		refCon:					LONGINT;								{  application specific  }
		alias:					AliasHandle;							{  handle to Alias Record  }
		subPart:				LONGINT;								{  which part of container file  }
		nextSection:			SectionHandle;							{  for linked list of app's Sections  }
		controlBlock:			Handle;									{  used internally  }
		refNum:					EditionRefNum;							{  used internally  }
	END;

	EditionContainerSpecPtr = ^EditionContainerSpec;
	EditionContainerSpec = RECORD
		theFile:				FSSpec;
		theFileScript:			ScriptCode;
		thePart:				LONGINT;
		thePartName:			Str31;
		thePartScript:			ScriptCode;
	END;

	EditionInfoRecordPtr = ^EditionInfoRecord;
	EditionInfoRecord = RECORD
		crDate:					TimeStamp;								{  date EditionContainer was created  }
		mdDate:					TimeStamp;								{  date of last change  }
		fdCreator:				OSType;									{  file creator  }
		fdType:					OSType;									{  file type  }
		container:				EditionContainerSpec;					{  the Edition  }
	END;

	NewPublisherReplyPtr = ^NewPublisherReply;
	NewPublisherReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		replacing:				BOOLEAN;
		usePart:				BOOLEAN;								{  I  }
		filler:					SInt8;
		preview:				Handle;									{  I  }
		previewFormat:			FormatType;								{  I  }
		container:				EditionContainerSpec;					{  I/O  }
	END;

	NewSubscriberReplyPtr = ^NewSubscriberReply;
	NewSubscriberReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		formatsMask:			SignedByte;
		container:				EditionContainerSpec;					{ I/O }
	END;

	SectionOptionsReplyPtr = ^SectionOptionsReply;
	SectionOptionsReply = RECORD
		canceled:				BOOLEAN;								{  O  }
		changed:				BOOLEAN;								{  O  }
		sectionH:				SectionHandle;							{  I  }
		action:					ResType;								{  O  }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ExpModalFilterProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; itemOffset: INTEGER; VAR itemHit: INTEGER; yourDataPtr: Ptr): BOOLEAN;
{$ELSEC}
	ExpModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ExpDlgHookProcPtr = FUNCTION(itemOffset: INTEGER; itemHit: INTEGER; theDialog: DialogRef; yourDataPtr: Ptr): INTEGER;
{$ELSEC}
	ExpDlgHookProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ExpModalFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ExpModalFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ExpDlgHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ExpDlgHookUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppExpModalFilterProcInfo = $0000FBD0;
	uppExpDlgHookProcInfo = $00003EA0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewExpModalFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewExpModalFilterUPP(userRoutine: ExpModalFilterProcPtr): ExpModalFilterUPP; { old name was NewExpModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewExpDlgHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewExpDlgHookUPP(userRoutine: ExpDlgHookProcPtr): ExpDlgHookUPP; { old name was NewExpDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeExpModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeExpModalFilterUPP(userUPP: ExpModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeExpDlgHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeExpDlgHookUPP(userUPP: ExpDlgHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeExpModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeExpModalFilterUPP(theDialog: DialogRef; VAR theEvent: EventRecord; itemOffset: INTEGER; VAR itemHit: INTEGER; yourDataPtr: Ptr; userRoutine: ExpModalFilterUPP): BOOLEAN; { old name was CallExpModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeExpDlgHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeExpDlgHookUPP(itemOffset: INTEGER; itemHit: INTEGER; theDialog: DialogRef; yourDataPtr: Ptr; userRoutine: ExpDlgHookUPP): INTEGER; { old name was CallExpDlgHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	FormatIOVerb 				= SInt8;
CONST
	ioHasFormat					= 0;
	ioReadFormat				= 1;
	ioNewFormat					= 2;
	ioWriteFormat				= 3;


TYPE
	EditionOpenerVerb 			= SInt8;
CONST
	eoOpen						= 0;
	eoClose						= 1;
	eoOpenNew					= 2;
	eoCloseNew					= 3;
	eoCanSubscribe				= 4;



TYPE
	FormatIOParamBlockPtr = ^FormatIOParamBlock;
	FormatIOParamBlock = RECORD
		ioRefNum:				LONGINT;
		format:					FormatType;
		formatIndex:			LONGINT;
		offset:					UInt32;
		buffPtr:				Ptr;
		buffLen:				UInt32;
	END;

	EditionOpenerParamBlockPtr = ^EditionOpenerParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	FormatIOProcPtr = FUNCTION(selector: ByteParameter; VAR PB: FormatIOParamBlock): INTEGER;
{$ELSEC}
	FormatIOProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EditionOpenerProcPtr = FUNCTION(selector: ByteParameter; PB: EditionOpenerParamBlockPtr): INTEGER;
{$ELSEC}
	EditionOpenerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FormatIOUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FormatIOUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	EditionOpenerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EditionOpenerUPP = UniversalProcPtr;
{$ENDC}	
	EditionOpenerParamBlock = RECORD
		info:					EditionInfoRecord;
		sectionH:				SectionHandle;
		document:				FSSpecPtr;
		fdCreator:				OSType;
		ioRefNum:				LONGINT;
		ioProc:					FormatIOUPP;
		success:				BOOLEAN;
		formatsMask:			SignedByte;
	END;


CONST
	uppFormatIOProcInfo = $00000360;
	uppEditionOpenerProcInfo = $00000360;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewFormatIOUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewFormatIOUPP(userRoutine: FormatIOProcPtr): FormatIOUPP; { old name was NewFormatIOProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewEditionOpenerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewEditionOpenerUPP(userRoutine: EditionOpenerProcPtr): EditionOpenerUPP; { old name was NewEditionOpenerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ 
 Section events now arrive in the message buffer using the AppleEvent format.
 The direct object parameter is an aeTemporaryIDParamType ('tid '). The temporary
 ID's type is rSectionType ('sect') and the 32-bit value is a SectionHandle.
 The following is a sample buffer
 
 name       offset  contents
 ----       ------  --------
 header         0   'aevt'
 majorVersion   4   0x01
 minorVersion   6   0x01
 endOfMetaData  8   ';;;;' 
 directObjKey   12  '----' 
 paramType      16  'tid ' 
 paramLength    20  0x0008 
 tempIDType     24  'sect' 
 tempID         28  the SectionHandle <-- this is want you want
}


CONST
	sectionEventMsgClass		= 'sect';
	sectionReadMsgID			= 'read';
	sectionWriteMsgID			= 'writ';
	sectionScrollMsgID			= 'scrl';
	sectionCancelMsgID			= 'cncl';

	currentEditionMgrVers		= $0011;


{$IFC TARGET_RT_MAC_CFM }
	{	 Use InitEditionPackVersion(currentEditionMgrVers) instead of InitEditionPack 	}
{$ELSEC}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitEditionPack()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION InitEditionPack: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0011, $303C, $0100, $A82D;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_RT_MAC_CFM}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitEditionPackVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitEditionPackVersion(curEditionMgrVers: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0100, $A82D;
	{$ENDC}

{
 *  NewSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewSection({CONST}VAR container: EditionContainerSpec; sectionDocument: {Const}FSSpecPtr; kind: SectionType; sectionID: LONGINT; initalMode: UpdateMode; VAR sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A02, $A82D;
	{$ENDC}

{
 *  RegisterSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RegisterSection({CONST}VAR sectionDocument: FSSpec; sectionH: SectionHandle; VAR aliasWasUpdated: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0604, $A82D;
	{$ENDC}

{
 *  UnRegisterSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UnRegisterSection(sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $A82D;
	{$ENDC}

{
 *  IsRegisteredSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsRegisteredSection(sectionH: SectionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0208, $A82D;
	{$ENDC}

{
 *  AssociateSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AssociateSection(sectionH: SectionHandle; {CONST}VAR newSectionDocument: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040C, $A82D;
	{$ENDC}

{
 *  CreateEditionContainerFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CreateEditionContainerFile({CONST}VAR editionFile: FSSpec; fdCreator: OSType; editionFileNameScript: ScriptCode): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A82D;
	{$ENDC}

{
 *  DeleteEditionContainerFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DeleteEditionContainerFile({CONST}VAR editionFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $A82D;
	{$ENDC}

{
 *  OpenEdition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenEdition(subscriberSectionH: SectionHandle; VAR refNum: EditionRefNum): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0412, $A82D;
	{$ENDC}

{
 *  OpenNewEdition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenNewEdition(publisherSectionH: SectionHandle; fdCreator: OSType; publisherSectionDocument: {Const}FSSpecPtr; VAR refNum: EditionRefNum): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0814, $A82D;
	{$ENDC}

{
 *  CloseEdition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CloseEdition(whichEdition: EditionRefNum; successful: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $A82D;
	{$ENDC}

{
 *  EditionHasFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EditionHasFormat(whichEdition: EditionRefNum; whichFormat: FormatType; VAR formatSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0618, $A82D;
	{$ENDC}

{
 *  ReadEdition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ReadEdition(whichEdition: EditionRefNum; whichFormat: FormatType; buffPtr: UNIV Ptr; VAR buffLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081A, $A82D;
	{$ENDC}

{
 *  WriteEdition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WriteEdition(whichEdition: EditionRefNum; whichFormat: FormatType; buffPtr: UNIV Ptr; buffLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081C, $A82D;
	{$ENDC}

{
 *  GetEditionFormatMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetEditionFormatMark(whichEdition: EditionRefNum; whichFormat: FormatType; VAR currentMark: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061E, $A82D;
	{$ENDC}

{
 *  SetEditionFormatMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetEditionFormatMark(whichEdition: EditionRefNum; whichFormat: FormatType; setMarkTo: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0620, $A82D;
	{$ENDC}

{
 *  GetEditionInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetEditionInfo(sectionH: SectionHandle; VAR editionInfo: EditionInfoRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0422, $A82D;
	{$ENDC}

{
 *  GoToPublisherSection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GoToPublisherSection({CONST}VAR container: EditionContainerSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0224, $A82D;
	{$ENDC}

{
 *  GetLastEditionContainerUsed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetLastEditionContainerUsed(VAR container: EditionContainerSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0226, $A82D;
	{$ENDC}

{
 *  GetStandardFormats()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStandardFormats({CONST}VAR container: EditionContainerSpec; VAR previewFormat: FormatType; preview: Handle; publisherAlias: Handle; formats: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A28, $A82D;
	{$ENDC}

{
 *  GetEditionOpenerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetEditionOpenerProc(VAR opener: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022A, $A82D;
	{$ENDC}

{
 *  SetEditionOpenerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetEditionOpenerProc(opener: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $A82D;
	{$ENDC}

{
 *  CallEditionOpenerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CallEditionOpenerProc(selector: ByteParameter; VAR PB: EditionOpenerParamBlock; routine: EditionOpenerUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052E, $A82D;
	{$ENDC}

{
 *  CallFormatIOProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CallFormatIOProc(selector: ByteParameter; VAR PB: FormatIOParamBlock; routine: FormatIOUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0530, $A82D;
	{$ENDC}

{
 *  NewSubscriberDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewSubscriberDialog(VAR reply: NewSubscriberReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0232, $A82D;
	{$ENDC}

{
 *  NewSubscriberExpDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewSubscriberExpDialog(VAR reply: NewSubscriberReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B34, $A82D;
	{$ENDC}

{
 *  NewPublisherDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPublisherDialog(VAR reply: NewPublisherReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0236, $A82D;
	{$ENDC}

{
 *  NewPublisherExpDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPublisherExpDialog(VAR reply: NewPublisherReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B38, $A82D;
	{$ENDC}

{
 *  SectionOptionsDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SectionOptionsDialog(VAR reply: SectionOptionsReply): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023A, $A82D;
	{$ENDC}

{
 *  SectionOptionsExpDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SectionOptionsExpDialog(VAR reply: SectionOptionsReply; where: Point; expansionDITLresID: INTEGER; dlgHook: ExpDlgHookUPP; filter: ExpModalFilterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B3C, $A82D;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EditionsIncludes}

{$ENDC} {__EDITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

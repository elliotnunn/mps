{
 	File:		OCEStandardMail.p
 
 	Contains:	Apple Open Collaboration Environment Standard Mail Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
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
 UNIT OCEStandardMail;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCESTANDARDMAIL__}
{$SETC __OCESTANDARDMAIL__ := 1}

{$I+}
{$SETC OCEStandardMailIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{	Menus.p														}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	Windows.p													}
{	TextEdit.p													}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}

{$IFC UNDEFINED __OCEAUTHDIR__}
{$I OCEAuthDir.p}
{$ENDC}
{	OCE.p														}
{		Aliases.p												}
{		Script.p												}
{			IntlResources.p										}

{$IFC UNDEFINED __OCEMAIL__}
{$I OCEMail.p}
{$ENDC}
{	DigitalSignature.p											}
{	OCEMessaging.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kSMPVersion					= 1;
	gestaltSMPMailerVersion		= 'malr';
	gestaltSMPSPSendLetterVersion = 'spsl';
	kSMPNativeFormatName		= 'natv';


TYPE
	LetterSpec = RECORD
		spec:					ARRAY [0..2] OF LONGINT;
	END;


CONST
	typeLetterSpec				= 'lttr';

{	Wildcard used for filtering letter types. }
	FilterAnyLetter				= 'ltr*';
	FilterAppleLetterContent	= 'ltc*';
	FilterImageContent			= 'lti*';


TYPE
	LetterDescriptor = RECORD
		onDisk:					BOOLEAN;
		filler1:				BOOLEAN;
		CASE INTEGER OF
		0: (
			fileSpec:					FSSpec;
		   );
		1: (
			mailboxSpec:				LetterSpec;
		   );
	END;

{
SMPPSendAs values.  You may add the following values together to determine how the
file is sent, but you may not set both kSMPSendAsEnclosureMask and kSMPSendFileOnlyMask.  This
will allow you to send the letter as an image so that it will work with fax gateways
and send as an enclosure as well.
}

CONST
	kSMPSendAsEnclosureBit		= 0;							{ Appears as letter with enclosures }
	kSMPSendFileOnlyBit			= 1;							{ Appears as a file in mailbox. }
	kSMPSendAsImageBit			= 2;							{ Content imaged in letter }

{ Values of SMPPSendAs }
	kSMPSendAsEnclosureMask		= 1 * (2**(kSMPSendAsEnclosureBit));
	kSMPSendFileOnlyMask		= 1 * (2**(kSMPSendFileOnlyBit));
	kSMPSendAsImageMask			= 1 * (2**(kSMPSendAsImageBit));

	
TYPE
	SMPPSendAs = SignedByte;

	SMPDrawImageProcPtr = ProcPtr;  { PROCEDURE SMPDrawImage(refcon: LONGINT; inColor: BOOLEAN); }
	SMPDrawImageUPP = UniversalProcPtr;

CONST
	uppSMPDrawImageProcInfo = $000001C0; { PROCEDURE (4 byte param, 1 byte param); }

FUNCTION NewSMPDrawImageProc(userRoutine: SMPDrawImageProcPtr): SMPDrawImageUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSMPDrawImageProc(refcon: LONGINT; inColor: BOOLEAN; userRoutine: SMPDrawImageUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SMPRecipientDescriptor = RECORD
		next:					^SMPRecipientDescriptor;				{  Q-Link. }
		result:					OSErr;									{  result code when using the object. }
		recipient:				^OCEPackedRecipient;					{  Pointer to a Packed Address. }
		size:					LONGINT;								{  length of recipient in bytes. }
		theAddress:				MailRecipient;							{  structure points into recipient and theRID. }
		theRID:					RecordID;								{  structure points into recipient. }
	END;

	SMPRecipientDescriptorPtr = ^SMPRecipientDescriptor;

	SMPEnclosureDescriptor = RECORD
		next:					^SMPEnclosureDescriptor;
		result:					OSErr;
		fileSpec:				FSSpec;
		fileCreator:			OSType;									{  Creator of this enclosure. }
		fileType:				OSType;									{  File Type of this enclosure. }
	END;

	SMPEnclosureDescriptorPtr = ^SMPEnclosureDescriptor;

	SMPLetterPB = RECORD
		result:					OSErr;									{ result of operation }
		subject:				RStringPtr;								{ RString }
		senderIdentity:			AuthIdentity;							{ Letter is sent from this Identity }
		toList:					SMPRecipientDescriptorPtr;				{ Pointer to linked list }
		ccList:					SMPRecipientDescriptorPtr;				{ Pointer to linked list }
		bccList:				SMPRecipientDescriptorPtr;				{ Pointer to linked list }
		script:					ScriptCode;								{ Identifier for language }
		textSize:				Size;									{ length of body data }
		textBuffer:				Ptr;									{ body of the letter }
		sendAs:					SMPPSendAs;								{ Send as Letter,Enclosure,Image }
		padByte:				SInt8; (* Byte *)
		enclosures:				SMPEnclosureDescriptorPtr;				{ files to be enclosed }
		drawImageProc:			SMPDrawImageUPP;						{ For imaging }
		imageRefCon:			LONGINT;								{ For imaging }
		supportsColor:			BOOLEAN;								{ For imaging - set to true if you application supports color imaging }
		filler1:				BOOLEAN;
	END;

	SMPLetterPBPtr = ^SMPLetterPB;


CONST
	kSMPAppMustHandleEventBit	= 0;
	kSMPAppShouldIgnoreEventBit	= 1;
	kSMPContractedBit			= 2;
	kSMPExpandedBit				= 3;
	kSMPMailerBecomesTargetBit	= 4;
	kSMPAppBecomesTargetBit		= 5;
	kSMPCursorOverMailerBit		= 6;
	kSMPCreateCopyWindowBit		= 7;
	kSMPDisposeCopyWindowBit	= 8;

{ Values of SMPMailerResult }
	kSMPAppMustHandleEventMask	= 1 * (2**(kSMPAppMustHandleEventBit));
	kSMPAppShouldIgnoreEventMask = 1 * (2**(kSMPAppShouldIgnoreEventBit));
	kSMPContractedMask			= 1 * (2**(kSMPContractedBit));
	kSMPExpandedMask			= 1 * (2**(kSMPExpandedBit));
	kSMPMailerBecomesTargetMask	= 1 * (2**(kSMPMailerBecomesTargetBit));
	kSMPAppBecomesTargetMask	= 1 * (2**(kSMPAppBecomesTargetBit));
	kSMPCursorOverMailerMask	= 1 * (2**(kSMPCursorOverMailerBit));
	kSMPCreateCopyWindowMask	= 1 * (2**(kSMPCreateCopyWindowBit));
	kSMPDisposeCopyWindowMask	= 1 * (2**(kSMPDisposeCopyWindowBit));

	
TYPE
	SMPMailerResult = LONGINT;

{ Values of SMPMailerComponent}

CONST
	kSMPOther					= -1;
	kSMPFrom					= 32;
	kSMPTo						= 20;
	kSMPRegarding				= 22;
	kSMPSendDateTime			= 29;
	kSMPAttachments				= 26;
	kSMPAddressOMatic			= 16;

	
TYPE
	SMPMailerComponent = LONGINT;


CONST
	kSMPToAddress				= kMailToBit;
	kSMPCCAddress				= kMailCcBit;
	kSMPBCCAddress				= kMailBccBit;

	
TYPE
	SMPAddressType = MailAttributeID;


CONST
	kSMPUndoCommand				= 0;
	kSMPCutCommand				= 1;
	kSMPCopyCommand				= 2;
	kSMPPasteCommand			= 3;
	kSMPClearCommand			= 4;
	kSMPSelectAllCommand		= 5;

	
TYPE
	SMPEditCommand = INTEGER;


CONST
	kSMPUndoDisabled			= 0;
	kSMPAppMayUndo				= 1;
	kSMPMailerUndo				= 2;

	
TYPE
	SMPUndoState = INTEGER;

{
SMPSendFormatMask:

Bitfield indicating which combinations of formats are included in,
should be included or, or can be included in a letter.
}

CONST
	kSMPNativeBit				= 0;
	kSMPImageBit				= 1;
	kSMPStandardInterchangeBit	= 2;

{ Values of SMPSendFormatMask }
	kSMPNativeMask				= 1 * (2**(kSMPNativeBit));
	kSMPImageMask				= 1 * (2**(kSMPImageBit));
	kSMPStandardInterchangeMask	= 1 * (2**(kSMPStandardInterchangeBit));

	
TYPE
	SMPSendFormatMask = LONGINT;

{
	Pseudo-events passed to the clients filter proc for initialization and cleanup.
}

CONST
	kSMPSendOptionsStart		= -1;
	kSMPSendOptionsEnd			= -2;

{
SMPSendFormatMask:

Structure describing the format of a letter.  If kSMPNativeMask bit is set, the whichNativeFormat field indicates which of the client-defined formats to use.
}

TYPE
	SMPSendFormat = RECORD
		whichFormats:			SMPSendFormatMask;
		whichNativeFormat:		INTEGER;								{ 0 based }
	END;

	SMPLetterInfo = RECORD
		letterCreator:			OSType;
		letterType:				OSType;
		subject:				RString32;
		sender:					RString32;
	END;


CONST
	kSMPSave					= 0;
	kSMPSaveAs					= 1;
	kSMPSaveACopy				= 2;

	
TYPE
	SMPSaveType = INTEGER;

	FrontWindowProcPtr = ProcPtr;  { FUNCTION FrontWindow(clientData: LONGINT): WindowPtr; }
	PrepareMailerForDrawingProcPtr = ProcPtr;  { PROCEDURE PrepareMailerForDrawing(window: WindowPtr; clientData: LONGINT); }
	SendOptionsFilterProcPtr = ProcPtr;  { FUNCTION SendOptionsFilter(theDialog: DialogPtr; VAR theEvent: EventRecord; itemHit: INTEGER; clientData: LONGINT): BOOLEAN; }
	FrontWindowUPP = UniversalProcPtr;
	PrepareMailerForDrawingUPP = UniversalProcPtr;
	SendOptionsFilterUPP = UniversalProcPtr;

CONST
	uppFrontWindowProcInfo = $000000F0; { FUNCTION (4 byte param): 4 byte result; }
	uppPrepareMailerForDrawingProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppSendOptionsFilterProcInfo = $00003BD0; { FUNCTION (4 byte param, 4 byte param, 2 byte param, 4 byte param): 1 byte result; }

FUNCTION NewFrontWindowProc(userRoutine: FrontWindowProcPtr): FrontWindowUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewPrepareMailerForDrawingProc(userRoutine: PrepareMailerForDrawingProcPtr): PrepareMailerForDrawingUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSendOptionsFilterProc(userRoutine: SendOptionsFilterProcPtr): SendOptionsFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallFrontWindowProc(clientData: LONGINT; userRoutine: FrontWindowUPP): WindowPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallPrepareMailerForDrawingProc(window: WindowPtr; clientData: LONGINT; userRoutine: PrepareMailerForDrawingUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallSendOptionsFilterProc(theDialog: DialogPtr; VAR theEvent: EventRecord; itemHit: INTEGER; clientData: LONGINT; userRoutine: SendOptionsFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SMPMailerState = RECORD
		mailerCount:			INTEGER;
		currentMailer:			INTEGER;
		upperLeft:				Point;
		hasBeenReceived:		BOOLEAN;
		isTarget:				BOOLEAN;
		isExpanded:				BOOLEAN;
		canMoveToTrash:			BOOLEAN;
		canTag:					BOOLEAN;
		padByte2:				SInt8; (* Byte *)
		changeCount:			LONGINT;
		targetComponent:		SMPMailerComponent;
		canCut:					BOOLEAN;
		canCopy:				BOOLEAN;
		canPaste:				BOOLEAN;
		canClear:				BOOLEAN;
		canSelectAll:			BOOLEAN;
		padByte3:				SInt8; (* Byte *)
		undoState:				SMPUndoState;
		undoWhat:				Str63;
	END;

	SMPSendOptions = RECORD
		signWhenSent:			BOOLEAN;
		priority:				IPMPriority;
	END;

	SMPSendOptionsPtr = ^SMPSendOptions;
	SMPSendOptionsHandle = ^SMPSendOptionsPtr;

	SMPCloseOptions = RECORD
		moveToTrash:			BOOLEAN;
		addTag:					BOOLEAN;
		tag:					RString32;
	END;

	SMPCloseOptionsPtr = ^SMPCloseOptions;

{----------------------------------------------------------------------------------------
	Send Package Routines
----------------------------------------------------------------------------------------}

FUNCTION SMPSendLetter(theLetter: SMPLetterPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 500, $AA5D;
	{$ENDC}
FUNCTION SMPNewPage(VAR newHeader: OpenCPicParams): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2100, $AA5D;
	{$ENDC}
FUNCTION SMPImageErr: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 0, 2101, $AA5D;
	{$ENDC}
FUNCTION SMPResolveToRecipient(dsSpec: PackedDSSpecPtr; VAR recipientList: SMPRecipientDescriptorPtr; identity: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 1100, $AA5D;
	{$ENDC}
FUNCTION SMPInitMailer(mailerVersion: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4741, $AA5D;
	{$ENDC}
FUNCTION SMPGetDimensions(VAR width: INTEGER; VAR contractedHeight: INTEGER; VAR expandedHeight: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 4700, $AA5D;
	{$ENDC}
FUNCTION SMPGetTabInfo(VAR firstTab: SMPMailerComponent; VAR lastTab: SMPMailerComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4724, $AA5D;
	{$ENDC}
FUNCTION SMPNewMailer(window: WindowPtr; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; identity: AuthIdentity; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 12, 4701, $AA5D;
	{$ENDC}
FUNCTION SMPPrepareToClose(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4743, $AA5D;
	{$ENDC}
FUNCTION SMPCloseOptionsDialog(window: WindowPtr; closeOptions: SMPCloseOptionsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4744, $AA5D;
	{$ENDC}
FUNCTION SMPTagDialog(window: WindowPtr; VAR theTag: RString32): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4747, $AA5D;
	{$ENDC}
FUNCTION SMPDisposeMailer(window: WindowPtr; closeOptions: SMPCloseOptionsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4702, $AA5D;
	{$ENDC}
FUNCTION SMPMailerEvent({CONST}VAR event: EventRecord; VAR whatHappened: SMPMailerResult; frontWindowCB: FrontWindowUPP; clientData: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 8, 4703, $AA5D;
	{$ENDC}
FUNCTION SMPClearUndo(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4725, $AA5D;
	{$ENDC}
FUNCTION SMPMailerEditCommand(window: WindowPtr; command: SMPEditCommand; VAR whatHappened: SMPMailerResult): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 5, 4704, $AA5D;
	{$ENDC}
FUNCTION SMPMailerForward(window: WindowPtr; from: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4705, $AA5D;
	{$ENDC}
FUNCTION SMPMailerReply(originalLetter: WindowPtr; newLetter: WindowPtr; replyToAll: BOOLEAN; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; identity: AuthIdentity; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 15, 4706, $AA5D;
	{$ENDC}
FUNCTION SMPGetMailerState(window: WindowPtr; VAR itsState: SMPMailerState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4707, $AA5D;
	{$ENDC}
FUNCTION SMPSendOptionsDialog(window: WindowPtr; VAR documentName: Str255; VAR nativeFormatNames: StringPtr; nameCount: INTEGER; canSend: SMPSendFormatMask; VAR currentFormat: SMPSendFormat; filterProc: SendOptionsFilterUPP; clientData: LONGINT; VAR shouldSend: SMPSendFormat; sendOptions: SMPSendOptionsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 19, 5000, $AA5D;
	{$ENDC}
FUNCTION SMPPrepareCoverPages(window: WindowPtr; VAR pageCount: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4708, $AA5D;
	{$ENDC}
FUNCTION SMPDrawNthCoverPage(window: WindowPtr; pageNumber: INTEGER; doneDrawingCoverPages: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4709, $AA5D;
	{$ENDC}
FUNCTION SMPPrepareToChange(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4745, $AA5D;
	{$ENDC}
FUNCTION SMPContentChanged(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4719, $AA5D;
	{$ENDC}
FUNCTION SMPBeginSave(window: WindowPtr; {CONST}VAR diskLetter: FSSpec; creator: OSType; fileType: OSType; saveType: SMPSaveType; VAR mustAddContent: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 11, 4710, $AA5D;
	{$ENDC}
FUNCTION SMPEndSave(window: WindowPtr; okToSave: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 4720, $AA5D;
	{$ENDC}
FUNCTION SMPBeginSend(window: WindowPtr; creator: OSType; fileType: OSType; sendOptions: SMPSendOptionsPtr; VAR mustAddContent: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 10, 4711, $AA5D;
	{$ENDC}
FUNCTION SMPEndSend(window: WindowPtr; okToSend: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 4721, $AA5D;
	{$ENDC}
FUNCTION SMPOpenLetter({CONST}VAR letter: LetterDescriptor; window: WindowPtr; upperLeft: Point; canContract: BOOLEAN; initiallyExpanded: BOOLEAN; prepareMailerForDrawingCB: PrepareMailerForDrawingUPP; clientData: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 12, 4712, $AA5D;
	{$ENDC}
FUNCTION SMPAddMainEnclosure(window: WindowPtr; {CONST}VAR enclosure: FSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4733, $AA5D;
	{$ENDC}
FUNCTION SMPGetMainEnclosureFSSpec(window: WindowPtr; VAR enclosureDir: FSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4734, $AA5D;
	{$ENDC}
FUNCTION SMPAddContent(window: WindowPtr; segmentType: MailSegmentType; appendFlag: BOOLEAN; buffer: UNIV Ptr; bufferSize: LONGINT; textScrap: StScrpPtr; startNewScript: BOOLEAN; script: ScriptCode): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 12, 4730, $AA5D;
	{$ENDC}
FUNCTION SMPReadContent(window: WindowPtr; segmentTypeMask: MailSegmentMask; buffer: UNIV Ptr; bufferSize: LONGINT; VAR dataSize: LONGINT; textScrap: StScrpPtr; VAR script: ScriptCode; VAR segmentType: MailSegmentType; VAR endOfScript: BOOLEAN; VAR endOfSegment: BOOLEAN; VAR endOfContent: BOOLEAN; VAR segmentLength: LONGINT; VAR segmentID: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 25, 4731, $AA5D;
	{$ENDC}
FUNCTION SMPGetFontNameFromLetter(window: WindowPtr; fontNum: INTEGER; VAR fontName: Str255; doneWithFontTable: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 4732, $AA5D;
	{$ENDC}
FUNCTION SMPAddBlock(window: WindowPtr; {CONST}VAR blockType: OCECreatorType; append: BOOLEAN; buffer: UNIV Ptr; bufferSize: LONGINT; mode: MailBlockMode; offset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 12, 4735, $AA5D;
	{$ENDC}
FUNCTION SMPReadBlock(window: WindowPtr; {CONST}VAR blockType: OCECreatorType; blockIndex: INTEGER; buffer: UNIV Ptr; bufferSize: LONGINT; dataOffset: LONGINT; VAR dataSize: LONGINT; VAR endOfBlock: BOOLEAN; VAR remaining: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 17, 4736, $AA5D;
	{$ENDC}
FUNCTION SMPEnumerateBlocks(window: WindowPtr; startIndex: INTEGER; buffer: UNIV Ptr; bufferSize: LONGINT; VAR dataSize: LONGINT; VAR nextIndex: INTEGER; VAR more: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 13, 4737, $AA5D;
	{$ENDC}
FUNCTION SMPDrawMailer(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4713, $AA5D;
	{$ENDC}
FUNCTION SMPSetSubject(window: WindowPtr; {CONST}VAR text: RString): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4715, $AA5D;
	{$ENDC}
FUNCTION SMPSetFromIdentity(window: WindowPtr; from: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4716, $AA5D;
	{$ENDC}
FUNCTION SMPAddAddress(window: WindowPtr; addrType: SMPAddressType; VAR address: OCEPackedRecipient): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 5, 4717, $AA5D;
	{$ENDC}
FUNCTION SMPAddAttachment(window: WindowPtr; {CONST}VAR attachment: FSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4718, $AA5D;
	{$ENDC}
FUNCTION SMPAttachDialog(window: WindowPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 4726, $AA5D;
	{$ENDC}
FUNCTION SMPExpandOrContract(window: WindowPtr; expand: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 4722, $AA5D;
	{$ENDC}
FUNCTION SMPMoveMailer(window: WindowPtr; dh: INTEGER; dv: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4714, $AA5D;
	{$ENDC}
FUNCTION SMPBecomeTarget(window: WindowPtr; becomeTarget: BOOLEAN; whichField: SMPMailerComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 5, 4723, $AA5D;
	{$ENDC}
FUNCTION SMPGetComponentSize(window: WindowPtr; whichMailer: INTEGER; whichField: SMPMailerComponent; VAR size: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 7, 4727, $AA5D;
	{$ENDC}
FUNCTION SMPGetComponentInfo(window: WindowPtr; whichMailer: INTEGER; whichField: SMPMailerComponent; buffer: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 7, 4728, $AA5D;
	{$ENDC}
FUNCTION SMPGetListItemInfo(window: WindowPtr; whichMailer: INTEGER; whichField: SMPMailerComponent; buffer: UNIV Ptr; bufferLength: LONGINT; startItem: INTEGER; VAR itemCount: INTEGER; VAR nextItem: INTEGER; VAR more: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 16, 4729, $AA5D;
	{$ENDC}
FUNCTION SMPImage(window: WindowPtr; drawImageProc: SMPDrawImageUPP; imageRefCon: LONGINT; supportsColor: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 7, 4738, $AA5D;
	{$ENDC}
FUNCTION SMPGetNextLetter(VAR typesList: OSType; numTypes: INTEGER; VAR adjacentLetter: LetterDescriptor): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 5, 4742, $AA5D;
	{$ENDC}
FUNCTION SMPGetLetterInfo(VAR mailboxSpec: LetterSpec; VAR info: SMPLetterInfo): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 4746, $AA5D;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEStandardMailIncludes}

{$ENDC} {__OCESTANDARDMAIL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

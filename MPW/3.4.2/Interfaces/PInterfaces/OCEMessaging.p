{
 	File:		OCEMessaging.p
 
 	Contains:	Apple Open Collaboration Environment Messaging Interfaces.
 
 	Version:	Technology:	AOCE Toolbox 1.02
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
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
 UNIT OCEMessaging;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEMESSAGING__}
{$SETC __OCEMESSAGING__ := 1}

{$I+}
{$SETC OCEMessagingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{		ConditionalMacros.p										}
{	Types.p														}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$IFC UNDEFINED __DIGITALSIGNATURE__}
{$I DigitalSignature.p}
{$ENDC}

{$IFC UNDEFINED __OCE__}
{$I OCE.p}
{$ENDC}
{	Aliases.p													}
{	Script.p													}
{		IntlResources.p											}

{$IFC UNDEFINED __OCEAUTHDIR__}
{$I OCEAuthDir.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{****************************************************************************}
{ Definitions common to OCEMessaging and to OCEMail. These relate to addressing,
message ids and priorities, etc. }
{ Values of IPMPriority }

CONST
	kIPMAnyPriority				= 0;							{ FOR FILTER ONLY }
	kIPMNormalPriority			= 1;
	kIPMLowPriority				= 2;
	kIPMHighPriority			= 3;

	
TYPE
	IPMPriority = SignedByte;

{ Values of IPMAccessMode }

CONST
	kIPMAtMark					= 0;
	kIPMFromStart				= 1;
	kIPMFromLEOM				= 2;
	kIPMFromMark				= 3;

	
TYPE
	IPMAccessMode = INTEGER;


CONST
	kIPMUpdateMsgBit			= 4;
	kIPMNewMsgBit				= 5;
	kIPMDeleteMsgBit			= 6;

{ Values of IPMNotificationType }
	kIPMUpdateMsgMask			= 1 * (2**(kIPMUpdateMsgBit));
	kIPMNewMsgMask				= 1 * (2**(kIPMNewMsgBit));
	kIPMDeleteMsgMask			= 1 * (2**(kIPMDeleteMsgBit));

	
TYPE
	IPMNotificationType = SignedByte;

{ Values of IPMSenderTag }

CONST
	kIPMSenderRStringTag		= 0;
	kIPMSenderRecordIDTag		= 1;

	
TYPE
	IPMSenderTag = INTEGER;


CONST
	kIPMFromDistListBit			= 0;
	kIPMDummyRecBit				= 1;
	kIPMFeedbackRecBit			= 2;							{ should be redirected to feedback queue }
	kIPMReporterRecBit			= 3;							{ should be redirected to reporter original queue }
	kIPMBCCRecBit				= 4;							{ this recipient is blind to all recipients of message }

{ Values of OCERecipientOffsetFlags }
	kIPMFromDistListMask		= 1 * (2**(kIPMFromDistListBit));
	kIPMDummyRecMask			= 1 * (2**(kIPMDummyRecBit));
	kIPMFeedbackRecMask			= 1 * (2**(kIPMFeedbackRecBit));
	kIPMReporterRecMask			= 1 * (2**(kIPMReporterRecBit));
	kIPMBCCRecMask				= 1 * (2**(kIPMBCCRecBit));

	
TYPE
	OCERecipientOffsetFlags = SignedByte;

	OCECreatorType = RECORD
		msgCreator:				OSType;
		msgType:				OSType;
	END;


CONST
	kIPMTypeWildCard			= 'ipmw';
	kIPMFamilyUnspecified		= 0;
	kIPMFamilyWildCard			= $3F3F3F3F;					{ '??^ 

	* well known signature }
	kIPMSignature				= 'ipms';						{ base type 

	* well known message types }
	kIPMReportNotify			= 'rptn';						{ routing feedback

    * well known message block types }
	kIPMEnclosedMsgType			= 'emsg';						{ enclosed (nested) message }
	kIPMReportInfo				= 'rpti';						{ recipient information }
	kIPMDigitalSignature		= 'dsig';

{ Values of IPMMsgFormat }
	kIPMOSFormatType			= 1;
	kIPMStringFormatType		= 2;

	
TYPE
	IPMMsgFormat = INTEGER;

	IPMStringMsgType = Str32;

	TheType = RECORD
		CASE INTEGER OF
		0: (
			msgOSType:					OCECreatorType;
		   );
		1: (
			msgStrType:					IPMStringMsgType;
		   );
	END;

	IPMMsgType = RECORD
		format:					IPMMsgFormat;							{ IPMMsgFormat}
		theType:				TheType;
	END;

{
Following are the known extension values for IPM addresses handled by Apple.
We define the definition of the entn extension below.
}

CONST
	kOCEalanXtn					= 'alan';
	kOCEentnXtn					= 'entn';						{ entn = entity name (aka DSSpec) }
	kOCEaphnXtn					= 'aphn';

{
Following are the specific definitions for the extension for the standard
OCEMail 'entn' addresses.  [Note, the actual extension is formatted as in
IPMEntityNameExtension.]
}
{ entn extension forms }
	kOCEAddrXtn					= 'addr';
	kOCEQnamXtn					= 'qnam';
	kOCEAttrXtn					= 'attr';						{ an attribute specification }
	kOCESpAtXtn					= 'spat';

{
Following are the specific definitions for standard
OCEMail 'aphn' extension value.  

All RStrings here are packed (e.g. truncated to length) and even padded (e.g.
if length odd, then a pad byte (zero) should be introduced before the next field).

The extension value is in the packed form of the following structure:
	RString		phoneNumber;
	RString		modemType;
	Str32		queueuName;

The body of phoneNumber compound RString is in the packed form of the following structure:
	short 		subType;
	RString 	countryCode;				// used when subType == kOCEUseHandyDial
	RString		areaCode;					// used when subType == kOCEUseHandyDial
	RString		phone;						// used when subType == kOCEUseHandyDial
	RString		postFix;					// used when subType == kOCEUseHandyDial
	RString		nonHandyDialString;			// used when subType == kOCEDontUseHandyDial
}
{ phoneNumber sub type constants }
	kOCEUseHandyDial			= 1;
	kOCEDontUseHandyDial		= 2;

{ FORMAT OF A PACKED FORM RECIPIENT }

TYPE
	ProtoOCEPackedRecipient = RECORD
		dataLength:				INTEGER;
	END;


CONST
	kOCEPackedRecipientMaxBytes	= 0+(4096 - sizeof(ProtoOCEPackedRecipient));


TYPE
	OCEPackedRecipient = RECORD
		dataLength:				INTEGER;
		data:					ARRAY [0..kOCEPackedRecipientMaxBytes-1] OF SInt8; (* Byte *)
	END;

	IPMEntnQueueExtension = RECORD
		queueName:				Str32;
	END;

{ kOCEAttrXtn }
	IPMEntnAttributeExtension = RECORD
		attributeName:			AttributeType;
	END;

{ kOCESpAtXtn }
	IPMEntnSpecificAttributeExtension = RECORD
		attributeCreationID:	AttributeCreationID;
		attributeName:			AttributeType;
	END;

{ All IPM entn extensions fit within the following }
	IPMEntityNameExtension = RECORD
		subExtensionType:		OSType;
		CASE INTEGER OF
		0: (
			specificAttribute:			IPMEntnSpecificAttributeExtension;
		   );
		1: (
			attribute:					IPMEntnAttributeExtension;
		   );
		2: (
			queue:						IPMEntnQueueExtension;
		   );

	END;

{ addresses with kIPMNBPXtn should specify this nbp type }
	IPMMsgID = RECORD
		id:						ARRAY [0..3] OF LONGINT;
	END;

{ Values of IPMHeaderSelector }

CONST
	kIPMTOC						= 0;
	kIPMSender					= 1;
	kIPMProcessHint				= 2;
	kIPMMessageTitle			= 3;
	kIPMMessageType				= 4;
	kIPMFixedInfo				= 7;

	
TYPE
	IPMHeaderSelector = SInt8;

	TheSender = RECORD
		CASE INTEGER OF
		0: (
			rString:					RString;
		   );
		1: (
			rid:						PackedRecordID;
		   );
	END;

	IPMSender = RECORD
		sendTag:				IPMSenderTag;
		theSender:				TheSender;
	END;

{****************************************************************************}
{ Definitions specific to OCEMessaging }
	IPMContextRef = LONGINT;

	IPMQueueRef = LONGINT;

	IPMMsgRef = LONGINT;

	IPMSeqNum = LONGINT;

	IPMProcHint = Str32;

	IPMQueueName = Str32;

	IPMNoteProcPtr = ProcPtr;  { PROCEDURE IPMNote(queue: IPMQueueRef; seqNum: IPMSeqNum; notificationType: ByteParameter; userData: LONGINT); }
	IPMNoteUPP = UniversalProcPtr;

CONST
	uppIPMNoteProcInfo = $000037C0; { PROCEDURE (4 byte param, 4 byte param, 1 byte param, 4 byte param); }

FUNCTION NewIPMNoteProc(userRoutine: IPMNoteProcPtr): IPMNoteUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallIPMNoteProc(queue: IPMQueueRef; seqNum: IPMSeqNum; notificationType: ByteParameter; userData: LONGINT; userRoutine: IPMNoteUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	IPMFixedHdrInfo = RECORD
		version:				INTEGER;
		authenticated:			BOOLEAN;
		signatureEnclosed:		BOOLEAN;								{  digital signature enclosed }
		msgSize:				LONGINT;
		notification:			IPMNotificationType;
		priority:				IPMPriority;
		blockCount:				INTEGER;
		originalRcptCount:		INTEGER;								{		original number of recipients }
		refCon:					LONGINT;								{		Client defined data }
		reserved:				INTEGER;
		creationTime:			UTCTime;								{		Time when it was created }
		msgID:					IPMMsgID;
		family:					OSType;									{ family this msg belongs (e.g. mail) }
	END;


CONST
	kIPMDeliveryNotificationBit	= 0;
	kIPMNonDeliveryNotificationBit = 1;
	kIPMEncloseOriginalBit		= 2;
	kIPMSummaryReportBit		= 3;
{ modify enclose original to only on error }
	kIPMOriginalOnlyOnErrorBit	= 4;

	kIPMNoNotificationMask		= $00;
	kIPMDeliveryNotificationMask = 1 * (2**(kIPMDeliveryNotificationBit));
	kIPMNonDeliveryNotificationMask = 1 * (2**(kIPMNonDeliveryNotificationBit));
	kIPMDontEncloseOriginalMask	= $00;
	kIPMEncloseOriginalMask		= 1 * (2**(kIPMEncloseOriginalBit));
	kIPMImmediateReportMask		= $00;
	kIPMSummaryReportMask		= 1 * (2**(kIPMSummaryReportBit));
	kIPMOriginalOnlyOnErrorMask	= 1 * (2**(kIPMOriginalOnlyOnErrorBit));
	kIPMEncloseOriginalOnErrorMask = 0+(kIPMOriginalOnlyOnErrorMask + kIPMEncloseOriginalMask);

{ standard Non delivery codes }
	kIPMNoSuchRecipient			= $0001;
	kIPMRecipientMalformed		= $0002;
	kIPMRecipientAmbiguous		= $0003;
	kIPMRecipientAccessDenied	= $0004;
	kIPMGroupExpansionProblem	= $0005;
	kIPMMsgUnreadable			= $0006;
	kIPMMsgExpired				= $0007;
	kIPMMsgNoTranslatableContent = $0008;
	kIPMRecipientReqStdCont		= $0009;
	kIPMRecipientReqSnapShot	= $000A;
	kIPMNoTransferDiskFull		= $000B;
	kIPMNoTransferMsgRejectedbyDest = $000C;
	kIPMNoTransferMsgTooLarge	= $000D;

{***********************************************************************}
{
This is the structure that will be returned by enumerate and getmsginfo
This definition is just to give you a template, the position of msgType
is variable since this is a packed structure.  procHint and msgType are
packed and even length padded.

* master message info }

TYPE
	IPMMsgInfo = RECORD
		sequenceNum:			IPMSeqNum;
		userData:				LONGINT;
		respIndex:				INTEGER;
		padByte:				SInt8;
		priority:				IPMPriority;
		msgSize:				LONGINT;
		originalRcptCount:		INTEGER;
		reserved:				INTEGER;
		creationTime:			UTCTime;
		msgID:					IPMMsgID;
		family:					OSType;									{ family this msg belongs (e.g. mail) }
		procHint:				IPMProcHint;
		filler2:				SInt8;
		msgType:				IPMMsgType;
	END;

	IPMBlockType = OCECreatorType;

	IPMTOC = RECORD
		blockType:				IPMBlockType;
		blockOffset:			LONGINT;
		blockSize:				LONGINT;
		blockRefCon:			LONGINT;
	END;

{
The following structure is just to describe the layout of the SingleFilter.
Each field should be packed and word aligned when passed to the IPM ToolBox.
}
	IPMSingleFilter = RECORD
		priority:				IPMPriority;
		padByte:				SInt8;
		family:					OSType;									{ family this msg belongs (e.g. mail), '??^ for all }
		script:					ScriptCode;								{ Language Identifier }
		hint:					IPMProcHint;
		filler2:				SInt8;
		msgType:				IPMMsgType;
	END;

	IPMFilter = RECORD
		count:					INTEGER;
		sFilters:				ARRAY [0..0] OF IPMSingleFilter;
	END;

{************************************************************************
Following structures define the “start” of a recipient report block and the
elements of the array respectively.
}
	IPMReportBlockHeader = RECORD
		msgID:					IPMMsgID;								{ message id of the original }
		creationTime:			UTCTime;								{ creation time of the report }
	END;

	OCERecipientReport = RECORD
		rcptIndex:				INTEGER;								{ index of recipient in original message }
		result:					OSErr;									{ result of sending letter to this recipient}
	END;

{***********************************************************************}
	IPMParamBlockPtr = ^IPMParamBlock;

	IPMIOCompletionProcPtr = ProcPtr;  { PROCEDURE IPMIOCompletion(paramBlock: IPMParamBlockPtr); }
	IPMIOCompletionUPP = UniversalProcPtr;

	IPMOpenContextPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		contextRef:				IPMContextRef;							{ <--  Context reference to be used in further calls}
	END;

	IPMCloseContextPB = IPMOpenContextPB;

	IPMCreateQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		filler1:				LONGINT;
		queue:					^OCERecipient;
		identity:				AuthIdentity;							{ used only if queue is remote }
		owner:					^PackedRecordID;						{ used only if queue is remote }
	END;

{ For createqueue and deletequeue only queue and identity are used }
	IPMDeleteQueuePB = IPMCreateQueuePB;

	IPMOpenQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		contextRef:				IPMContextRef;
		queue:					^OCERecipient;
		identity:				AuthIdentity;
		filter:					^IPMFilter;
		newQueueRef:			IPMQueueRef;
		notificationProc:		IPMNoteUPP;
		userData:				LONGINT;
		noteType:				IPMNotificationType;
		padByte:				SInt8; (* Byte *)
		reserved:				LONGINT;
		reserved2:				LONGINT;
	END;

	IPMCloseQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
	END;

	IPMEnumerateQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		startSeqNum:			IPMSeqNum;
		getProcHint:			BOOLEAN;
		getMsgType:				BOOLEAN;
		filler:					INTEGER;
		filter:					^IPMFilter;
		numToGet:				INTEGER;
		numGotten:				INTEGER;
		enumCount:				LONGINT;
		enumBuffer:				Ptr;									{ will be packed array of IPMMsgInfo }
		actEnumCount:			LONGINT;
	END;

	IPMChangeQueueFilterPB = IPMEnumerateQueuePB;

	IPMDeleteMsgRangePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		startSeqNum:			IPMSeqNum;
		endSeqNum:				IPMSeqNum;
		lastSeqNum:				IPMSeqNum;
	END;

	IPMOpenMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				IPMQueueRef;
		sequenceNum:			IPMSeqNum;
		newMsgRef:				IPMMsgRef;
		actualSeqNum:			IPMSeqNum;
		exactMatch:				BOOLEAN;
		padByte:				SInt8; (* Byte *)
		reserved:				LONGINT;
	END;

	IPMOpenHFSMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		hfsPath:				^FSSpec;
		filler:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler2:				LONGINT;
		filler3:				SInt8; (* Byte *)
		filler4:				BOOLEAN;
		reserved:				LONGINT;
	END;

	IPMOpenBlockAsMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler2:				ARRAY [0..6] OF INTEGER;
		blockIndex:				INTEGER;
	END;

	IPMCloseMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		deleteMsg:				BOOLEAN;
		filler1:				BOOLEAN;
	END;

	IPMGetMsgInfoPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		info:					^IPMMsgInfo;
	END;

	IPMReadHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		fieldSelector:			INTEGER;
		offset:					LONGINT;
		count:					LONGINT;
		buffer:					Ptr;
		actualCount:			LONGINT;
		filler:					INTEGER;
		remaining:				LONGINT;
	END;

	IPMReadRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		rcptIndex:				INTEGER;
		offset:					LONGINT;
		count:					LONGINT;
		buffer:					Ptr;
		actualCount:			LONGINT;
		reserved:				INTEGER;								{ must be zero }
		remaining:				LONGINT;
		originalIndex:			INTEGER;
		recipientOffsetFlags:	OCERecipientOffsetFlags;
		filler1:				BOOLEAN;
	END;

{
replyQueue works like recipient. [can no longer read it via ReadHeader]
OriginalIndex is meaningless, rcptFlags are used seperately and there are
currently none defined.
}
	IPMReadReplyQueuePB = IPMReadRecipientPB;

	IPMGetBlkIndexPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		blockType:				IPMBlockType;
		index:					INTEGER;
		startingFrom:			INTEGER;
		actualBlockType:		IPMBlockType;
		actualBlockIndex:		INTEGER;
	END;

	IPMReadMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		mode:					IPMAccessMode;
		offset:					LONGINT;
		count:					LONGINT;
		buffer:					Ptr;
		actualCount:			LONGINT;
		blockIndex:				INTEGER;
		remaining:				LONGINT;
	END;

	IPMVerifySignaturePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		signatureContext:		SIGContextPtr;
	END;

	IPMNewMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		filler:					LONGINT;
		recipient:				^OCERecipient;
		replyQueue:				^OCERecipient;
		procHint:				StringPtr;
		filler2:				INTEGER;
		msgType:				^IPMMsgType;
		refCon:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler3:				INTEGER;
		filler4:				LONGINT;
		identity:				AuthIdentity;
		sender:					^IPMSender;
		internalUse:			LONGINT;
		internalUse2:			LONGINT;
	END;

	IPMNewHFSMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		hfsPath:				^FSSpec;
		recipient:				^OCERecipient;
		replyQueue:				^OCERecipient;
		procHint:				StringPtr;
		filler2:				INTEGER;
		msgType:				^IPMMsgType;
		refCon:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler3:				INTEGER;
		filler4:				LONGINT;
		identity:				AuthIdentity;
		sender:					^IPMSender;
		internalUse:			LONGINT;
		internalUse2:			LONGINT;
	END;

	IPMNestMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					ARRAY [0..8] OF INTEGER;
		refCon:					LONGINT;
		msgToNest:				IPMMsgRef;
		filler2:				INTEGER;
		startingOffset:			LONGINT;
	END;

	IPMNewNestedMsgBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		recipient:				^OCERecipient;
		replyQueue:				^OCERecipient;
		procHint:				StringPtr;
		filler1:				INTEGER;
		msgType:				^IPMMsgType;
		refCon:					LONGINT;
		newMsgRef:				IPMMsgRef;
		filler2:				INTEGER;
		startingOffset:			LONGINT;
		identity:				AuthIdentity;
		sender:					^IPMSender;
		internalUse:			LONGINT;
		internalUse2:			LONGINT;
	END;

	IPMEndMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		msgID:					IPMMsgID;
		msgTitle:				^RString;
		deliveryNotification:	IPMNotificationType;
		priority:				IPMPriority;
		cancel:					BOOLEAN;
		padByte:				SInt8; (* Byte *)
		reserved:				LONGINT;
		signature:				SIGSignaturePtr;
		signatureSize:			Size;
		signatureContext:		SIGContextPtr;
		{ family this msg belongs (e.g. mail) use kIPMFamilyUnspecified by default }
		family:					OSType;
	END;

	IPMAddRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		recipient:				^OCERecipient;
		reserved:				LONGINT;
	END;

	IPMAddReplyQueuePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		filler:					LONGINT;
		replyQueue:				^OCERecipient;
	END;

	IPMNewBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		blockType:				IPMBlockType;
		filler:					ARRAY [0..4] OF INTEGER;
		refCon:					LONGINT;
		filler2:				ARRAY [0..2] OF INTEGER;
		startingOffset:			LONGINT;
	END;

	IPMWriteMsgPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			IPMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msgRef:					IPMMsgRef;
		mode:					IPMAccessMode;
		offset:					LONGINT;
		count:					LONGINT;
		buffer:					Ptr;
		actualCount:			LONGINT;
		currentBlock:			BOOLEAN;
		filler1:				BOOLEAN;
	END;

	IPMParamBlock = RECORD
		CASE INTEGER OF
		0: (
			qLink:						Ptr;
			reservedH1:					LONGINT;
			reservedH2:					LONGINT;
			ioCompletion:				IPMIOCompletionUPP;
			ioResult:					OSErr;
			saveA5:						LONGINT;
			reqCode:					INTEGER;
		   );
		1: (
			openContextPB:				IPMOpenContextPB;
		   );
		2: (
			closeContextPB:				IPMCloseContextPB;
		   );
		3: (
			createQueuePB:				IPMCreateQueuePB;
		   );
		4: (
			deleteQueuePB:				IPMDeleteQueuePB;
		   );
		5: (
			openQueuePB:				IPMOpenQueuePB;
		   );
		6: (
			closeQueuePB:				IPMCloseQueuePB;
		   );
		7: (
			enumerateQueuePB:			IPMEnumerateQueuePB;
		   );
		8: (
			changeQueueFilterPB:		IPMChangeQueueFilterPB;
		   );
		9: (
			deleteMsgRangePB:			IPMDeleteMsgRangePB;
		   );
		10: (
			openMsgPB:					IPMOpenMsgPB;
		   );
		11: (
			openHFSMsgPB:				IPMOpenHFSMsgPB;
		   );
		12: (
			openBlockAsMsgPB:			IPMOpenBlockAsMsgPB;
		   );
		13: (
			closeMsgPB:					IPMCloseMsgPB;
		   );
		14: (
			getMsgInfoPB:				IPMGetMsgInfoPB;
		   );
		15: (
			readHeaderPB:				IPMReadHeaderPB;
		   );
		16: (
			readRecipientPB:			IPMReadRecipientPB;
		   );
		17: (
			readReplyQueuePB:			IPMReadReplyQueuePB;
		   );
		18: (
			getBlkIndexPB:				IPMGetBlkIndexPB;
		   );
		19: (
			readMsgPB:					IPMReadMsgPB;
		   );
		20: (
			verifySignaturePB:			IPMVerifySignaturePB;
		   );
		21: (
			newMsgPB:					IPMNewMsgPB;
		   );
		22: (
			newHFSMsgPB:				IPMNewHFSMsgPB;
		   );
		23: (
			nestMsgPB:					IPMNestMsgPB;
		   );
		24: (
			newNestedMsgBlockPB:		IPMNewNestedMsgBlockPB;
		   );
		25: (
			endMsgPB:					IPMEndMsgPB;
		   );
		26: (
			addRecipientPB:				IPMAddRecipientPB;
		   );
		27: (
			addReplyQueuePB:			IPMAddReplyQueuePB;
		   );
		28: (
			newBlockPB:					IPMNewBlockPB;
		   );
		29: (
			writeMsgPB:					IPMWriteMsgPB;
		   );
	END;

CONST
	uppIPMIOCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }

PROCEDURE CallIPMIOCompletionProc(paramBlock: IPMParamBlockPtr; userRoutine: IPMIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewIPMIOCompletionProc(userRoutine: IPMIOCompletionProcPtr): IPMIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION IPMOpenContext(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $400, $AA5E;
	{$ENDC}
FUNCTION IPMCloseContext(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $401, $AA5E;
	{$ENDC}
FUNCTION IPMNewMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $402, $AA5E;
	{$ENDC}
FUNCTION IPMNewBlock(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $404, $AA5E;
	{$ENDC}
FUNCTION IPMNewNestedMsgBlock(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $405, $AA5E;
	{$ENDC}
FUNCTION IPMNestMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $406, $AA5E;
	{$ENDC}
FUNCTION IPMWriteMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $407, $AA5E;
	{$ENDC}
FUNCTION IPMEndMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $408, $AA5E;
	{$ENDC}
FUNCTION IPMOpenQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $409, $AA5E;
	{$ENDC}
FUNCTION IPMCloseQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40A, $AA5E;
	{$ENDC}
{ Always synchronous }
FUNCTION IPMVerifySignature(paramBlock: IPMParamBlockPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3F3C, $422, $AA5E;
	{$ENDC}
FUNCTION IPMOpenMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40B, $AA5E;
	{$ENDC}
FUNCTION IPMCloseMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40C, $AA5E;
	{$ENDC}
FUNCTION IPMReadMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40D, $AA5E;
	{$ENDC}
FUNCTION IPMReadHeader(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40E, $AA5E;
	{$ENDC}
FUNCTION IPMOpenBlockAsMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $40F, $AA5E;
	{$ENDC}
FUNCTION IPMNewHFSMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $41E, $AA5E;
	{$ENDC}
FUNCTION IPMReadRecipient(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $410, $AA5E;
	{$ENDC}
FUNCTION IPMReadReplyQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $421, $AA5E;
	{$ENDC}
FUNCTION IPMCreateQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $411, $AA5E;
	{$ENDC}
FUNCTION IPMDeleteQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $412, $AA5E;
	{$ENDC}
FUNCTION IPMEnumerateQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $413, $AA5E;
	{$ENDC}
FUNCTION IPMChangeQueueFilter(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $414, $AA5E;
	{$ENDC}
FUNCTION IPMDeleteMsgRange(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $415, $AA5E;
	{$ENDC}
FUNCTION IPMAddRecipient(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $403, $AA5E;
	{$ENDC}
FUNCTION IPMAddReplyQueue(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $41D, $AA5E;
	{$ENDC}
FUNCTION IPMOpenHFSMsg(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $417, $AA5E;
	{$ENDC}
FUNCTION IPMGetBlkIndex(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $418, $AA5E;
	{$ENDC}
FUNCTION IPMGetMsgInfo(paramBlock: IPMParamBlockPtr; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $419, $AA5E;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEMessagingIncludes}

{$ENDC} {__OCEMESSAGING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

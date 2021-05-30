{
 	File:		OCEMail.p
 
 	Contains:	Apple Open Collaboration Environment OCEMail Interfaces.
 
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
 UNIT OCEMail;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCEMAIL__}
{$SETC __OCEMAIL__ := 1}

{$I+}
{$SETC OCEMailIncludes := UsingIncludes}
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

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
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

{$IFC UNDEFINED __OCEMESSAGING__}
{$I OCEMessaging.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
TYPE
	MSAMIOCompletionProcPtr = ProcPtr;  { PROCEDURE MSAMIOCompletion(VAR paramBlock: MSAMParam); }
	MSAMIOCompletionUPP = UniversalProcPtr;

	MailMsgRef = LONGINT;

{ reference to an open msam queue }
	MSAMQueueRef = LONGINT;

{ identifies slots managed by a PMSAM }
	MSAMSlotID = INTEGER;

{ reference to an active mailbox }
	MailboxRef = LONGINT;

{ identifies slots within a mailbox }
	MailSlotID = INTEGER;

{ identifies a letter in a mailbox }
	MailSeqNum = RECORD
		slotID:					MailSlotID;
		seqNum:					LONGINT;
	END;

{ A MailBuffer is used to describe a buffer used for an IO operation.
The location of the buffer is pointed to by 'buffer'. 
When reading, the size of the buffer is 'bufferSize' 
and the size of data actually read is 'dataSize'.
When writing, the size of data to be written is 'bufferSize' 
and the size of data actually written is 'dataSize'.
}
	MailBuffer = RECORD
		bufferSize:				LONGINT;
		buffer:					Ptr;
		dataSize:				LONGINT;
	END;

{ A MailReply is used to describe a commonly used reply buffer format.
It contains a count of tuples followed by an array of tuples.
The format of the tuple itself depends on each particular call.
}
	MailReply = RECORD
		tupleCount:				INTEGER;
		{ tuple[tupleCount] }
	END;

{ Shared Memory Communication Area used when Mail Manager sends 
High Level Events to a PMSAM. 
}
	SMCA = RECORD
		smcaLength:				INTEGER;								{ includes size of smcaLength field }
		result:					OSErr;
		userBytes:				LONGINT;
		CASE INTEGER OF
		0: (
			slotCID:					CreationID;							{ for create/modify/delete slot calls }
		   );
		1: (
			msgHint:					LONGINT;							{ for kMailEPPCMsgOpened }
		   );
	END;

{************************************************************************************}
{ Value of creator and types fields for messages and blocks defined by MailManager }

CONST
	kMailAppleMailCreator		= 'apml';						{ message and letter block creator }
	kMailLtrMsgType				= 'lttr';						{ message type of letters, reports }
	kMailLtrHdrType				= 'lthd';						{ contains letter header }
	kMailContentType			= 'body';						{ contains content of letter }
	kMailEnclosureListType		= 'elst';						{ contains list of enclosures }
	kMailEnclosureDesktopType	= 'edsk';						{ contains desktop mgr info for enclosures }
	kMailEnclosureFileType		= 'asgl';						{ contains a file enclosure }
{ format is defined by AppleSingle }
	kMailImageBodyType			= 'imag';						{ contains image of letter }
{		format is struct TPfPgDir - in Printing.h
	*	struct TPfPgDir (
	*		short	pageCount;		- number of pages in the image.
	*		long	iPgPos[129];	- iPgPos[n] is the offset from the start of the block
	*								- to image of page n.
	*								- iPgPos[n+1] - iPgPos[n] is the length of page n.
}
	kMailMSAMType				= 'gwyi';						{ contains msam specific information }
	kMailTunnelLtrType			= 'tunl';						{ used to read a tunnelled message }
	kMailHopInfoType			= 'hopi';						{ used to read hopInfo for a tunnelled message }
	kMailReportType				= 'rpti';						{ contains report info }
{
Reports have the isReport bit set in MailIndications and contain a block of type kMailReport.
This block has a header, IPMReportBlockHeader,
followed by an array of elements, each of type IPMRecipientReport

Various families used by mail or related msgs
}
	kMailFamily					= 'mail';						{ Defines family of "mail" msgs: content, header, etc }
	kMailFamilyFile				= 'file';

{************************************************************************************}
	
TYPE
	MailAttributeID = INTEGER;

{ Values of MailAttributeID }
{ Message store attributes - stored in the catalog }
{ Will always be present in a letter and have fixed sizes }

CONST
	kMailLetterFlagsBit			= 1;							{ MailLetterFlags }
{ Letter attributes - stored in the letter 
   Will always be present in a letter and have fixed sizes }
	kMailIndicationsBit			= 3;							{ MailIndications }
	kMailMsgTypeBit				= 4;							{ OCECreatorType }
	kMailLetterIDBit			= 5;							{ MailLetterID }
	kMailSendTimeStampBit		= 6;							{ MailTime }
	kMailNestingLevelBit		= 7;							{ MailNestingLevel }
	kMailMsgFamilyBit			= 8;							{ OSType }
{ Letter attributes - stored in the letter
   May be present in a letter and have fixed sizes }
	kMailReplyIDBit				= 9;							{ MailLetterID }
	kMailConversationIDBit		= 10;							{ MailLetterID }
{ Letter attributes - stored in the letter
   May be present in a letter and have variable length sizes }
	kMailSubjectBit				= 11;							{ RString }
	kMailFromBit				= 12;							{ MailRecipient }
	kMailToBit					= 13;							{ MailRecipient }
	kMailCcBit					= 14;							{ MailRecipient }
	kMailBccBit					= 15;							{ MailRecipient }

	
TYPE
	MailAttributeMask = LONGINT;

{ Values of MailAttributeMask }

CONST
	kMailLetterFlagsMask		= 1 * (2**((kMailLetterFlagsBit - 1)));
	kMailIndicationsMask		= 1 * (2**((kMailIndicationsBit - 1)));
	kMailMsgTypeMask			= 1 * (2**((kMailMsgTypeBit - 1)));
	kMailLetterIDMask			= 1 * (2**((kMailLetterIDBit - 1)));
	kMailSendTimeStampMask		= 1 * (2**((kMailSendTimeStampBit - 1)));
	kMailNestingLevelMask		= 1 * (2**((kMailNestingLevelBit - 1)));
	kMailMsgFamilyMask			= 1 * (2**((kMailMsgFamilyBit - 1)));
	kMailReplyIDMask			= 1 * (2**((kMailReplyIDBit - 1)));
	kMailConversationIDMask		= 1 * (2**((kMailConversationIDBit - 1)));
	kMailSubjectMask			= 1 * (2**((kMailSubjectBit - 1)));
	kMailFromMask				= 1 * (2**((kMailFromBit - 1)));
	kMailToMask					= 1 * (2**((kMailToBit - 1)));
	kMailCcMask					= 1 * (2**((kMailCcBit - 1)));
	kMailBccMask				= 1 * (2**((kMailBccBit - 1)));

	
TYPE
	MailAttributeBitmap = LONGINT;

{************************************************************************************}
	MailLetterSystemFlags = INTEGER;

{ Values of MailLetterSystemFlags }
{ letter is available locally (either by nature or via cache) }

CONST
	kMailIsLocalBit				= 2;

	kMailIsLocalMask			= 1 * (2**(kMailIsLocalBit));

	
TYPE
	MailLetterUserFlags = INTEGER;


CONST
	kMailReadBit				= 0;							{ this letter has been opened }
	kMailDontArchiveBit			= 1;							{ this letter is not }
{ to be archived either because 
										   it has already been archived or 
										   it should not be archived. }
	kMailInTrashBit				= 2;							{ this letter is in trash }

{ Values of MailLetterUserFlags }
	kMailReadMask				= 1 * (2**(kMailReadBit));
	kMailDontArchiveMask		= 1 * (2**(kMailDontArchiveBit));
	kMailInTrashMask			= 1 * (2**(kMailInTrashBit));


TYPE
	MailLetterFlags = RECORD
		sysFlags:				MailLetterSystemFlags;
		userFlags:				MailLetterUserFlags;
	END;

	MailMaskedLetterFlags = RECORD
		flagMask:				MailLetterFlags;						{ flags that are to be set }
		flagValues:				MailLetterFlags;						{ and their values }
	END;


CONST
	kMailOriginalInReportBit	= 1;
	kMailNonReceiptReportsBit	= 3;
	kMailReceiptReportsBit		= 4;
	kMailForwardedBit			= 5;
	kMailPriorityBit			= 6;
	kMailIsReportWithOriginalBit = 8;
	kMailIsReportBit			= 9;
	kMailHasContentBit			= 10;
	kMailHasSignatureBit		= 11;
	kMailAuthenticatedBit		= 12;
	kMailSentBit				= 13;
	kMailNativeContentBit		= 14;
	kMailImageContentBit		= 15;
	kMailStandardContentBit		= 16;

{ Values of MailIndications }
	kMailStandardContentMask	= 1 * (2**((kMailStandardContentBit - 1)));
	kMailImageContentMask		= 1 * (2**((kMailImageContentBit - 1)));
	kMailNativeContentMask		= 1 * (2**((kMailNativeContentBit - 1)));
	kMailSentMask				= 1 * (2**((kMailSentBit - 1)));
	kMailAuthenticatedMask		= 1 * (2**((kMailAuthenticatedBit - 1)));
	kMailHasSignatureMask		= 1 * (2**((kMailHasSignatureBit - 1)));
	kMailHasContentMask			= 1 * (2**((kMailHasContentBit - 1)));
	kMailIsReportMask			= 1 * (2**((kMailIsReportBit - 1)));
	kMailIsReportWithOriginalMask = 1 * (2**((kMailIsReportWithOriginalBit - 1)));
	kMailPriorityMask			= 3 * (2**((kMailPriorityBit - 1)));
	kMailForwardedMask			= 1 * (2**((kMailForwardedBit - 1)));
	kMailReceiptReportsMask		= 1 * (2**((kMailReceiptReportsBit - 1)));
	kMailNonReceiptReportsMask	= 1 * (2**((kMailNonReceiptReportsBit - 1)));
	kMailOriginalInReportMask	= 3 * (2**((kMailOriginalInReportBit - 1)));

	
TYPE
	MailIndications = LONGINT;

{ values of the field originalInReport in MailIndications }

CONST
	kMailNoOriginal				= 0;							{ do not enclose original in reports }
	kMailEncloseOnNonReceipt	= 3;							{ enclose original in non-delivery reports }

	
TYPE
	MailLetterID = IPMMsgID;

	MailTime = RECORD
		time:					UTCTime;								{ current UTC(GMT) time }
		offset:					UTCOffset;								{ offset from GMT }
	END;

{ innermost letter has nestingLevel 0 }
	MailNestingLevel = INTEGER;

	MailRecipient = OCERecipient;

{************************************************************************************}

CONST
	kMailTextSegmentBit			= 0;
	kMailPictSegmentBit			= 1;
	kMailSoundSegmentBit		= 2;
	kMailStyledTextSegmentBit	= 3;
	kMailMovieSegmentBit		= 4;

	
TYPE
	MailSegmentMask = INTEGER;

{ Values of MailSegmentMask }

CONST
	kMailTextSegmentMask		= 1 * (2**(kMailTextSegmentBit));
	kMailPictSegmentMask		= 1 * (2**(kMailPictSegmentBit));
	kMailSoundSegmentMask		= 1 * (2**(kMailSoundSegmentBit));
	kMailStyledTextSegmentMask	= 1 * (2**(kMailStyledTextSegmentBit));
	kMailMovieSegmentMask		= 1 * (2**(kMailMovieSegmentBit));

	
TYPE
	MailSegmentType = INTEGER;

{ Values of MailSegmentType }

CONST
	kMailInvalidSegmentType		= 0;
	kMailTextSegmentType		= 1;
	kMailPictSegmentType		= 2;
	kMailSoundSegmentType		= 3;
	kMailStyledTextSegmentType	= 4;
	kMailMovieSegmentType		= 5;

{************************************************************************************}
	kMailErrorLogEntryVersion	= $101;
	kMailMSAMErrorStringListID	= 128;							{ These 'STR#' resources should be }
	kMailMSAMActionStringListID	= 129;							{ in the PMSAM resource fork }

	
TYPE
	MailLogErrorType = INTEGER;

{ Values of MailLogErrorType }

CONST
	kMailELECorrectable			= 0;
	kMailELEError				= 1;
	kMailELEWarning				= 2;
	kMailELEInformational		= 3;

	
TYPE
	MailLogErrorCode = INTEGER;

{ Values of MailLogErrorCode }

CONST
	kMailMSAMErrorCode			= 0;							{ positive codes are indices into
												   PMSAM defined strings }
	kMailMiscError				= -1;							{ negative codes are OCE defined }
	kMailNoModem				= -2;							{ modem required, but missing }


TYPE
	MailErrorLogEntryInfo = RECORD
		version:				INTEGER;
		timeOccurred:			UTCTime;								{ do not fill in }
		reportingPMSAM:			Str31;									{ do not fill in }
		reportingMSAMSlot:		Str31;									{ do not fill in }
		errorType:				MailLogErrorType;
		errorCode:				MailLogErrorCode;
		errorResource:			INTEGER;								{ resources are valid if }
		actionResource:			INTEGER;								{ errorCode = kMailMSAMErrorCode
												   index starts from 1 }
		filler:					LONGINT;
		filler2:				INTEGER;
	END;

{************************************************************************************}
	MailBlockMode = INTEGER;

{ Values of MailBlockMode }

CONST
	kMailFromStart				= 1;							{ write data from offset calculated from }
	kMailFromLEOB				= 2;							{ start of block, end of block, }
	kMailFromMark				= 3;							{ or from the current mark }


TYPE
	MailEnclosureInfo = RECORD
		enclosureName:			StringPtr;
		catInfo:				CInfoPBPtr;
		comment:				StringPtr;
		icon:					Ptr;
	END;

{************************************************************************************}

CONST
	kOCESetupLocationNone		= 0;							{ disconnect state }
	kOCESetupLocationMax		= 8;							{ maximum location value }

	
TYPE
	OCESetupLocation = CHAR;

{ location state is a bitmask, 0x1=>1st location active, 
 * 0x2 => 2nd, 0x4 => 3rd, etc.
 }
	MailLocationFlags = SInt8;

	MailLocationInfo = RECORD
		location:				OCESetupLocation;
		active:					MailLocationFlags;
	END;

{************************************************************************************}
{ Definitions for Personal MSAMs }
{************************************************************************************}

CONST
	kMailEPPCMsgVersion			= 3;


TYPE
	MailEPPCMsg = RECORD
		version:				INTEGER;
		CASE INTEGER OF
		0: (
			theSMCA:					^SMCA;								{ for 'crsl', 'mdsl', 'dlsl', 'sndi', 'msgo', 'admn' }
		   );
		1: (
			sequenceNumber:				LONGINT;							{ for 'inqu', 'dlom' }
		   );
		2: (
			locationInfo:				MailLocationInfo;					{ for 'locc' }
		   );
	END;

{ Values of OCE defined High Level Event message classes }

CONST
	kMailEPPCCreateSlot			= 'crsl';
	kMailEPPCModifySlot			= 'mdsl';
	kMailEPPCDeleteSlot			= 'dlsl';
	kMailEPPCShutDown			= 'quit';
	kMailEPPCMailboxOpened		= 'mbop';
	kMailEPPCMailboxClosed		= 'mbcl';
	kMailEPPCMsgPending			= 'msgp';
	kMailEPPCSendImmediate		= 'sndi';
	kMailEPPCContinue			= 'cont';
	kMailEPPCSchedule			= 'sked';
	kMailEPPCAdmin				= 'admn';
	kMailEPPCInQUpdate			= 'inqu';
	kMailEPPCMsgOpened			= 'msgo';
	kMailEPPCDeleteOutQMsg		= 'dlom';
	kMailEPPCWakeup				= 'wkup';
	kMailEPPCLocationChanged	= 'locc';


TYPE
	MailTimer = RECORD
		CASE INTEGER OF
		0: (
			frequency:					LONGINT;							{ how often to connect }
		   );
		1: (
			connectTime:				LONGINT;							{ time since midnight }
		   );
	END;


CONST
	kMailTimerOff				= 0;							{ control is off }
	kMailTimerTime				= 1;							{ specifies connect time (relative to midnight) }
	kMailTimerFrequency			= 2;							{ specifies connect frequency }

	
TYPE
	MailTimerKind = SInt8;

	MailTimers = RECORD
		sendTimeKind:			MailTimerKind;							{ either kMailTimerTime or kMailTimerFrequency }
		receiveTimeKind:		MailTimerKind;							{ either kMailTimerTime or kMailTimerFrequency }
		send:					MailTimer;
		receive:				MailTimer;
	END;

	MailStandardSlotInfoAttribute = RECORD
		version:				INTEGER;
		active:					MailLocationFlags;						{ active if MailLocationMask(i) is set }
		padByte:				SInt8; (* Byte *)
		sendReceiveTimer:		MailTimers;
	END;

	PMSAMGetMSAMRecordPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamCID:				CreationID;
	END;

	PMSAMOpenQueuesPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		outQueueRef:			MSAMQueueRef;
		msamSlotID:				MSAMSlotID;
		filler:					ARRAY [0..1] OF LONGINT;
	END;

	PMSAMStatus = INTEGER;

{ Values of PMSAMStatus }

CONST
	kPMSAMStatusPending			= 1;							{ for inQueue and outQueue }
	kPMSAMStatusError			= 2;							{ for inQueue and outQueue }
	kPMSAMStatusSending			= 3;							{ for outQueue only }
	kPMSAMStatusCaching			= 4;							{ for inQueue only }
	kPMSAMStatusSent			= 5;							{ for outQueue only }


TYPE
	PMSAMSetStatusPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgHint:				LONGINT;								{ for posting cache error,set this to 0 when report outq status }
		status:					PMSAMStatus;
	END;

	PMSAMLogErrorPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamSlotID:				MSAMSlotID;								{ 0 for PMSAM errors }
		logEntry:				^MailErrorLogEntryInfo;
		filler:					ARRAY [0..1] OF LONGINT;
	END;

{**************************************************************************************}

CONST
	kMailMsgSummaryVersion		= 1;


TYPE
	MailMasterData = RECORD
		attrMask:				MailAttributeBitmap;					{ indicates attributes present in MsgSummary }
		messageID:				MailLetterID;
		replyID:				MailLetterID;
		conversationID:			MailLetterID;
	END;

{ Values for addressedToMe in struct MailCoreData }

CONST
	kAddressedAs_TO				= $1;
	kAddressedAs_CC				= $2;
	kAddressedAs_BCC			= $4;


TYPE
	MailCoreData = RECORD
		letterFlags:			MailLetterFlags;
		messageSize:			LONGINT;
		letterIndications:		MailIndications;
		messageType:			OCECreatorType;
		sendTime:				MailTime;
		messageFamily:			OSType;
		reserved:				SInt8; (* unsigned char *)
		addressedToMe:			SInt8; (* unsigned char *)
		agentInfo:				ARRAY [0..5] OF CHAR;					{ 6 bytes of special info [set to zero]
	* these are variable length and even padded }
		sender:					RString32;								{ recipient's entityName (trunc)}
		subject:				RString32;								{ subject maybe truncated }
	END;

	MSAMMsgSummary = RECORD
		version:				INTEGER;								{ following flags are defaulted by Toolbox }
		msgDeleted:				BOOLEAN;								{ true if msg is to be deleted by PMSAM }
		msgUpdated:				BOOLEAN;								{ true if msgSummary was updated by MailManager }
		msgCached:				BOOLEAN;								{ true if msg is in the slot's InQueue }
		padByte:				SInt8; (* Byte *)
		masterData:				MailMasterData;
		coreData:				MailCoreData;
	END;

{ PMSAM can put up to 128 bytes of private msg summary data }

CONST
	kMailMaxPMSAMMsgSummaryData	= 128;


TYPE
	PMSAMCreateMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;								{ <- seq of the new message }
		msgSummary:				^MSAMMsgSummary;						{ attributes and mask filled in }
		buffer:					^MailBuffer;							{ PMSAM specific data to be appended }
	END;

	PMSAMPutMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		letterFlags:			^MailMaskedLetterFlags;					{ if not nil, then set msgStoreFlags }
		buffer:					^MailBuffer;							{ PMSAM specific data to be overwritten }
	END;

	PMSAMGetMsgSummaryPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		inQueueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgSummary:				^MSAMMsgSummary;						{ if not nil, then read in the msgSummary }
		buffer:					^MailBuffer;							{ PMSAM specific data to be read }
		msgSummaryOffset:		INTEGER;								{ offset of PMSAM specific data
											   from start of MsgSummary }
	END;

{**************************************************************************************}
{ Definitions for Server MSAMs }
{************************************************************************************}
	SMSAMAdminCode = INTEGER;

{ Values of SMSAMAdminCode }

CONST
	kSMSAMNotifyFwdrSetupChange	= 1;
	kSMSAMNotifyFwdrNameChange	= 2;
	kSMSAMNotifyFwdrPwdChange	= 3;
	kSMSAMGetDynamicFwdrParams	= 4;

	
TYPE
	SMSAMSlotChanges = LONGINT;


CONST
	kSMSAMFwdrHomeInternetChangedBit = 0;
	kSMSAMFwdrConnectedToChangedBit = 1;
	kSMSAMFwdrForeignRLIsChangedBit = 2;
	kSMSAMFwdrMnMServerChangedBit = 3;

{ Values of SMSAMSlotChanges }
	kSMSAMFwdrEverythingChangedMask = -1;
	kSMSAMFwdrHomeInternetChangedMask = 1 * (2**(kSMSAMFwdrHomeInternetChangedBit));
	kSMSAMFwdrConnectedToChangedMask = 1 * (2**(kSMSAMFwdrConnectedToChangedBit));
	kSMSAMFwdrForeignRLIsChangedMask = 1 * (2**(kSMSAMFwdrForeignRLIsChangedBit));
	kSMSAMFwdrMnMServerChangedMask = 1 * (2**(kSMSAMFwdrMnMServerChangedBit));

{ kSMSAMNotifyFwdrSetupChange }

TYPE
	SMSAMSetupChange = RECORD
		whatChanged:			SMSAMSlotChanges;						{  --> bitmap of what parameters changed }
		serverHint:				AddrBlock;								{  --> try this ADAP server first }
	END;

{ kSMSAMNotifyFwdrNameChange }
	SMSAMNameChange = RECORD
		newName:				RString;								{  --> msams new name }
		serverHint:				AddrBlock;								{  --> try this ADAP server first }
	END;

{ kSMSAMNotifyFwdrPasswordChange }
	SMSAMPasswordChange = RECORD
		newPassword:			RString;								{  --> msams new password }
		serverHint:				AddrBlock;								{  --> try this ADAP server first }
	END;

{ kSMSAMGetDynamicFwdrParams }
	SMSAMDynamicParams = RECORD
		curDiskUsed:			LONGINT;								{ <--  amount of disk space used by msam }
		curMemoryUsed:			LONGINT;								{ <--  amount of memory used by msam }
	END;

	SMSAMAdminEPPCRequest = RECORD
		adminCode:				SMSAMAdminCode;
		CASE INTEGER OF
		0: (
			setupChange:				SMSAMSetupChange;
		   );
		1: (
			nameChange:					SMSAMNameChange;
		   );
		2: (
			passwordChange:				SMSAMPasswordChange;
		   );
		3: (
			dynamicParams:				SMSAMDynamicParams;
		   );
	END;

	SMSAMSetupPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		serverMSAM:				RecordIDPtr;
		password:				RStringPtr;
		gatewayType:			OSType;
		gatewayTypeDescription:	RStringPtr;
		catalogServerHint:		AddrBlock;
	END;

	SMSAMStartupPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		msamIdentity:			AuthIdentity;
		queueRef:				MSAMQueueRef;
	END;

	SMSAMShutdownPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
	END;

{**************************************************************************************}
{ Definitions for reading and writing MSAM Letters }
{**************************************************************************************}
	MSAMEnumeratePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		startSeqNum:			LONGINT;
		nextSeqNum:				LONGINT;
		{ buffer contains a Mail Reply. Each tuple is a 
	MSAMEnumerateInQReply when enumerating the inQueue
	MSAMEnumerateOutQReply when enumerating the outQueue }
		buffer:					MailBuffer;
	END;

	MSAMEnumerateInQReply = RECORD
		seqNum:					LONGINT;
		msgDeleted:				BOOLEAN;								{ true if msg is to be deleted by PMSAM }
		msgUpdated:				BOOLEAN;								{ true if MsgSummary has been updated by TB }
		msgCached:				BOOLEAN;								{ true if msg is in the incoming queue }
		padByte:				SInt8; (* Byte *)
	END;

	MSAMEnumerateOutQReply = RECORD
		seqNum:					LONGINT;
		done:					BOOLEAN;								{ true if all responsible recipients have been processed }
		priority:				IPMPriority;
		msgFamily:				OSType;
		approxSize:				LONGINT;
		tunnelForm:				BOOLEAN;								{ true if this letter has to be tunnelled }
		padByte:				SInt8; (* Byte *)
		nextHop:				NetworkSpec;							{ valid if tunnelForm is true }
		msgType:				OCECreatorType;
	END;

	MSAMDeletePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		msgOnly:				BOOLEAN;								{ only valid for PMSAM & inQueue }
		{ set true to delete message but not msgSummary }
		padByte:				SInt8; (* Byte *)
		{ only valid for SMSAM & tunnelled messages }
		result:					OSErr;
	END;

	MSAMOpenPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMOpenNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		nestedRef:				MailMsgRef;
	END;

	MSAMClosePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMGetMsgHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		selector:				IPMHeaderSelector;
		filler1:				BOOLEAN;
		offset:					LONGINT;
		buffer:					MailBuffer;
		remaining:				LONGINT;
	END;

	MSAMGetAttributesPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		requestMask:			MailAttributeBitmap;					{ kMailIndicationsBit thru kMailSubjectBit }
		buffer:					MailBuffer;
		{	buffer returned will contain the attribute values of 
		the attributes indicated in responseMask, 
		from the attribute indicated by the least significant bit set
		to the attribute indicated by the most significant bit set.
		Note that recipients - from, to, cc, bcc cannot be read using
		this call. Use GetRecipients to read these. }
		responseMask:			MailAttributeBitmap;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

{ attrID value to get resolved recipient list }

CONST
	kMailResolvedList			= 0;


TYPE
	MailOriginalRecipient = RECORD
		index:					INTEGER;
	END;

{ Followed by OCEPackedRecipient }
	MailResolvedRecipient = RECORD
		index:					INTEGER;
		recipientFlags:			INTEGER;
		responsible:			BOOLEAN;
		padByte:				SInt8; (* Byte *)
	END;

{ Followed by OCEPackedRecipient }
	MSAMGetRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{ kMailFromBit thru kMailBccBit }
		startIndex:				INTEGER;								{ starts at 1 }
		buffer:					MailBuffer;
		{ 	buffer contains a Mail Reply. Each tuple is a
		MailOriginalRecipient if getting original recipients 
								ie the attrID is kMail[From, To, Cc, Bcc]Bit
		MailResolvedRecipient if getting resolved reicpients
								ie the attrID is kMailResolvedList
		Both tuples are word alligned.  }
		nextIndex:				INTEGER;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

	MSAMGetContentPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		segmentMask:			MailSegmentMask;
		buffer:					MailBuffer;
		textScrap:				^StScrpRec;
		script:					ScriptCode;
		segmentType:			MailSegmentType;
		endOfScript:			BOOLEAN;
		endOfSegment:			BOOLEAN;
		endOfContent:			BOOLEAN;
		filler1:				BOOLEAN;
		segmentLength:			LONGINT;								{ NEW: <-  valid first call in a segment }
		segmentID:				LONGINT;								{ NEW: <-> identifier for this segment }
	END;

	MSAMGetEnclosurePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		contentEnclosure:		BOOLEAN;
		padByte:				SInt8; (* Byte *)
		buffer:					MailBuffer;
		endOfFile:				BOOLEAN;
		endOfEnclosures:		BOOLEAN;
	END;

	MailBlockInfo = RECORD
		blockType:				OCECreatorType;
		offset:					LONGINT;
		blockLength:			LONGINT;
	END;

	MSAMEnumerateBlocksPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		startIndex:				INTEGER;								{ starts at 1 }
		buffer:					MailBuffer;
		{ 	buffer contains a Mail Reply. Each tuple is a MailBlockInfo }
		nextIndex:				INTEGER;
		more:					BOOLEAN;
		filler1:				BOOLEAN;
	END;

	MSAMGetBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		blockType:				OCECreatorType;
		blockIndex:				INTEGER;
		buffer:					MailBuffer;
		dataOffset:				LONGINT;
		endOfBlock:				BOOLEAN;
		padByte:				SInt8; (* Byte *)
		remaining:				LONGINT;
	END;

{ YOU SHOULD BE USING THE NEW FORM OF MARK RECIPIENTS
 * THIS VERSION IS MUCH SLOWER AND KEPT FOR COMPATIBILITY
 * REASONS.
}
{ not valid for tunnel form letters }
	MSAMMarkRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		seqNum:					LONGINT;
		{ 	buffer contains a Mail Reply. Each tuple is an unsigned short,
		the index of a recipient to be marked. }
		buffer:					MailBuffer;
	END;

{ 
 * same as MSAMMarkRecipients except it takes a mailMsgRef instead of 
 * queueRef, seqNum 
}
{ not valid for tunnel form letters }
	MSAMnMarkRecipientsPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		{ 	buffer contains a Mail Reply. Each tuple is an unsigned short,
		the index of a recipient to be marked. }
		buffer:					MailBuffer;
	END;

{**************************************************************************************}
	MSAMCreatePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;
		asLetter:				BOOLEAN;								{ indicate if we should create as letter or msg }
		filler1:				BOOLEAN;
		msgType:				IPMMsgType;								{ up to application discretion: must be of IPMSenderTag
										   kIPMOSFormatType for asLetter=true }
		refCon:					LONGINT;								{ for messages only }
		seqNum:					LONGINT;								{ set if creating message in the inQueue }
		tunnelForm:				BOOLEAN;								{ if true tunnelForm else newForm }
		bccRecipients:			BOOLEAN;								{ true if creating letter with bcc recipients }
		newRef:					MailMsgRef;
	END;

	MSAMBeginNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		refCon:					LONGINT;								{ for messages only }
		msgType:				IPMMsgType;
	END;

	MSAMEndNestedPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
	END;

	MSAMSubmitPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		submitFlag:				BOOLEAN;
		padByte:				SInt8; (* Byte *)
		msgID:					MailLetterID;
	END;

	MSAMPutMsgHeaderPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		replyQueue:				^OCERecipient;
		sender:					^IPMSender;
		deliveryNotification:	IPMNotificationType;
		priority:				IPMPriority;
	END;

	MSAMPutAttributePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{ kMailIndicationsBit thru kMailSubjectBit }
		buffer:					MailBuffer;
	END;

	MSAMPutRecipientPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		attrID:					MailAttributeID;						{ kMailFromBit thru kMailBccBit }
		recipient:				^MailRecipient;
		responsible:			BOOLEAN;								{ valid for server and message msams only }
		filler1:				BOOLEAN;
	END;

	MSAMPutContentPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		segmentType:			MailSegmentType;
		append:					BOOLEAN;
		padByte:				SInt8; (* Byte *)
		buffer:					MailBuffer;
		textScrap:				^StScrpRec;
		startNewScript:			BOOLEAN;
		filler1:				BOOLEAN;
		script:					ScriptCode;								{ valid only if startNewScript is true }
	END;

	MSAMPutEnclosurePB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		contentEnclosure:		BOOLEAN;
		padByte:				SInt8; (* Byte *)
		hfs:					BOOLEAN;								{ true => in file system, false => in memory }
		append:					BOOLEAN;
		buffer:					MailBuffer;								{ Unused if hfs == true }
		enclosure:				FSSpec;
		addlInfo:				MailEnclosureInfo;
	END;

	MSAMPutBlockPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		refCon:					LONGINT;								{ for messages only }
		blockType:				OCECreatorType;
		append:					BOOLEAN;
		filler1:				BOOLEAN;
		buffer:					MailBuffer;
		mode:					MailBlockMode;							{ if blockType is kMailTunnelLtrType or kMailHopInfoType
									   mode is assumed to be kMailFromMark }
		offset:					LONGINT;
	END;

{**************************************************************************************}
	MSAMCreateReportPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		queueRef:				MSAMQueueRef;							{ to distinguish personal and server MSAMs }
		mailMsgRef:				MailMsgRef;
		msgID:					MailLetterID;							{ kMailLetterIDBit of letter being reported upon }
		sender:					^MailRecipient;							{ sender of the letter you are creating report on }
	END;

	MSAMPutRecipientReportPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailMsgRef:				MailMsgRef;
		recipientIndex:			INTEGER;								{ recipient index in the original letter }
		result:					OSErr;									{ result of sending the recipient }
	END;

{**************************************************************************************}
	MailWakeupPMSAMPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		pmsamCID:				CreationID;
		mailSlotID:				MailSlotID;
	END;

	MailCreateMailSlotPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailboxRef:				MailboxRef;
		timeout:				LONGINT;
		pmsamCID:				CreationID;
		smca:					SMCA;
	END;

	MailModifyMailSlotPB = RECORD
		qLink:					Ptr;
		reservedH1:				LONGINT;
		reservedH2:				LONGINT;
		ioCompletion:			MSAMIOCompletionUPP;
		ioResult:				OSErr;
		saveA5:					LONGINT;
		reqCode:				INTEGER;
		mailboxRef:				MailboxRef;
		timeout:				LONGINT;
		pmsamCID:				CreationID;
		smca:					SMCA;
	END;

{**************************************************************************************}
	MSAMParam = RECORD
		CASE INTEGER OF
		0: (
			qLink:						Ptr;
			reservedH1:					LONGINT;
			reservedH2:					LONGINT;
			ioCompletion:				MSAMIOCompletionUPP;
			ioResult:					OSErr;
			saveA5:						LONGINT;
			reqCode:					INTEGER;
		   );
		1: (
			pmsamGetMSAMRecord:			PMSAMGetMSAMRecordPB;
		   );
		2: (
			pmsamOpenQueues:			PMSAMOpenQueuesPB;
		   );
		3: (
			pmsamSetStatus:				PMSAMSetStatusPB;
		   );
		4: (
			pmsamLogError:				PMSAMLogErrorPB;
		   );
		5: (
			smsamSetup:					SMSAMSetupPB;
		   );
		6: (
			smsamStartup:				SMSAMStartupPB;
		   );
		7: (
			smsamShutdown:				SMSAMShutdownPB;
		   );
		8: (
			msamEnumerate:				MSAMEnumeratePB;
		   );
		9: (
			msamDelete:					MSAMDeletePB;
		   );
		10: (
			msamOpen:					MSAMOpenPB;
		   );
		11: (
			msamOpenNested:				MSAMOpenNestedPB;
		   );
		12: (
			msamClose:					MSAMClosePB;
		   );
		13: (
			msamGetMsgHeader:			MSAMGetMsgHeaderPB;
		   );
		14: (
			msamGetAttributes:			MSAMGetAttributesPB;
		   );
		15: (
			msamGetRecipients:			MSAMGetRecipientsPB;
		   );
		16: (
			msamGetContent:				MSAMGetContentPB;
		   );
		17: (
			msamGetEnclosure:			MSAMGetEnclosurePB;
		   );
		18: (
			msamEnumerateBlocks:		MSAMEnumerateBlocksPB;
		   );
		19: (
			msamGetBlock:				MSAMGetBlockPB;
		   );
		20: (
			msamMarkRecipients:			MSAMMarkRecipientsPB;
		   );
		21: (
			msamnMarkRecipients:		MSAMnMarkRecipientsPB;
		   );
		22: (
			msamCreate:					MSAMCreatePB;
		   );
		23: (
			msamBeginNested:			MSAMBeginNestedPB;
		   );
		24: (
			msamEndNested:				MSAMEndNestedPB;
		   );
		25: (
			msamSubmit:					MSAMSubmitPB;
		   );
		26: (
			msamPutMsgHeader:			MSAMPutMsgHeaderPB;
		   );
		27: (
			msamPutAttribute:			MSAMPutAttributePB;
		   );
		28: (
			msamPutRecipient:			MSAMPutRecipientPB;
		   );
		29: (
			msamPutContent:				MSAMPutContentPB;
		   );
		30: (
			msamPutEnclosure:			MSAMPutEnclosurePB;
		   );
		31: (
			msamPutBlock:				MSAMPutBlockPB;
		   );
		32: (
			msamCreateReport:			MSAMCreateReportPB;					{ Reports and Error Handling Calls }
		   );
		33: (
			msamPutRecipientReport:		MSAMPutRecipientReportPB;
		   );
		34: (
			pmsamCreateMsgSummary:		PMSAMCreateMsgSummaryPB;
		   );
		35: (
			pmsamPutMsgSummary:			PMSAMPutMsgSummaryPB;
		   );
		36: (
			pmsamGetMsgSummary:			PMSAMGetMsgSummaryPB;
		   );
		37: (
			wakeupPMSAM:				MailWakeupPMSAMPB;
		   );
		38: (
			createMailSlot:				MailCreateMailSlotPB;
		   );
		39: (
			modifyMailSlot:				MailModifyMailSlotPB;
		   );
	END;

CONST
	uppMSAMIOCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }

PROCEDURE CallMSAMIOCompletionProc(VAR paramBlock: MSAMParam; userRoutine: MSAMIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION NewMSAMIOCompletionProc(userRoutine: MSAMIOCompletionProcPtr): MSAMIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION MailCreateMailSlot(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $1f00, $3f3c, 1323, $AA5E;
	{$ENDC}
{ ASYNCHRONOUS ONLY, client must call WaitNextEvent }
FUNCTION MailModifyMailSlot(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $1f00, $3f3c, 1324, $AA5E;
	{$ENDC}
{ ASYNCHRONOUS ONLY, client must call WaitNextEvent }
FUNCTION MailWakeupPMSAM(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $1f00, $3f3c, 1287, $AA5E;
	{$ENDC}
{ Personal MSAM Glue Routines }
FUNCTION PMSAMOpenQueues(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1280, $AA5E;
	{$ENDC}
FUNCTION PMSAMSetStatus(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1319, $AA5E;
	{$ENDC}
{ SYNC ONLY }
FUNCTION PMSAMGetMSAMRecord(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1286, $AA5E;
	{$ENDC}
{ Server MSAM Glue Routines }
{ SYNC ONLY }
FUNCTION SMSAMSetup(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1315, $AA5E;
	{$ENDC}
{ SYNC ONLY }
FUNCTION SMSAMStartup(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1281, $AA5E;
	{$ENDC}
FUNCTION SMSAMShutdown(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1282, $AA5E;
	{$ENDC}
{ Get Interface Glue Routines }
FUNCTION MSAMEnumerate(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1283, $AA5E;
	{$ENDC}
FUNCTION MSAMDelete(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1284, $AA5E;
	{$ENDC}
FUNCTION MSAMMarkRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1285, $AA5E;
	{$ENDC}
FUNCTION MSAMnMarkRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1298, $AA5E;
	{$ENDC}
FUNCTION MSAMOpen(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1288, $AA5E;
	{$ENDC}
FUNCTION MSAMOpenNested(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1289, $AA5E;
	{$ENDC}
FUNCTION MSAMClose(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1290, $AA5E;
	{$ENDC}
FUNCTION MSAMGetRecipients(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1292, $AA5E;
	{$ENDC}
FUNCTION MSAMGetAttributes(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1291, $AA5E;
	{$ENDC}
FUNCTION MSAMGetContent(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1293, $AA5E;
	{$ENDC}
FUNCTION MSAMGetEnclosure(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1294, $AA5E;
	{$ENDC}
FUNCTION MSAMEnumerateBlocks(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1295, $AA5E;
	{$ENDC}
FUNCTION MSAMGetBlock(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1296, $AA5E;
	{$ENDC}
FUNCTION MSAMGetMsgHeader(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1297, $AA5E;
	{$ENDC}
{ Put Interface Glue Routines }
FUNCTION MSAMCreate(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1300, $AA5E;
	{$ENDC}
FUNCTION MSAMBeginNested(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1301, $AA5E;
	{$ENDC}
FUNCTION MSAMEndNested(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1302, $AA5E;
	{$ENDC}
{  SYNCHRONOUS ONLY }
FUNCTION MSAMSubmit(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1303, $AA5E;
	{$ENDC}
FUNCTION MSAMPutAttribute(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1304, $AA5E;
	{$ENDC}
FUNCTION MSAMPutRecipient(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1305, $AA5E;
	{$ENDC}
FUNCTION MSAMPutContent(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1306, $AA5E;
	{$ENDC}
{  SYNCHRONOUS ONLY }
FUNCTION MSAMPutEnclosure(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1307, $AA5E;
	{$ENDC}
FUNCTION MSAMPutBlock(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1308, $AA5E;
	{$ENDC}
FUNCTION MSAMPutMsgHeader(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1309, $AA5E;
	{$ENDC}
{ Reports and Error Handling Glue Routines }
FUNCTION MSAMCreateReport(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1311, $AA5E;
	{$ENDC}
FUNCTION MSAMPutRecipientReport(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1312, $AA5E;
	{$ENDC}
FUNCTION PMSAMLogError(VAR paramBlock: MSAMParam): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $1f00, $3f3c, 1313, $AA5E;
	{$ENDC}
{ MsgSummary Glue Routines }
FUNCTION PMSAMCreateMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1314, $AA5E;
	{$ENDC}
FUNCTION PMSAMPutMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1317, $AA5E;
	{$ENDC}
FUNCTION PMSAMGetMsgSummary(VAR paramBlock: MSAMParam; asyncFlag: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $3f3c, 1318, $AA5E;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEMailIncludes}

{$ENDC} {__OCEMAIL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

/*
 	File:		OCEMessaging.h
 
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
 
*/

#ifndef __OCEMESSAGING__
#define __OCEMESSAGING__


#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Types.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __DIGITALSIGNATURE__
#include <DigitalSignature.h>
#endif

#ifndef __OCE__
#include <OCE.h>
#endif
/*	#include <Aliases.h>										*/
/*	#include <Script.h>											*/
/*		#include <IntlResources.h>								*/

#ifndef __OCEAUTHDIR__
#include <OCEAuthDir.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/******************************************************************************/
/* Definitions common to OCEMessaging and to OCEMail. These relate to addressing,
message ids and priorities, etc. */
/* Values of IPMPriority */

enum {
	kIPMAnyPriority				= 0,							/* FOR FILTER ONLY */
	kIPMNormalPriority			= 1,
	kIPMLowPriority,
	kIPMHighPriority
};

typedef Byte IPMPriority;

/* Values of IPMAccessMode */

enum {
	kIPMAtMark,
	kIPMFromStart,
	kIPMFromLEOM,
	kIPMFromMark
};

typedef unsigned short IPMAccessMode;


enum {
	kIPMUpdateMsgBit			= 4,
	kIPMNewMsgBit				= 5,
	kIPMDeleteMsgBit			= 6
};

/* Values of IPMNotificationType */
enum {
	kIPMUpdateMsgMask			= 1 << kIPMUpdateMsgBit,
	kIPMNewMsgMask				= 1 << kIPMNewMsgBit,
	kIPMDeleteMsgMask			= 1 << kIPMDeleteMsgBit
};

typedef Byte IPMNotificationType;

/* Values of IPMSenderTag */

enum {
	kIPMSenderRStringTag,
	kIPMSenderRecordIDTag
};

typedef unsigned short IPMSenderTag;


enum {
	kIPMFromDistListBit			= 0,
	kIPMDummyRecBit				= 1,
	kIPMFeedbackRecBit			= 2,							/* should be redirected to feedback queue */
	kIPMReporterRecBit			= 3,							/* should be redirected to reporter original queue */
	kIPMBCCRecBit				= 4								/* this recipient is blind to all recipients of message */
};

/* Values of OCERecipientOffsetFlags */
enum {
	kIPMFromDistListMask		= 1 << kIPMFromDistListBit,
	kIPMDummyRecMask			= 1 << kIPMDummyRecBit,
	kIPMFeedbackRecMask			= 1 << kIPMFeedbackRecBit,
	kIPMReporterRecMask			= 1 << kIPMReporterRecBit,
	kIPMBCCRecMask				= 1 << kIPMBCCRecBit
};

typedef Byte OCERecipientOffsetFlags;

struct OCECreatorType {
	OSType							msgCreator;
	OSType							msgType;
};
typedef struct OCECreatorType OCECreatorType;


enum {
	kIPMTypeWildCard			= 'ipmw',
	kIPMFamilyUnspecified		= 0,
	kIPMFamilyWildCard			= 0x3F3F3F3FL,					/* '??^ 

	* well known signature */
	kIPMSignature				= 'ipms',						/* base type 

	* well known message types */
	kIPMReportNotify			= 'rptn',						/* routing feedback

    * well known message block types */
	kIPMEnclosedMsgType			= 'emsg',						/* enclosed (nested) message */
	kIPMReportInfo				= 'rpti',						/* recipient information */
	kIPMDigitalSignature		= 'dsig'
};

/* Values of IPMMsgFormat */
enum {
	kIPMOSFormatType			= 1,
	kIPMStringFormatType		= 2
};

typedef unsigned short IPMMsgFormat;

typedef Str32 IPMStringMsgType;

union TheType {
	OCECreatorType					msgOSType;
	IPMStringMsgType				msgStrType;
};
typedef union TheType TheType;

struct IPMMsgType {
	IPMMsgFormat					format;						/* IPMMsgFormat*/
	TheType							theType;
};
typedef struct IPMMsgType IPMMsgType;

/*
Following are the known extension values for IPM addresses handled by Apple.
We define the definition of the entn extension below.
*/

enum {
	kOCEalanXtn					= 'alan',
	kOCEentnXtn					= 'entn',						/* entn = entity name (aka DSSpec) */
	kOCEaphnXtn					= 'aphn'
};

/*
Following are the specific definitions for the extension for the standard
OCEMail 'entn' addresses.  [Note, the actual extension is formatted as in
IPMEntityNameExtension.]
*/
/* entn extension forms */
enum {
	kOCEAddrXtn					= 'addr',
	kOCEQnamXtn					= 'qnam',
	kOCEAttrXtn					= 'attr',						/* an attribute specification */
	kOCESpAtXtn					= 'spat'
};

/*
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
*/
/* phoneNumber sub type constants */
enum {
	kOCEUseHandyDial			= 1,
	kOCEDontUseHandyDial		= 2
};

/* FORMAT OF A PACKED FORM RECIPIENT */
#define OCEPackedRecipientHeader  \
	unsigned short	dataLength;
struct ProtoOCEPackedRecipient {
	unsigned short					dataLength;
};
typedef struct ProtoOCEPackedRecipient ProtoOCEPackedRecipient;


enum {
	kOCEPackedRecipientMaxBytes	= (4096 - sizeof(ProtoOCEPackedRecipient))
};

struct OCEPackedRecipient {
	unsigned short					dataLength;
	Byte							data[kOCEPackedRecipientMaxBytes];
};
typedef struct OCEPackedRecipient OCEPackedRecipient;

struct IPMEntnQueueExtension {
	Str32							queueName;
};
typedef struct IPMEntnQueueExtension IPMEntnQueueExtension;

/* kOCEAttrXtn */
struct IPMEntnAttributeExtension {
	AttributeType					attributeName;
};
typedef struct IPMEntnAttributeExtension IPMEntnAttributeExtension;

/* kOCESpAtXtn */
struct IPMEntnSpecificAttributeExtension {
	AttributeCreationID				attributeCreationID;
	AttributeType					attributeName;
};
typedef struct IPMEntnSpecificAttributeExtension IPMEntnSpecificAttributeExtension;

/* All IPM entn extensions fit within the following */
struct IPMEntityNameExtension {
	OSType							subExtensionType;
	union {
		IPMEntnSpecificAttributeExtension specificAttribute;
		IPMEntnAttributeExtension		attribute;
		IPMEntnQueueExtension			queue;
	}								u;
};
typedef struct IPMEntityNameExtension IPMEntityNameExtension;

/* addresses with kIPMNBPXtn should specify this nbp type */
#define kIPMWSReceiverNBPType "\pMsgReceiver" 
struct IPMMsgID {
	unsigned long					id[4];
};
typedef struct IPMMsgID IPMMsgID;

/* Values of IPMHeaderSelector */

enum {
	kIPMTOC						= 0,
	kIPMSender					= 1,
	kIPMProcessHint				= 2,
	kIPMMessageTitle			= 3,
	kIPMMessageType				= 4,
	kIPMFixedInfo				= 7
};

typedef Byte IPMHeaderSelector;

union TheSender {
	RString							rString;
	PackedRecordID					rid;
};
typedef union TheSender TheSender;

struct IPMSender {
	IPMSenderTag					sendTag;
	TheSender						theSender;
};
typedef struct IPMSender IPMSender;

/******************************************************************************/
/* Definitions specific to OCEMessaging */
typedef unsigned long IPMContextRef;

typedef unsigned long IPMQueueRef;

typedef unsigned long IPMMsgRef;

typedef unsigned long IPMSeqNum;

typedef Str32 IPMProcHint;

typedef Str32 IPMQueueName;

typedef pascal void (*IPMNoteProcPtr)(IPMQueueRef queue, IPMSeqNum seqNum, IPMNotificationType notificationType, unsigned long userData);

#if GENERATINGCFM
typedef UniversalProcPtr IPMNoteUPP;
#else
typedef IPMNoteProcPtr IPMNoteUPP;
#endif

enum {
	uppIPMNoteProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(IPMQueueRef)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(IPMSeqNum)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(IPMNotificationType)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(unsigned long)))
};

#if GENERATINGCFM
#define NewIPMNoteProc(userRoutine)		\
		(IPMNoteUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppIPMNoteProcInfo, GetCurrentArchitecture())
#else
#define NewIPMNoteProc(userRoutine)		\
		((IPMNoteUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallIPMNoteProc(userRoutine, queue, seqNum, notificationType, userData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppIPMNoteProcInfo, (queue), (seqNum), (notificationType), (userData))
#else
#define CallIPMNoteProc(userRoutine, queue, seqNum, notificationType, userData)		\
		(*(userRoutine))((queue), (seqNum), (notificationType), (userData))
#endif

struct IPMFixedHdrInfo {
	unsigned short					version;
	Boolean							authenticated;
	Boolean							signatureEnclosed;			/*  digital signature enclosed */
	unsigned long					msgSize;
	IPMNotificationType				notification;
	IPMPriority						priority;
	unsigned short					blockCount;
	unsigned short					originalRcptCount;			/*		original number of recipients */
	unsigned long					refCon;						/*		Client defined data */
	unsigned short					reserved;
	UTCTime							creationTime;				/*		Time when it was created */
	IPMMsgID						msgID;
	OSType							family;						/* family this msg belongs (e.g. mail) */
};
typedef struct IPMFixedHdrInfo IPMFixedHdrInfo;


enum {
	kIPMDeliveryNotificationBit	= 0,
	kIPMNonDeliveryNotificationBit = 1,
	kIPMEncloseOriginalBit		= 2,
	kIPMSummaryReportBit		= 3,
/* modify enclose original to only on error */
	kIPMOriginalOnlyOnErrorBit	= 4
};

enum {
	kIPMNoNotificationMask		= 0x00,
	kIPMDeliveryNotificationMask = 1 << kIPMDeliveryNotificationBit,
	kIPMNonDeliveryNotificationMask = 1 << kIPMNonDeliveryNotificationBit,
	kIPMDontEncloseOriginalMask	= 0x00,
	kIPMEncloseOriginalMask		= 1 << kIPMEncloseOriginalBit,
	kIPMImmediateReportMask		= 0x00,
	kIPMSummaryReportMask		= 1 << kIPMSummaryReportBit,
	kIPMOriginalOnlyOnErrorMask	= 1 << kIPMOriginalOnlyOnErrorBit,
	kIPMEncloseOriginalOnErrorMask = (kIPMOriginalOnlyOnErrorMask | kIPMEncloseOriginalMask)
};

/* standard Non delivery codes */
enum {
	kIPMNoSuchRecipient			= 0x0001,
	kIPMRecipientMalformed		= 0x0002,
	kIPMRecipientAmbiguous		= 0x0003,
	kIPMRecipientAccessDenied	= 0x0004,
	kIPMGroupExpansionProblem	= 0x0005,
	kIPMMsgUnreadable			= 0x0006,
	kIPMMsgExpired				= 0x0007,
	kIPMMsgNoTranslatableContent = 0x0008,
	kIPMRecipientReqStdCont		= 0x0009,
	kIPMRecipientReqSnapShot	= 0x000A,
	kIPMNoTransferDiskFull		= 0x000B,
	kIPMNoTransferMsgRejectedbyDest = 0x000C,
	kIPMNoTransferMsgTooLarge	= 0x000D
};

/*************************************************************************/
/*
This is the structure that will be returned by enumerate and getmsginfo
This definition is just to give you a template, the position of msgType
is variable since this is a packed structure.  procHint and msgType are
packed and even length padded.

* master message info */
struct IPMMsgInfo {
	IPMSeqNum						sequenceNum;
	unsigned long					userData;
	unsigned short					respIndex;
	SInt8							padByte;
	IPMPriority						priority;
	unsigned long					msgSize;
	unsigned short					originalRcptCount;
	unsigned short					reserved;
	UTCTime							creationTime;
	IPMMsgID						msgID;
	OSType							family;						/* family this msg belongs (e.g. mail) */
	IPMProcHint						procHint;
	SInt8							filler2;
	IPMMsgType						msgType;
};
typedef struct IPMMsgInfo IPMMsgInfo;

typedef OCECreatorType IPMBlockType;

struct IPMTOC {
	IPMBlockType					blockType;
	long							blockOffset;
	unsigned long					blockSize;
	unsigned long					blockRefCon;
};
typedef struct IPMTOC IPMTOC;

/*
The following structure is just to describe the layout of the SingleFilter.
Each field should be packed and word aligned when passed to the IPM ToolBox.
*/
struct IPMSingleFilter {
	IPMPriority						priority;
	SInt8							padByte;
	OSType							family;						/* family this msg belongs (e.g. mail), '??^ for all */
	ScriptCode						script;						/* Language Identifier */
	IPMProcHint						hint;
	SInt8							filler2;
	IPMMsgType						msgType;
};
typedef struct IPMSingleFilter IPMSingleFilter;

struct IPMFilter {
	unsigned short					count;
	IPMSingleFilter					sFilters[1];
};
typedef struct IPMFilter IPMFilter;

/*************************************************************************
Following structures define the “start” of a recipient report block and the
elements of the array respectively.
*/
struct IPMReportBlockHeader {
	IPMMsgID						msgID;						/* message id of the original */
	UTCTime							creationTime;				/* creation time of the report */
};
typedef struct IPMReportBlockHeader IPMReportBlockHeader;

struct OCERecipientReport {
	unsigned short					rcptIndex;					/* index of recipient in original message */
	OSErr							result;						/* result of sending letter to this recipient*/
};
typedef struct OCERecipientReport OCERecipientReport;

/*************************************************************************/
typedef union IPMParamBlock IPMParamBlock;

typedef IPMParamBlock *IPMParamBlockPtr;

typedef pascal void (*IPMIOCompletionProcPtr)(IPMParamBlockPtr paramBlock);

#if GENERATINGCFM
typedef UniversalProcPtr IPMIOCompletionUPP;
#else
typedef IPMIOCompletionProcPtr IPMIOCompletionUPP;
#endif

#define IPMParamHeader 			\
	Ptr	qLink;						\
	long	reservedH1;				\
	long	reservedH2;				\
	IPMIOCompletionUPP	ioCompletion;	 \
	OSErr	ioResult;				\
	long	saveA5;					\
	short	reqCode;
struct IPMOpenContextPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMContextRef					contextRef;					/* <--  Context reference to be used in further calls*/
};
typedef struct IPMOpenContextPB IPMOpenContextPB;

typedef IPMOpenContextPB IPMCloseContextPB;

struct IPMCreateQueuePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	long							filler1;
	OCERecipient					*queue;
	AuthIdentity					identity;					/* used only if queue is remote */
	PackedRecordID					*owner;						/* used only if queue is remote */
};
typedef struct IPMCreateQueuePB IPMCreateQueuePB;

/* For createqueue and deletequeue only queue and identity are used */
typedef IPMCreateQueuePB IPMDeleteQueuePB;

struct IPMOpenQueuePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMContextRef					contextRef;
	OCERecipient					*queue;
	AuthIdentity					identity;
	IPMFilter						*filter;
	IPMQueueRef						newQueueRef;
	IPMNoteUPP						notificationProc;
	unsigned long					userData;
	IPMNotificationType				noteType;
	Byte							padByte;
	long							reserved;
	long							reserved2;
};
typedef struct IPMOpenQueuePB IPMOpenQueuePB;

struct IPMCloseQueuePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMQueueRef						queueRef;
};
typedef struct IPMCloseQueuePB IPMCloseQueuePB;

struct IPMEnumerateQueuePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMQueueRef						queueRef;
	IPMSeqNum						startSeqNum;
	Boolean							getProcHint;
	Boolean							getMsgType;
	short							filler;
	IPMFilter						*filter;
	unsigned short					numToGet;
	unsigned short					numGotten;
	unsigned long					enumCount;
	Ptr								enumBuffer;					/* will be packed array of IPMMsgInfo */
	unsigned long					actEnumCount;
};
typedef struct IPMEnumerateQueuePB IPMEnumerateQueuePB;

typedef IPMEnumerateQueuePB IPMChangeQueueFilterPB;

struct IPMDeleteMsgRangePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMQueueRef						queueRef;
	IPMSeqNum						startSeqNum;
	IPMSeqNum						endSeqNum;
	IPMSeqNum						lastSeqNum;
};
typedef struct IPMDeleteMsgRangePB IPMDeleteMsgRangePB;

struct IPMOpenMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMQueueRef						queueRef;
	IPMSeqNum						sequenceNum;
	IPMMsgRef						newMsgRef;
	IPMSeqNum						actualSeqNum;
	Boolean							exactMatch;
	Byte							padByte;
	long							reserved;
};
typedef struct IPMOpenMsgPB IPMOpenMsgPB;

struct IPMOpenHFSMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	FSSpec							*hfsPath;
	long							filler;
	IPMMsgRef						newMsgRef;
	long							filler2;
	Byte							filler3;
	Boolean							filler4;
	long							reserved;
};
typedef struct IPMOpenHFSMsgPB IPMOpenHFSMsgPB;

struct IPMOpenBlockAsMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	unsigned long					filler;
	IPMMsgRef						newMsgRef;
	unsigned short					filler2[7];
	unsigned short					blockIndex;
};
typedef struct IPMOpenBlockAsMsgPB IPMOpenBlockAsMsgPB;

struct IPMCloseMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	Boolean							deleteMsg;
	Boolean							filler1;
};
typedef struct IPMCloseMsgPB IPMCloseMsgPB;

struct IPMGetMsgInfoPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMMsgInfo						*info;
};
typedef struct IPMGetMsgInfoPB IPMGetMsgInfoPB;

struct IPMReadHeaderPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	unsigned short					fieldSelector;
	long							offset;
	unsigned long					count;
	Ptr								buffer;
	unsigned long					actualCount;
	unsigned short					filler;
	unsigned long					remaining;
};
typedef struct IPMReadHeaderPB IPMReadHeaderPB;

struct IPMReadRecipientPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	unsigned short					rcptIndex;
	long							offset;
	unsigned long					count;
	Ptr								buffer;
	unsigned long					actualCount;
	short							reserved;					/* must be zero */
	unsigned long					remaining;
	unsigned short					originalIndex;
	OCERecipientOffsetFlags			recipientOffsetFlags;
	Boolean							filler1;
};
typedef struct IPMReadRecipientPB IPMReadRecipientPB;

/*
replyQueue works like recipient. [can no longer read it via ReadHeader]
OriginalIndex is meaningless, rcptFlags are used seperately and there are
currently none defined.
*/
typedef IPMReadRecipientPB IPMReadReplyQueuePB;

struct IPMGetBlkIndexPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMBlockType					blockType;
	unsigned short					index;
	unsigned short					startingFrom;
	IPMBlockType					actualBlockType;
	unsigned short					actualBlockIndex;
};
typedef struct IPMGetBlkIndexPB IPMGetBlkIndexPB;

struct IPMReadMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMAccessMode					mode;
	long							offset;
	unsigned long					count;
	Ptr								buffer;
	unsigned long					actualCount;
	unsigned short					blockIndex;
	unsigned long					remaining;
};
typedef struct IPMReadMsgPB IPMReadMsgPB;

struct IPMVerifySignaturePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	SIGContextPtr					signatureContext;
};
typedef struct IPMVerifySignaturePB IPMVerifySignaturePB;

struct IPMNewMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	unsigned long					filler;
	OCERecipient					*recipient;
	OCERecipient					*replyQueue;
	StringPtr						procHint;
	unsigned short					filler2;
	IPMMsgType						*msgType;
	unsigned long					refCon;
	IPMMsgRef						newMsgRef;
	unsigned short					filler3;
	long							filler4;
	AuthIdentity					identity;
	IPMSender						*sender;
	unsigned long					internalUse;
	unsigned long					internalUse2;
};
typedef struct IPMNewMsgPB IPMNewMsgPB;

struct IPMNewHFSMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	FSSpec							*hfsPath;
	OCERecipient					*recipient;
	OCERecipient					*replyQueue;
	StringPtr						procHint;
	unsigned short					filler2;
	IPMMsgType						*msgType;
	unsigned long					refCon;
	IPMMsgRef						newMsgRef;
	unsigned short					filler3;
	long							filler4;
	AuthIdentity					identity;
	IPMSender						*sender;
	unsigned long					internalUse;
	unsigned long					internalUse2;
};
typedef struct IPMNewHFSMsgPB IPMNewHFSMsgPB;

struct IPMNestMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	unsigned short					filler[9];
	unsigned long					refCon;
	IPMMsgRef						msgToNest;
	unsigned short					filler2;
	long							startingOffset;
};
typedef struct IPMNestMsgPB IPMNestMsgPB;

struct IPMNewNestedMsgBlockPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	OCERecipient					*recipient;
	OCERecipient					*replyQueue;
	StringPtr						procHint;
	unsigned short					filler1;
	IPMMsgType						*msgType;
	unsigned long					refCon;
	IPMMsgRef						newMsgRef;
	unsigned short					filler2;
	long							startingOffset;
	AuthIdentity					identity;
	IPMSender						*sender;
	unsigned long					internalUse;
	unsigned long					internalUse2;
};
typedef struct IPMNewNestedMsgBlockPB IPMNewNestedMsgBlockPB;

struct IPMEndMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMMsgID						msgID;
	RString							*msgTitle;
	IPMNotificationType				deliveryNotification;
	IPMPriority						priority;
	Boolean							cancel;
	Byte							padByte;
	long							reserved;
	SIGSignaturePtr					signature;
	Size							signatureSize;
	SIGContextPtr					signatureContext;
/* family this msg belongs (e.g. mail) use kIPMFamilyUnspecified by default */
	OSType							family;
};
typedef struct IPMEndMsgPB IPMEndMsgPB;

struct IPMAddRecipientPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	OCERecipient					*recipient;
	long							reserved;
};
typedef struct IPMAddRecipientPB IPMAddRecipientPB;

struct IPMAddReplyQueuePB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	long							filler;
	OCERecipient					*replyQueue;
};
typedef struct IPMAddReplyQueuePB IPMAddReplyQueuePB;

struct IPMNewBlockPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMBlockType					blockType;
	unsigned short					filler[5];
	unsigned long					refCon;
	unsigned short					filler2[3];
	long							startingOffset;
};
typedef struct IPMNewBlockPB IPMNewBlockPB;

struct IPMWriteMsgPB {
	Ptr								qLink;
	long							reservedH1;
	long							reservedH2;
	IPMIOCompletionUPP				ioCompletion;
	OSErr							ioResult;
	long							saveA5;
	short							reqCode;
	IPMMsgRef						msgRef;
	IPMAccessMode					mode;
	long							offset;
	unsigned long					count;
	Ptr								buffer;
	unsigned long					actualCount;
	Boolean							currentBlock;
	Boolean							filler1;
};
typedef struct IPMWriteMsgPB IPMWriteMsgPB;

union IPMParamBlock {
	struct {
		Ptr								qLink;
		long							reservedH1;
		long							reservedH2;
		IPMIOCompletionUPP				ioCompletion;
		OSErr							ioResult;
		long							saveA5;
		short							reqCode;
	}								header;
	IPMOpenContextPB				openContextPB;
	IPMCloseContextPB				closeContextPB;
	IPMCreateQueuePB				createQueuePB;
	IPMDeleteQueuePB				deleteQueuePB;
	IPMOpenQueuePB					openQueuePB;
	IPMCloseQueuePB					closeQueuePB;
	IPMEnumerateQueuePB				enumerateQueuePB;
	IPMChangeQueueFilterPB			changeQueueFilterPB;
	IPMDeleteMsgRangePB				deleteMsgRangePB;
	IPMOpenMsgPB					openMsgPB;
	IPMOpenHFSMsgPB					openHFSMsgPB;
	IPMOpenBlockAsMsgPB				openBlockAsMsgPB;
	IPMCloseMsgPB					closeMsgPB;
	IPMGetMsgInfoPB					getMsgInfoPB;
	IPMReadHeaderPB					readHeaderPB;
	IPMReadRecipientPB				readRecipientPB;
	IPMReadReplyQueuePB				readReplyQueuePB;
	IPMGetBlkIndexPB				getBlkIndexPB;
	IPMReadMsgPB					readMsgPB;
	IPMVerifySignaturePB			verifySignaturePB;
	IPMNewMsgPB						newMsgPB;
	IPMNewHFSMsgPB					newHFSMsgPB;
	IPMNestMsgPB					nestMsgPB;
	IPMNewNestedMsgBlockPB			newNestedMsgBlockPB;
	IPMEndMsgPB						endMsgPB;
	IPMAddRecipientPB				addRecipientPB;
	IPMAddReplyQueuePB				addReplyQueuePB;
	IPMNewBlockPB					newBlockPB;
	IPMWriteMsgPB					writeMsgPB;
};
enum {
	uppIPMIOCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(IPMParamBlockPtr)))
};

#if GENERATINGCFM
#define CallIPMIOCompletionProc(userRoutine, paramBlock)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppIPMIOCompletionProcInfo, (paramBlock))
#else
#define CallIPMIOCompletionProc(userRoutine, paramBlock)		\
		(*(userRoutine))((paramBlock))
#endif

#if GENERATINGCFM
#define NewIPMIOCompletionProc(userRoutine)		\
		(IPMIOCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppIPMIOCompletionProcInfo, GetCurrentArchitecture())
#else
#define NewIPMIOCompletionProc(userRoutine)		\
		((IPMIOCompletionUPP) (userRoutine))
#endif

/*	Request codes */
#define kIPMOpenContext 0x400
#define kIPMCloseContext 0x401
#define kIPMNewMsg 0x402
#define kIPMAddRecipient 0x403
#define kIPMNewBlock 0x404
#define kIPMNewNestedMsgBlock 0x405
#define kIPMNestMsg 0x406
#define kIPMWriteMsg 0x407
#define kIPMEndMsg 0x408
#define kIPMOpenQueue 0x409
#define kIPMCloseQueue 0x40A
#define kIPMOpenMsg 0x40B
#define kIPMCloseMsg 0x40C
#define kIPMReadMsg 0x40D
#define kIPMReadHeader 0x40E
#define kIPMOpenBlockAsMsg 0x40F
#define kIPMReadRecipient 0x410
#define kIPMCreateQueue 0x411
#define kIPMDeleteQueue 0x412
#define kIPMEnumerateQueue 0x413
#define kIPMChangeQueueFilter 0x414
#define kIPMDeleteMsgRange 0x415
#define kIPMOpenHFSMsg 0x417
#define kIPMGetBlkIndex 0x418
#define kIPMGetMsgInfo 0x419
#define kIPMAddReplyQueue 0x41D
#define kIPMNewHFSMsg 0x41E
#define kIPMReadReplyQueue 0x421
#define kIPMVerifySignature 0x422
extern pascal OSErr IPMOpenContext(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x400, 0xAA5E);
extern pascal OSErr IPMCloseContext(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x401, 0xAA5E);
extern pascal OSErr IPMNewMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x402, 0xAA5E);
extern pascal OSErr IPMNewBlock(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x404, 0xAA5E);
extern pascal OSErr IPMNewNestedMsgBlock(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x405, 0xAA5E);
extern pascal OSErr IPMNestMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x406, 0xAA5E);
extern pascal OSErr IPMWriteMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x407, 0xAA5E);
extern pascal OSErr IPMEndMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x408, 0xAA5E);
extern pascal OSErr IPMOpenQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x409, 0xAA5E);
extern pascal OSErr IPMCloseQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40A, 0xAA5E);
/* Always synchronous */
extern pascal OSErr IPMVerifySignature(IPMParamBlockPtr paramBlock)
 FIVEWORDINLINE(0x7000, 0x1f00, 0x3F3C, 0x422, 0xAA5E);
extern pascal OSErr IPMOpenMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40B, 0xAA5E);
extern pascal OSErr IPMCloseMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40C, 0xAA5E);
extern pascal OSErr IPMReadMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40D, 0xAA5E);
extern pascal OSErr IPMReadHeader(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40E, 0xAA5E);
extern pascal OSErr IPMOpenBlockAsMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x40F, 0xAA5E);
extern pascal OSErr IPMNewHFSMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x41E, 0xAA5E);
extern pascal OSErr IPMReadRecipient(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x410, 0xAA5E);
extern pascal OSErr IPMReadReplyQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x421, 0xAA5E);
extern pascal OSErr IPMCreateQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x411, 0xAA5E);
extern pascal OSErr IPMDeleteQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x412, 0xAA5E);
extern pascal OSErr IPMEnumerateQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x413, 0xAA5E);
extern pascal OSErr IPMChangeQueueFilter(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x414, 0xAA5E);
extern pascal OSErr IPMDeleteMsgRange(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x415, 0xAA5E);
extern pascal OSErr IPMAddRecipient(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x403, 0xAA5E);
extern pascal OSErr IPMAddReplyQueue(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x41D, 0xAA5E);
extern pascal OSErr IPMOpenHFSMsg(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x417, 0xAA5E);
extern pascal OSErr IPMGetBlkIndex(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x418, 0xAA5E);
extern pascal OSErr IPMGetMsgInfo(IPMParamBlockPtr paramBlock, Boolean async)
 THREEWORDINLINE(0x3F3C, 0x419, 0xAA5E);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __OCEMESSAGING__ */

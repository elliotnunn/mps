/*
 	File:		OCEStandardMail.h
 
 	Contains:	Apple Open Collaboration Environment Standard Mail Interfaces.
 
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

#ifndef __OCESTANDARDMAIL__
#define __OCESTANDARDMAIL__


#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif
/*	#include <Menus.h>											*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Windows.h>										*/
/*	#include <TextEdit.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#ifndef __OCEAUTHDIR__
#include <OCEAuthDir.h>
#endif
/*	#include <OCE.h>											*/
/*		#include <Aliases.h>									*/
/*		#include <Script.h>										*/
/*			#include <IntlResources.h>							*/

#ifndef __OCEMAIL__
#include <OCEMail.h>
#endif
/*	#include <DigitalSignature.h>								*/
/*	#include <OCEMessaging.h>									*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kSMPVersion					= 1,
	gestaltSMPMailerVersion		= 'malr',
	gestaltSMPSPSendLetterVersion = 'spsl',
	kSMPNativeFormatName		= 'natv'
};

struct LetterSpec {
	unsigned long					spec[3];
};

typedef struct LetterSpec LetterSpec;


enum {
	typeLetterSpec				= 'lttr'
};

/*	Wildcard used for filtering letter types. */
enum {
	FilterAnyLetter				= 'ltr*',
	FilterAppleLetterContent	= 'ltc*',
	FilterImageContent			= 'lti*'
};

struct LetterDescriptor {
	Boolean							onDisk;
	Boolean							filler1;
	union {
		FSSpec							fileSpec;
		LetterSpec						mailboxSpec;
	} u;
};

typedef struct LetterDescriptor LetterDescriptor;

/*
SMPPSendAs values.  You may add the following values together to determine how the
file is sent, but you may not set both kSMPSendAsEnclosureMask and kSMPSendFileOnlyMask.  This
will allow you to send the letter as an image so that it will work with fax gateways
and send as an enclosure as well.
*/

enum {
	kSMPSendAsEnclosureBit,										/* Appears as letter with enclosures */
	kSMPSendFileOnlyBit,										/* Appears as a file in mailbox. */
	kSMPSendAsImageBit											/* Content imaged in letter */
};

/* Values of SMPPSendAs */
enum {
	kSMPSendAsEnclosureMask		= 1 << kSMPSendAsEnclosureBit,
	kSMPSendFileOnlyMask		= 1 << kSMPSendFileOnlyBit,
	kSMPSendAsImageMask			= 1 << kSMPSendAsImageBit
};

typedef Byte SMPPSendAs;

typedef pascal void (*SMPDrawImageProcPtr)(long refcon, Boolean inColor);

#if GENERATINGCFM
typedef UniversalProcPtr SMPDrawImageUPP;
#else
typedef SMPDrawImageProcPtr SMPDrawImageUPP;
#endif

enum {
	uppSMPDrawImageProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define NewSMPDrawImageProc(userRoutine)		\
		(SMPDrawImageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSMPDrawImageProcInfo, GetCurrentArchitecture())
#else
#define NewSMPDrawImageProc(userRoutine)		\
		((SMPDrawImageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSMPDrawImageProc(userRoutine, refcon, inColor)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSMPDrawImageProcInfo, (refcon), (inColor))
#else
#define CallSMPDrawImageProc(userRoutine, refcon, inColor)		\
		(*(userRoutine))((refcon), (inColor))
#endif

struct SMPRecipientDescriptor {
	struct SMPRecipientDescriptor	*next;						/*  Q-Link. */
	OSErr							result;						/*  result code when using the object. */
	OCEPackedRecipient				*recipient;					/*  Pointer to a Packed Address. */
	unsigned long					size;						/*  length of recipient in bytes. */
	MailRecipient					theAddress;					/*  structure points into recipient and theRID. */
	RecordID						theRID;						/*  structure points into recipient. */
};

typedef struct SMPRecipientDescriptor SMPRecipientDescriptor;

typedef SMPRecipientDescriptor *SMPRecipientDescriptorPtr;

struct SMPEnclosureDescriptor {
	struct SMPEnclosureDescriptor	*next;
	OSErr							result;
	FSSpec							fileSpec;
	OSType							fileCreator;				/*  Creator of this enclosure. */
	OSType							fileType;					/*  File Type of this enclosure. */
};

typedef struct SMPEnclosureDescriptor SMPEnclosureDescriptor;

typedef SMPEnclosureDescriptor *SMPEnclosureDescriptorPtr;

struct SMPLetterPB {
	OSErr							result;						/* result of operation */
	RStringPtr						subject;					/* RString */
	AuthIdentity					senderIdentity;				/* Letter is sent from this Identity */
	SMPRecipientDescriptorPtr		toList;						/* Pointer to linked list */
	SMPRecipientDescriptorPtr		ccList;						/* Pointer to linked list */
	SMPRecipientDescriptorPtr		bccList;					/* Pointer to linked list */
	ScriptCode						script;						/* Identifier for language */
	Size							textSize;					/* length of body data */
	Ptr								textBuffer;					/* body of the letter */
	SMPPSendAs						sendAs;						/* Send as Letter,Enclosure,Image */
	Byte							padByte;
	SMPEnclosureDescriptorPtr		enclosures;					/* files to be enclosed */
	SMPDrawImageUPP					drawImageProc;				/* For imaging */
	long							imageRefCon;				/* For imaging */
	Boolean							supportsColor;				/* For imaging - set to true if you application supports color imaging */
	Boolean							filler1;
};

typedef struct SMPLetterPB SMPLetterPB;

typedef SMPLetterPB *SMPLetterPBPtr;


enum {
	kSMPAppMustHandleEventBit,
	kSMPAppShouldIgnoreEventBit,
	kSMPContractedBit,
	kSMPExpandedBit,
	kSMPMailerBecomesTargetBit,
	kSMPAppBecomesTargetBit,
	kSMPCursorOverMailerBit,
	kSMPCreateCopyWindowBit,
	kSMPDisposeCopyWindowBit
};

/* Values of SMPMailerResult */
enum {
	kSMPAppMustHandleEventMask	= 1 << kSMPAppMustHandleEventBit,
	kSMPAppShouldIgnoreEventMask = 1 << kSMPAppShouldIgnoreEventBit,
	kSMPContractedMask			= 1 << kSMPContractedBit,
	kSMPExpandedMask			= 1 << kSMPExpandedBit,
	kSMPMailerBecomesTargetMask	= 1 << kSMPMailerBecomesTargetBit,
	kSMPAppBecomesTargetMask	= 1 << kSMPAppBecomesTargetBit,
	kSMPCursorOverMailerMask	= 1 << kSMPCursorOverMailerBit,
	kSMPCreateCopyWindowMask	= 1 << kSMPCreateCopyWindowBit,
	kSMPDisposeCopyWindowMask	= 1 << kSMPDisposeCopyWindowBit
};

typedef unsigned long SMPMailerResult;

/* Values of SMPMailerComponent*/

enum {
	kSMPOther					= -1,
	kSMPFrom					= 32,
	kSMPTo						= 20,
	kSMPRegarding				= 22,
	kSMPSendDateTime			= 29,
	kSMPAttachments				= 26,
	kSMPAddressOMatic			= 16
};

typedef unsigned long SMPMailerComponent;


enum {
	kSMPToAddress				= kMailToBit,
	kSMPCCAddress				= kMailCcBit,
	kSMPBCCAddress				= kMailBccBit
};

typedef MailAttributeID SMPAddressType;


enum {
	kSMPUndoCommand,
	kSMPCutCommand,
	kSMPCopyCommand,
	kSMPPasteCommand,
	kSMPClearCommand,
	kSMPSelectAllCommand
};

typedef unsigned short SMPEditCommand;


enum {
	kSMPUndoDisabled,
	kSMPAppMayUndo,
	kSMPMailerUndo
};

typedef unsigned short SMPUndoState;

/*
SMPSendFormatMask:

Bitfield indicating which combinations of formats are included in,
should be included or, or can be included in a letter.
*/

enum {
	kSMPNativeBit,
	kSMPImageBit,
	kSMPStandardInterchangeBit
};

/* Values of SMPSendFormatMask */
enum {
	kSMPNativeMask				= 1 << kSMPNativeBit,
	kSMPImageMask				= 1 << kSMPImageBit,
	kSMPStandardInterchangeMask	= 1 << kSMPStandardInterchangeBit
};

typedef unsigned long SMPSendFormatMask;

/*
	Pseudo-events passed to the clients filter proc for initialization and cleanup.
*/

enum {
	kSMPSendOptionsStart		= -1,
	kSMPSendOptionsEnd			= -2
};

/*
SMPSendFormatMask:

Structure describing the format of a letter.  If kSMPNativeMask bit is set, the whichNativeFormat field indicates which of the client-defined formats to use.
*/
struct SMPSendFormat {
	SMPSendFormatMask				whichFormats;
	short							whichNativeFormat;			/* 0 based */
};

typedef struct SMPSendFormat SMPSendFormat;

struct SMPLetterInfo {
	OSType							letterCreator;
	OSType							letterType;
	RString32						subject;
	RString32						sender;
};

typedef struct SMPLetterInfo SMPLetterInfo;


enum {
	kSMPSave,
	kSMPSaveAs,
	kSMPSaveACopy
};

typedef unsigned short SMPSaveType;

typedef pascal WindowPtr (*FrontWindowProcPtr)(long clientData);
typedef pascal void (*PrepareMailerForDrawingProcPtr)(WindowPtr window, long clientData);
typedef pascal Boolean (*SendOptionsFilterProcPtr)(DialogPtr theDialog, EventRecord *theEvent, short itemHit, long clientData);

#if GENERATINGCFM
typedef UniversalProcPtr FrontWindowUPP;
typedef UniversalProcPtr PrepareMailerForDrawingUPP;
typedef UniversalProcPtr SendOptionsFilterUPP;
#else
typedef FrontWindowProcPtr FrontWindowUPP;
typedef PrepareMailerForDrawingProcPtr PrepareMailerForDrawingUPP;
typedef SendOptionsFilterProcPtr SendOptionsFilterUPP;
#endif

enum {
	uppFrontWindowProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long))),
	uppPrepareMailerForDrawingProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppSendOptionsFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewFrontWindowProc(userRoutine)		\
		(FrontWindowUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFrontWindowProcInfo, GetCurrentArchitecture())
#define NewPrepareMailerForDrawingProc(userRoutine)		\
		(PrepareMailerForDrawingUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPrepareMailerForDrawingProcInfo, GetCurrentArchitecture())
#define NewSendOptionsFilterProc(userRoutine)		\
		(SendOptionsFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSendOptionsFilterProcInfo, GetCurrentArchitecture())
#else
#define NewFrontWindowProc(userRoutine)		\
		((FrontWindowUPP) (userRoutine))
#define NewPrepareMailerForDrawingProc(userRoutine)		\
		((PrepareMailerForDrawingUPP) (userRoutine))
#define NewSendOptionsFilterProc(userRoutine)		\
		((SendOptionsFilterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallFrontWindowProc(userRoutine, clientData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFrontWindowProcInfo, (clientData))
#define CallPrepareMailerForDrawingProc(userRoutine, window, clientData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPrepareMailerForDrawingProcInfo, (window), (clientData))
#define CallSendOptionsFilterProc(userRoutine, theDialog, theEvent, itemHit, clientData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSendOptionsFilterProcInfo, (theDialog), (theEvent), (itemHit), (clientData))
#else
#define CallFrontWindowProc(userRoutine, clientData)		\
		(*(userRoutine))((clientData))
#define CallPrepareMailerForDrawingProc(userRoutine, window, clientData)		\
		(*(userRoutine))((window), (clientData))
#define CallSendOptionsFilterProc(userRoutine, theDialog, theEvent, itemHit, clientData)		\
		(*(userRoutine))((theDialog), (theEvent), (itemHit), (clientData))
#endif

#define kSMPGetDimensions 4700
#define kSMPNewMailer 4701
#define kSMPDisposeMailer 4702
#define kSMPMailerEvent 4703
#define kSMPMailerEditCommand 4704
#define kSMPMailerForward 4705
#define kSMPMailerReply 4706
#define kSMPGetMailerState 4707
#define kSMPPrepareCoverPages 4708
#define kSMPDrawNthCoverPage 4709
#define kSMPBeginSave 4710
#define kSMPBeginSend 4711
#define kSMPOpenLetter 4712
#define kSMPDrawMailer 4713
#define kSMPMoveMailer 4714
#define kSMPSetSubject 4715
#define kSMPSetFromIdentity 4716
#define kSMPAddAddress 4717
#define kSMPAddAttachment 4718
#define kSMPContentChanged 4719
#define kSMPEndSave 4720
#define kSMPEndSend 4721
#define kSMPExpandOrContract 4722
#define kSMPBecomeTarget 4723
#define kSMPGetTabInfo 4724
#define kSMPClearUndo 4725
#define kSMPAttachDialog 4726
#define kSMPGetComponentSize 4727
#define kSMPGetComponentInfo 4728
#define kSMPGetListItemInfo 4729
#define kSMPAddContent 4730
#define kSMPReadContent 4731
#define kSMPGetFontNameFromLetter 4732
#define kSMPAddMainEnclosure 4733
#define kSMPGetMainEnclosureFSSpec 4734
#define kSMPAddBlock 4735
#define kSMPReadBlock 4736
#define kSMPEnumerateBlocks 4737
#define kSMPImage 4738
#define kSMPInitMailer 4741
#define kSMPGetNextLetter 4742
#define kSMPPrepareToClose 4743
#define kSMPCloseOptionsDialog 4744
#define kSMPPrepareToChange 4745
#define kSMPGetLetterInfo 4746
#define kSMPTagDialog 4747
#define kSMPSendOptionsDialog 5000
struct SMPMailerState {
	short							mailerCount;
	short							currentMailer;
	Point							upperLeft;
	Boolean							hasBeenReceived;
	Boolean							isTarget;
	Boolean							isExpanded;
	Boolean							canMoveToTrash;
	Boolean							canTag;
	Byte							padByte2;
	unsigned long					changeCount;
	SMPMailerComponent				targetComponent;
	Boolean							canCut;
	Boolean							canCopy;
	Boolean							canPaste;
	Boolean							canClear;
	Boolean							canSelectAll;
	Byte							padByte3;
	SMPUndoState					undoState;
	Str63							undoWhat;
};

typedef struct SMPMailerState SMPMailerState;

struct SMPSendOptions {
	Boolean							signWhenSent;
	IPMPriority						priority;
};

typedef struct SMPSendOptions SMPSendOptions;

typedef SMPSendOptions *SMPSendOptionsPtr, **SMPSendOptionsHandle;

struct SMPCloseOptions {
	Boolean							moveToTrash;
	Boolean							addTag;
	RString32						tag;
};

typedef struct SMPCloseOptions SMPCloseOptions;

typedef SMPCloseOptions *SMPCloseOptionsPtr;

/*----------------------------------------------------------------------------------------
	Send Package Routines
----------------------------------------------------------------------------------------*/
#define kSMPSendLetter 500
#define kSMPResolveToRecipient 1100
#define kSMPNewPage 2100
#define kSMPImageErr 2101
extern pascal OSErr SMPSendLetter(SMPLetterPBPtr theLetter)
 FOURWORDINLINE(0x203C, 2, 500, 0xAA5D);
extern pascal OSErr SMPNewPage(OpenCPicParams *newHeader)
 FOURWORDINLINE(0x203C, 2, 2100, 0xAA5D);
extern pascal OSErr SMPImageErr(void)
 FOURWORDINLINE(0x203C, 0, 2101, 0xAA5D);
extern pascal OSErr SMPResolveToRecipient(PackedDSSpecPtr dsSpec, SMPRecipientDescriptorPtr *recipientList, AuthIdentity identity)
 FOURWORDINLINE(0x203C, 6, 1100, 0xAA5D);
extern pascal OSErr SMPInitMailer(long mailerVersion)
 FOURWORDINLINE(0x203C, 2, 4741, 0xAA5D);
extern pascal OSErr SMPGetDimensions(short *width, short *contractedHeight, short *expandedHeight)
 FOURWORDINLINE(0x203C, 6, 4700, 0xAA5D);
extern pascal OSErr SMPGetTabInfo(SMPMailerComponent *firstTab, SMPMailerComponent *lastTab)
 FOURWORDINLINE(0x203C, 4, 4724, 0xAA5D);
extern pascal OSErr SMPNewMailer(WindowPtr window, Point upperLeft, Boolean canContract, Boolean initiallyExpanded, AuthIdentity identity, PrepareMailerForDrawingUPP prepareMailerForDrawingCB, long clientData)
 FOURWORDINLINE(0x203C, 12, 4701, 0xAA5D);
extern pascal OSErr SMPPrepareToClose(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4743, 0xAA5D);
extern pascal OSErr SMPCloseOptionsDialog(WindowPtr window, SMPCloseOptionsPtr closeOptions)
 FOURWORDINLINE(0x203C, 4, 4744, 0xAA5D);
extern pascal OSErr SMPTagDialog(WindowPtr window, RString32 *theTag)
 FOURWORDINLINE(0x203C, 4, 4747, 0xAA5D);
extern pascal OSErr SMPDisposeMailer(WindowPtr window, SMPCloseOptionsPtr closeOptions)
 FOURWORDINLINE(0x203C, 4, 4702, 0xAA5D);
extern pascal OSErr SMPMailerEvent(const EventRecord *event, SMPMailerResult *whatHappened, FrontWindowUPP frontWindowCB, long clientData)
 FOURWORDINLINE(0x203C, 8, 4703, 0xAA5D);
extern pascal OSErr SMPClearUndo(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4725, 0xAA5D);
extern pascal OSErr SMPMailerEditCommand(WindowPtr window, SMPEditCommand command, SMPMailerResult *whatHappened)
 FOURWORDINLINE(0x203C, 5, 4704, 0xAA5D);
extern pascal OSErr SMPMailerForward(WindowPtr window, AuthIdentity from)
 FOURWORDINLINE(0x203C, 4, 4705, 0xAA5D);
extern pascal OSErr SMPMailerReply(WindowPtr originalLetter, WindowPtr newLetter, Boolean replyToAll, Point upperLeft, Boolean canContract, Boolean initiallyExpanded, AuthIdentity identity, PrepareMailerForDrawingUPP prepareMailerForDrawingCB, long clientData)
 FOURWORDINLINE(0x203C, 15, 4706, 0xAA5D);
extern pascal OSErr SMPGetMailerState(WindowPtr window, SMPMailerState *itsState)
 FOURWORDINLINE(0x203C, 4, 4707, 0xAA5D);
extern pascal OSErr SMPSendOptionsDialog(WindowPtr window, Str255 documentName, StringPtr nativeFormatNames[], unsigned short nameCount, SMPSendFormatMask canSend, SMPSendFormat *currentFormat, SendOptionsFilterUPP filterProc, long clientData, SMPSendFormat *shouldSend, SMPSendOptionsPtr sendOptions)
 FOURWORDINLINE(0x203C, 19, 5000, 0xAA5D);
extern pascal OSErr SMPPrepareCoverPages(WindowPtr window, short *pageCount)
 FOURWORDINLINE(0x203C, 4, 4708, 0xAA5D);
extern pascal OSErr SMPDrawNthCoverPage(WindowPtr window, short pageNumber, Boolean doneDrawingCoverPages)
 FOURWORDINLINE(0x203C, 4, 4709, 0xAA5D);
extern pascal OSErr SMPPrepareToChange(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4745, 0xAA5D);
extern pascal OSErr SMPContentChanged(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4719, 0xAA5D);
extern pascal OSErr SMPBeginSave(WindowPtr window, const FSSpec *diskLetter, OSType creator, OSType fileType, SMPSaveType saveType, Boolean *mustAddContent)
 FOURWORDINLINE(0x203C, 11, 4710, 0xAA5D);
extern pascal OSErr SMPEndSave(WindowPtr window, Boolean okToSave)
 FOURWORDINLINE(0x203C, 3, 4720, 0xAA5D);
extern pascal OSErr SMPBeginSend(WindowPtr window, OSType creator, OSType fileType, SMPSendOptionsPtr sendOptions, Boolean *mustAddContent)
 FOURWORDINLINE(0x203C, 10, 4711, 0xAA5D);
extern pascal OSErr SMPEndSend(WindowPtr window, Boolean okToSend)
 FOURWORDINLINE(0x203C, 3, 4721, 0xAA5D);
extern pascal OSErr SMPOpenLetter(const LetterDescriptor *letter, WindowPtr window, Point upperLeft, Boolean canContract, Boolean initiallyExpanded, PrepareMailerForDrawingUPP prepareMailerForDrawingCB, long clientData)
 FOURWORDINLINE(0x203C, 12, 4712, 0xAA5D);
extern pascal OSErr SMPAddMainEnclosure(WindowPtr window, const FSSpec *enclosure)
 FOURWORDINLINE(0x203C, 4, 4733, 0xAA5D);
extern pascal OSErr SMPGetMainEnclosureFSSpec(WindowPtr window, FSSpec *enclosureDir)
 FOURWORDINLINE(0x203C, 4, 4734, 0xAA5D);
extern pascal OSErr SMPAddContent(WindowPtr window, MailSegmentType segmentType, Boolean appendFlag, void *buffer, unsigned long bufferSize, StScrpRec *textScrap, Boolean startNewScript, ScriptCode script)
 FOURWORDINLINE(0x203C, 12, 4730, 0xAA5D);
extern pascal OSErr SMPReadContent(WindowPtr window, MailSegmentMask segmentTypeMask, void *buffer, unsigned long bufferSize, unsigned long *dataSize, StScrpRec *textScrap, ScriptCode *script, MailSegmentType *segmentType, Boolean *endOfScript, Boolean *endOfSegment, Boolean *endOfContent, long *segmentLength, long *segmentID)
 FOURWORDINLINE(0x203C, 25, 4731, 0xAA5D);
extern pascal OSErr SMPGetFontNameFromLetter(WindowPtr window, short fontNum, Str255 fontName, Boolean doneWithFontTable)
 FOURWORDINLINE(0x203C, 6, 4732, 0xAA5D);
extern pascal OSErr SMPAddBlock(WindowPtr window, const OCECreatorType *blockType, Boolean append, void *buffer, unsigned long bufferSize, MailBlockMode mode, unsigned long offset)
 FOURWORDINLINE(0x203C, 12, 4735, 0xAA5D);
extern pascal OSErr SMPReadBlock(WindowPtr window, const OCECreatorType *blockType, unsigned short blockIndex, void *buffer, unsigned long bufferSize, unsigned long dataOffset, unsigned long *dataSize, Boolean *endOfBlock, unsigned long *remaining)
 FOURWORDINLINE(0x203C, 17, 4736, 0xAA5D);
extern pascal OSErr SMPEnumerateBlocks(WindowPtr window, unsigned short startIndex, void *buffer, unsigned long bufferSize, unsigned long *dataSize, unsigned short *nextIndex, Boolean *more)
 FOURWORDINLINE(0x203C, 13, 4737, 0xAA5D);
extern pascal OSErr SMPDrawMailer(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4713, 0xAA5D);
extern pascal OSErr SMPSetSubject(WindowPtr window, const RString *text)
 FOURWORDINLINE(0x203C, 4, 4715, 0xAA5D);
extern pascal OSErr SMPSetFromIdentity(WindowPtr window, AuthIdentity from)
 FOURWORDINLINE(0x203C, 4, 4716, 0xAA5D);
extern pascal OSErr SMPAddAddress(WindowPtr window, SMPAddressType addrType, OCEPackedRecipient *address)
 FOURWORDINLINE(0x203C, 5, 4717, 0xAA5D);
extern pascal OSErr SMPAddAttachment(WindowPtr window, const FSSpec *attachment)
 FOURWORDINLINE(0x203C, 4, 4718, 0xAA5D);
extern pascal OSErr SMPAttachDialog(WindowPtr window)
 FOURWORDINLINE(0x203C, 2, 4726, 0xAA5D);
extern pascal OSErr SMPExpandOrContract(WindowPtr window, Boolean expand)
 FOURWORDINLINE(0x203C, 3, 4722, 0xAA5D);
extern pascal OSErr SMPMoveMailer(WindowPtr window, short dh, short dv)
 FOURWORDINLINE(0x203C, 4, 4714, 0xAA5D);
extern pascal OSErr SMPBecomeTarget(WindowPtr window, Boolean becomeTarget, SMPMailerComponent whichField)
 FOURWORDINLINE(0x203C, 5, 4723, 0xAA5D);
extern pascal OSErr SMPGetComponentSize(WindowPtr window, unsigned short whichMailer, SMPMailerComponent whichField, unsigned short *size)
 FOURWORDINLINE(0x203C, 7, 4727, 0xAA5D);
extern pascal OSErr SMPGetComponentInfo(WindowPtr window, unsigned short whichMailer, SMPMailerComponent whichField, void *buffer)
 FOURWORDINLINE(0x203C, 7, 4728, 0xAA5D);
extern pascal OSErr SMPGetListItemInfo(WindowPtr window, unsigned short whichMailer, SMPMailerComponent whichField, void *buffer, unsigned long bufferLength, unsigned short startItem, unsigned short *itemCount, unsigned short *nextItem, Boolean *more)
 FOURWORDINLINE(0x203C, 16, 4729, 0xAA5D);
extern pascal OSErr SMPImage(WindowPtr window, SMPDrawImageUPP drawImageProc, long imageRefCon, Boolean supportsColor)
 FOURWORDINLINE(0x203C, 7, 4738, 0xAA5D);
extern pascal OSErr SMPGetNextLetter(OSType *typesList, short numTypes, LetterDescriptor *adjacentLetter)
 FOURWORDINLINE(0x203C, 5, 4742, 0xAA5D);
extern pascal OSErr SMPGetLetterInfo(LetterSpec *mailboxSpec, SMPLetterInfo *info)
 FOURWORDINLINE(0x203C, 4, 4746, 0xAA5D);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __OCESTANDARDMAIL__ */

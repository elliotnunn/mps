/*
 	File:		TextServices.h
 
 	Contains:	Text Services Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __TEXTSERVICES__
#define __TEXTSERVICES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/

#ifndef __MENUS__
#include <Menus.h>
#endif

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

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
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


enum {
	kTSMVersion					= 0x200,						/* Version of the Text Services Manager is 2.0  */
	kTextService				= 'tsvc',						/* component type for the component description */
	kInputMethodService			= 'inpm',						/* component subtype for the component description */
/* Component Flags in ComponentDescription */
	bTakeActiveEvent			= 15,							/* bit set if the component takes active event */
	bHandleAERecording			= 16,							/* bit set if the component takes care of recording Apple Events <new in vers2.0> */
	bScriptMask					= 0x00007F00,					/* bit 8 - 14 */
	bLanguageMask				= 0x000000FF,					/* bit 0 - 7  */
	bScriptLanguageMask			= bScriptMask + bLanguageMask	/* bit 0 - 14  */
};

enum {
/* Hilite styles */
	kCaretPosition				= 1,							/* specify caret position */
	kRawText					= 2,							/* specify range of raw text */
	kSelectedRawText			= 3,							/* specify range of selected raw text */
	kConvertedText				= 4,							/* specify range of converted text */
	kSelectedConvertedText		= 5								/* specify range of selected converted text */
};

/* Apple Event constants */
enum {
/* Event class */
	kTextServiceClass			= kTextService,
/* event ID */
	kUpdateActiveInputArea		= 'updt',						/* update the active Inline area */
	kPos2Offset					= 'p2st',						/* converting global coordinates to char position */
	kOffset2Pos					= 'st2p',						/* converting char position to global coordinates */
	kShowHideInputWindow		= 'shiw',						/* show or hide the input window */
/* Event keywords */
	keyAETSMDocumentRefcon		= 'refc',						/* TSM document refcon, typeLongInteger */
/* Note: keyAETSMScriptTag, keyAERequestedType, keyAETSMTextFont, keyAETextPointSize
	typeAEText, typeIntlWritingCode, typeQDPoint, and keyAEAngle have been moved to 
	AERegistry.h */
	keyAEServerInstance			= 'srvi',						/* component instance */
	keyAETheData				= 'kdat',						/* typeText */
	keyAEFixLength				= 'fixl',						/* fix len ?? */
	keyAEHiliteRange			= 'hrng',						/* hilite range array */
	keyAEUpdateRange			= 'udng',						/* update range array */
	keyAEClauseOffsets			= 'clau',						/* Clause Offsets array */
	keyAECurrentPoint			= 'cpos',						/* current point */
	keyAEDragging				= 'bool',						/* dragging falg */
	keyAEOffset					= 'ofst',						/* offset */
	keyAERegionClass			= 'rgnc',						/* region class */
	keyAEPoint					= 'gpos',						/* current point */
	keyAEBufferSize				= 'buff',						/* buffer size to get the text */
	keyAEMoveView				= 'mvvw',						/* move view flag */
	keyAELength					= 'leng',						/* length */
	keyAENextBody				= 'nxbd',						/* next or previous body */
/* optional keywords for Offset2Pos (Info about the active input area) */
	keyAETextLineHeight			= 'ktlh',						/* typeShortInteger */
	keyAETextLineAscent			= 'ktas',						/* typeShortInteger */
/* optional keywords for Pos2Offset */
	keyAELeftSide				= 'klef',						/* type Boolean */
/* optional keywords for kShowHideInputWindow */
	keyAEShowHideInputWindow	= 'shiw',						/* type Boolean */
/* for PinRange  */
	keyAEPinRange				= 'pnrg',
/* Desc type ... */
	typeComponentInstance		= 'cmpi',						/* server instance */
	typeTextRangeArray			= 'tray',						/* text range array */
	typeOffsetArray				= 'ofay',						/* offset array */
	typeText					= typeChar,						/* Plain text */
	typeTextRange				= 'txrn'
};

/* Desc type constants */
enum {
	kTSMOutsideOfBody			= 1,
	kTSMInsideOfBody			= 2,
	kTSMInsideOfActiveInputArea	= 3
};

enum {
	kNextBody					= 1,
	kPreviousBody				= 2
};

enum {
/* Low level routines which are dispatched directly to the Component Manager */
	kCMGetScriptLangSupport		= 0x0001,						/* Component Manager call selector 1 */
	kCMInitiateTextService		= 0x0002,						/* Component Manager call selector 2 */
	kCMTerminateTextService		= 0x0003,						/* Component Manager call selector 3 */
	kCMActivateTextService		= 0x0004,						/* Component Manager call selector 4 */
	kCMDeactivateTextService	= 0x0005,						/* Component Manager call selector 5 */
	kCMTextServiceEvent			= 0x0006,						/* Component Manager call selector 6 */
	kCMGetTextServiceMenu		= 0x0007,						/* Component Manager call selector 7 */
	kCMTextServiceMenuSelect	= 0x0008,						/* Component Manager call selector 8 */
	kCMFixTextService			= 0x0009,						/* Component Manager call selector 9 */
	kCMSetTextServiceCursor		= 0x000A,						/* Component Manager call selector 10 */
	kCMHidePaletteWindows		= 0x000B						/* Component Manager call selector 11 */
};

/* typeTextRange 		'txrn' */
struct TextRange {
	long							fStart;
	long							fEnd;
	short							fHiliteStyle;
};
typedef struct TextRange TextRange;

typedef TextRange *TextRangePtr;

typedef TextRangePtr *TextRangeHandle;

/* typeTextRangeArray	'txra' */
struct TextRangeArray {
	short							fNumOfRanges;				/* specify the size of the fRange array */
	TextRange						fRange[1];					/* when fNumOfRanges > 1, the size of this array has to be calculated */
};
typedef struct TextRangeArray TextRangeArray;

typedef TextRangeArray *TextRangeArrayPtr;

typedef TextRangeArrayPtr *TextRangeArrayHandle;

/* typeOffsetArray		'offa' */
struct OffsetArray {
	short							fNumOfOffsets;				/* specify the size of the fOffset array */
	long							fOffset[1];					/* when fNumOfOffsets > 1, the size of this array has to be calculated */
};
typedef struct OffsetArray OffsetArray;

typedef OffsetArray *OffsetArrayPtr;

typedef OffsetArrayPtr *OffsetArrayHandle;

#define mGetScriptCode(cdRec) ((ScriptCode)	((cdRec.componentFlags & bScriptMask) >> 8))
#define mGetLanguageCode(cdRec) ((LangCode)	cdRec.componentFlags & bLanguageMask)
typedef void *TSMDocumentID;

typedef OSType InterfaceTypeList[1];

/* Text Service Info List */
struct TextServiceInfo {
	Component						fComponent;
	Str255							fItemName;
};
typedef struct TextServiceInfo TextServiceInfo;

typedef TextServiceInfo *TextServiceInfoPtr;

struct TextServiceList {
	short							fTextServiceCount;			/* number of entries in the 'fServices' array */
	TextServiceInfo					fServices[1];				/* Note: array of 'TextServiceInfo' records follows */
};
typedef struct TextServiceList TextServiceList;

typedef TextServiceList *TextServiceListPtr;

typedef TextServiceListPtr *TextServiceListHandle;

struct ScriptLanguageRecord {
	ScriptCode						fScript;
	LangCode						fLanguage;
};
typedef struct ScriptLanguageRecord ScriptLanguageRecord;

struct ScriptLanguageSupport {
	short							fScriptLanguageCount;		/* number of entries in the 'fScriptLanguageArray' array */
	ScriptLanguageRecord			fScriptLanguageArray[1];	/* Note: array of 'ScriptLanguageRecord' records follows */
};
typedef struct ScriptLanguageSupport ScriptLanguageSupport;

typedef ScriptLanguageSupport *ScriptLanguageSupportPtr;

typedef ScriptLanguageSupportPtr *ScriptLanguageSupportHandle;

extern pascal OSErr NewTSMDocument(short numOfInterface, InterfaceTypeList supportedInterfaceTypes, TSMDocumentID *idocID, long refcon)
 TWOWORDINLINE(0x7000, 0xAA54);
extern pascal OSErr DeleteTSMDocument(TSMDocumentID idocID)
 TWOWORDINLINE(0x7001, 0xAA54);
extern pascal OSErr ActivateTSMDocument(TSMDocumentID idocID)
 TWOWORDINLINE(0x7002, 0xAA54);
extern pascal OSErr DeactivateTSMDocument(TSMDocumentID idocID)
 TWOWORDINLINE(0x7003, 0xAA54);
extern pascal Boolean TSMEvent(EventRecord *event)
 TWOWORDINLINE(0x7004, 0xAA54);
extern pascal Boolean TSMMenuSelect(long menuResult)
 TWOWORDINLINE(0x7005, 0xAA54);
extern pascal Boolean SetTSMCursor(Point mousePos)
 TWOWORDINLINE(0x7006, 0xAA54);
extern pascal OSErr FixTSMDocument(TSMDocumentID idocID)
 TWOWORDINLINE(0x7007, 0xAA54);
extern pascal OSErr GetServiceList(short numOfInterface, OSType *supportedInterfaceTypes, TextServiceListHandle *serviceInfo, long *seedValue)
 TWOWORDINLINE(0x7008, 0xAA54);
extern pascal OSErr OpenTextService(TSMDocumentID idocID, Component aComponent, ComponentInstance *aComponentInstance)
 TWOWORDINLINE(0x7009, 0xAA54);
extern pascal OSErr CloseTextService(TSMDocumentID idocID, ComponentInstance aComponentInstance)
 TWOWORDINLINE(0x700A, 0xAA54);
extern pascal OSErr SendAEFromTSMComponent(const AppleEvent *theAppleEvent, AppleEvent *reply, AESendMode sendMode, AESendPriority sendPriority, long timeOutInTicks, AEIdleUPP idleProc, AEFilterUPP filterProc)
 TWOWORDINLINE(0x700B, 0xAA54);
extern pascal OSErr InitTSMAwareApplication(void)
 TWOWORDINLINE(0x7014, 0xAA54);
extern pascal OSErr CloseTSMAwareApplication(void)
 TWOWORDINLINE(0x7015, 0xAA54);
/* Utilities */
extern pascal OSErr SetDefaultInputMethod(Component ts, ScriptLanguageRecord *slRecordPtr)
 TWOWORDINLINE(0x700C, 0xAA54);
extern pascal OSErr GetDefaultInputMethod(Component *ts, ScriptLanguageRecord *slRecordPtr)
 TWOWORDINLINE(0x700D, 0xAA54);
extern pascal OSErr SetTextServiceLanguage(ScriptLanguageRecord *slRecordPtr)
 TWOWORDINLINE(0x700E, 0xAA54);
extern pascal OSErr GetTextServiceLanguage(ScriptLanguageRecord *slRecordPtr)
 TWOWORDINLINE(0x700F, 0xAA54);
extern pascal OSErr UseInputWindow(TSMDocumentID idocID, Boolean useWindow)
 TWOWORDINLINE(0x7010, 0xAA54);
extern pascal OSErr NewServiceWindow(void *wStorage, const Rect *boundsRect, ConstStr255Param title, Boolean visible, short theProc, WindowPtr behind, Boolean goAwayFlag, ComponentInstance ts, WindowPtr *window)
 TWOWORDINLINE(0x7011, 0xAA54);
extern pascal OSErr CloseServiceWindow(WindowPtr window)
 TWOWORDINLINE(0x7012, 0xAA54);
extern pascal OSErr GetFrontServiceWindow(WindowPtr *window)
 TWOWORDINLINE(0x7013, 0xAA54);
extern pascal short FindServiceWindow(Point thePoint, WindowPtr *theWindow)
 TWOWORDINLINE(0x7017, 0xAA54);
/* Low level TSM routines */
extern pascal ComponentResult GetScriptLanguageSupport(ComponentInstance ts, ScriptLanguageSupportHandle *scriptHdl)
 FIVEWORDINLINE(0x2F3C, 0x04, 0x0001, 0x7000, 0xA82A);
extern pascal ComponentResult InitiateTextService(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x0002, 0x7000, 0xA82A);
extern pascal ComponentResult TerminateTextService(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x0003, 0x7000, 0xA82A);
extern pascal ComponentResult ActivateTextService(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x0004, 0x7000, 0xA82A);
extern pascal ComponentResult DeactivateTextService(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x0005, 0x7000, 0xA82A);
extern pascal ComponentResult TextServiceEvent(ComponentInstance ts, short numOfEvents, EventRecord *event)
 FIVEWORDINLINE(0x2F3C, 0x06, 0x0006, 0x7000, 0xA82A);
extern pascal ComponentResult GetTextServiceMenu(ComponentInstance ts, MenuHandle *serviceMenu)
 FIVEWORDINLINE(0x2F3C, 0x4, 0x0007, 0x7000, 0xA82A);
extern pascal ComponentResult TextServiceMenuSelect(ComponentInstance ts, MenuHandle serviceMenu, short item)
 FIVEWORDINLINE(0x2F3C, 0x06, 0x0008, 0x7000, 0xA82A);
extern pascal ComponentResult FixTextService(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x0009, 0x7000, 0xA82A);
extern pascal ComponentResult SetTextServiceCursor(ComponentInstance ts, Point mousePos)
 FIVEWORDINLINE(0x2F3C, 0x04, 0x000A, 0x7000, 0xA82A);
extern pascal ComponentResult HidePaletteWindows(ComponentInstance ts)
 FIVEWORDINLINE(0x2F3C, 0x00, 0x000B, 0x7000, 0xA82A);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __TEXTSERVICES__ */

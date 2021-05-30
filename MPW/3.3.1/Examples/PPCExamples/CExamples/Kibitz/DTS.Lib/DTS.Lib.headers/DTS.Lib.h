#ifndef __DTSLib__
#define __DTSLib__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifndef __PRINTING__
#include <Printing.h>
#endif

#ifndef __TREEOBJ__
#include "TreeObj.h"
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

/********/

typedef void		(*CalcFrameRgnProcPtr)(FileRecHndl frHndl, WindowPtr window, RgnHandle rgn);
typedef void		(*ContentClickProcPtr)(WindowPtr window, EventRecord *event, Boolean firstClick);
typedef Boolean		(*ContentKeyProcPtr)(WindowPtr window, EventRecord *event, Boolean *passThrough);
typedef void		(*DrawFrameProcPtr)(FileRecHndl frHndl, WindowPtr window, Boolean activate);
typedef OSErr		(*FreeDocumentProcPtr)(FileRecHndl frHndl);
typedef OSErr		(*FreeWindowProcPtr)(FileRecHndl frHndl, WindowPtr window);
typedef OSErr		(*ImageProcPtr)(FileRecHndl frHndl);
typedef OSErr		(*InitContentProcPtr)(FileRecHndl frHndl, WindowPtr window);
typedef OSErr		(*ReadDocumentProcPtr)(FileRecHndl frHndl);
typedef OSErr		(*ReadDocumentHeaderProcPtr)(FileRecHndl frHndl);
typedef void		(*ResizeContentProcPtr)(WindowPtr window, short oldh, short oldv);
typedef void		(*ScrollFrameProcPtr)(FileRecHndl frHndl, WindowPtr window, long dh, long dv);
typedef void		(*UndoFixupProcPtr)(FileRecHndl frHndl, Point contOrg, Boolean afterUndo);
typedef Boolean		(*WindowCursorProcPtr)(FileRecHndl frHndl, WindowPtr window, Point globalPt);
typedef OSErr		(*WriteDocumentProcPtr)(FileRecHndl frHndl);
typedef OSErr		(*WriteDocumentHeaderProcPtr)(FileRecHndl frHndl);
typedef Boolean		(*AdjustMenuItemsProcPtr)(WindowPtr window, short menuID);
typedef Boolean		(*DoMenuItemProcPtr)(WindowPtr window, short menuID, short menuItem);
	/* The above are the procPtrs that are kept in a file reference handle.  These point to
	** the functions in your application that are automatically called by the framework.
	** You will find stub functions in the files Window.c, WindowDialog.c, and WindowPalette.c
	** The framework initializes these procPtrs to point to the correct set of functions, based
	** on the type of the window (kwIsDocument, kwIsModalDialog, or kwIsPalette). */

typedef OSErr		(*HideWindowProcPtr)(FileRecHndl frHndl, WindowPtr window);

typedef long		(*DocScrollBarProc)(FileRecHndl frHndl, ControlHandle ctl, short message, long val);
#define kscrollHAdjust        0
#define kscrollVAdjust        1
#define kscrollGetHOrigin     2
#define kscrollGetVOrigin     3
#define kscrollGetHLongOrigin 4
#define kscrollGetVLongOrigin 5
	/* The document scrollbars can be coerced into handling long values.  If you need long values
	** from the document scrollbars because your document space is greater than 32k, then
	** place a DocScrollBarProc in the refCon field of the document scrollbar.  You will then get
	** called at appropriate times with the various messages.  The proc's job is to convert the
	** short value from the scrollbar to a logical long (and back again) for the various messages.
	** The file reference handle is also passed in, so you can combine the state of the document
	** with the scrollbar's short value to derive the long scroll value. */

typedef struct {
	OSType						sfType;
	Boolean						defaultDoc;
	Movie						movie;
	short						movieResID;
	short						movieFlags;
	Boolean						movieDataRefWasChanged;
	Boolean						docDirty;
	long						modNum;
	long						modTick;
	Boolean						readOnly;
	short						refNum;
	short						resRefNum;
	FSSpec						fss;
	short						windowID;
	WindowPtr					window;
	PositionWndProcPtr			getDocWindow;
	CalcFrameRgnProcPtr			calcFrameRgnProc;
	ContentClickProcPtr			contentClickProc;
	ContentKeyProcPtr			contentKeyProc;
	DrawFrameProcPtr			drawFrameProc;
	FreeDocumentProcPtr			freeDocumentProc;
	FreeWindowProcPtr			freeWindowProc;
	ImageProcPtr				imageProc;
	InitContentProcPtr			initContentProc;
	ReadDocumentProcPtr			readDocumentProc;
	ReadDocumentHeaderProcPtr	readDocumentHeaderProc;
	ResizeContentProcPtr		resizeContentProc;
	ScrollFrameProcPtr			scrollFrameProc;
	UndoFixupProcPtr			undoFixupProc;
	WindowCursorProcPtr			windowCursorProc;
	WriteDocumentProcPtr		writeDocumentProc;
	WriteDocumentHeaderProcPtr	writeDocumentHeaderProc;
	AdjustMenuItemsProcPtr		adjustMenuItemsProc;
	DoMenuItemProcPtr			doMenuItemProc;
	long						attributes;			/* Here down is window content information. */
	Rect						windowSizeBounds;
	ControlHandle				hScroll;
	ControlHandle				vScroll;
	short						hScrollIndent;
	short						vScrollIndent;
	short						leftSidebar;
	short						topSidebar;
	short						hArrowVal;
	short						vArrowVal;
	short						hPageVal;
	short						vPageVal;
} FileStateRec;

typedef struct {
	long			windowTag[2];		/* Used to match up windows.					*/
	short			endSendInfo;		/* Above is send info.							*/

	short			connected;			/* Flag showing we are connected.				*/
	AEAddressDesc	remoteLoc;			/* AppleEvents address of remote user.			*/
	Str32			remoteName;			/* Name of user connected to.					*/
	Str32			remoteZone;			/* Zone of user connected to.					*/
	Str32			remoteMachine;		/* Machine name of user connected to.			*/

	Str255			remotePath;			/* Full path of user connected to.	*/
	Str32			remoteApp;			/* Name of user connected to.		*/

	short			endLocalInfo;		/* Above info is for one machine only.			*/
} ConnectRec;

typedef struct {
	short		version;			/* The file format version.					*/
	Boolean		printRecValid;		/* True if prRec has been created.			*/
	TPrint		print;				/* Print record for file.					*/
	Rect		structureRect;		/* Remember where window was when saved.	*/
	Rect		contentRect;		/* Remember where window was when saved.	*/
	Rect		stdState;			/* This and below rect used for saving		*/
	Rect		userState;			/* zoom information for window.				*/
	long		hDocSize;			/* hDocSize and vDocSize have to be saved	*/
	long		vDocSize;			/* with the document, or recalculated		*/
									/* when the file is opened so that the		*/
									/* window can be created the correct size.	*/
	short		endDocHeaderInfo;	/* End version, print, and window info.		*/
} DocHeaderInfo;

struct AEHandler{
	AEEventClass		theEventClass;
	AEEventID			theEventID;
	ProcPtr				theHandler;
	AEEventHandlerUPP	theUPP;
};
typedef struct AEHandler AEHandler;

typedef struct {
	OSType	sfType;
	char	sfTypeTerm;			/* 0-byte which terminates sfType, thus making it a c-str. */
	short	windowID;
	long	attributes;
	Boolean	fileBasedDoc;		/* True if document can be opened/saved. */
	Boolean	openAsDefault;		/* True if new document should be created as default document. */
	Boolean	openAtStartup;		/* True if new document should always be created at startup. */
	short	hScrollIndent;
	short	vScrollIndent;
	short	leftSidebar;
	short	topSidebar;
	char	title[2];			/* title[0] = enumerated window title */
								/* title[1] = references and offsets to other WFMTObj definitions */
								/* A WFMTObj can reference other for inclusion into the window 
								** content.  The format is TYPE,xoffset,yoffset,TYPE,xoffset,yoffset.
								** A WFMTObj can reference as many other WFMTObj's as will fit into
								** a max pascal string.  If this isn't enough (hard to imagine),
								** then a WFMTObj can act as a container for other WFMTObj's.  They
								** can be nested as many deep as you want. */
} WFMTObj;
#define mDerefWFMT(hndl) ((WFMTObj*)((*hndl) + 1))

typedef struct {
	short	numRows;
	short	numCols;
	short	cellHeight;
	short	cellWidth;
	short	mode;
} CLNewInfo;
typedef struct {
	Rect	destRct;
	Rect	viewRct;
	Rect	brdrRct;
	short	maxTextLen;
	short	mode;
} CTENewInfo;
typedef struct {
	Boolean			selected;
	Rect			rect;
	char			visible;
	char			hilite;
	short			value, min, max;
	unsigned short	procID;
	long			refCon;
	unsigned short	ctlID;
	short			cctbID;
	short			fontSize;
	Style			fontStyle;
	union {
		CLNewInfo	clnew;
		CTENewInfo	ctenew;
	} extCtl;
	unsigned char	title[4];		/* 4 pascal strings are stored back-to-back starting here. */
									/* title[0] = control title */
									/* title[1] = key equivs    */
									/* title[2] = control font  */
									/* title[3] = balloon help info */
	short			textLen[2];		/* 2 short-prefixed data blocks stored starting here.
									** textLen[0] = textEdit control text block
									** textLen[1] = textEdit control style block */
} CtlObj;
#define mDerefCtl(hndl) ((CtlObj*)((*hndl) + 1))

typedef struct {
	TreeObjHndl		ctlObj;
	ControlHandle	ctl;
} CObjCtl;
typedef CObjCtl CObjCtlAry[];
typedef CObjCtlAry *CObjCtlPtr, **CObjCtlHndl;

/* The structs CLNewInfo, CTENewInfo, and CtlObj are primarily for support of the AppsToGo
** application editor.  However, you may find it useful to know the format of the control
** objects used by the framework for control creation.  At startup time, your application is
** free to modify any control definitions.  These changes may be based on user preferences
** or whatever.  Just look up the control definition object, and change it.  When the control
** definition is used, the modification will be reflected in the control creation. */ 

/********/

#define mDerefWStateData(window) (*(WStateDataHandle)(((WindowPeek)window)->dataHandle))

#define kwGrowIcon			0x00000001L
#define kwHScroll			0x00000002L
#define kwHScrollLessGrow	0x00000006L
#define kwVScroll			0x00000008L
#define kwVScrollLessGrow	0x00000018L
#define kwVisible			0x00000020L
#define kwOpenAtOldLoc		0x00000040L
#define kwDoFirstClick		0x00000080L
#define kwHideOnClose		0x00000100L
#define kwIsDocument		0
#define kwIsPalette			0x00000200L
#define kwIsModalDialog		0x00000400L
#define kwDefaultDocHeader	0x00000800L
#define kwHeaderIsResource	0x00001000L
#define kwRuntimeOnlyDoc	0x00002000L
#define kwAutoNew			0x00004000L
#define kwDefaultDocType	0x00008000L
#define kwColorMonitor		0x00010000L
#define kwSecondaryMonitor	0x00020000L
#define kwStaggerWindow		0x00040000L
#define kwCenterWindow		0x00080000L
#define kwSameMonitor		0x00100000L
	/* These are the various window and document attributes you can set with AppsToGo. */

#define kwNoChange			-32767
	/* This constant is used to inform SetContentOrigin, SetSidebarSize, and SetScrollIndent
	** to leave either the horizontal or vertical component as it was.  This allows you to change
	** just one component without having to look up the old value for the other component. */

#define kwBotScroll			32767
	/* This constant is used to inform SetContentOrigin to scroll as far as possible for either
	** the horizontal or vertical component. */

#define kwShowAll			0x01
#define kwHideAll			0x03
#define kwStandardVis		0x00
#define kwInvertVis			0x02
#define kwInvalOnHide		0x04
	/* These values are used for modifying the display of a control set.  See the AppsToGo
	** manual for an explanation of control sets. */

#define kMinWindowWidth  200
#define kMinWindowHeight 200
#define kMaxWindowWidth  16384
#define kMaxWindowHeight 16384
	/* These are the default min and max sizes for a window.  They are placed in the
	** windowSizeBounds rect when a new file reference handle is created.  Simply change the
	** windowSizeBounds rect for documents that need other values. */

#define kwVHAppWindow		(kwVisible)
	/* This simply means that the View Hierarchy window is initially visible.
	** (Not much good if it isn't.) */

#define kCustomEventClass  'CUST'
#define keySFType          'KSFT'
#define keyFSS             'KFSS'
#define keyPascal          'PSTR'
#define keyAppConnect      'KCNT'
#define keyWindowTag	   'KWND'
#define keyWFMTMessage     'WFMT'
#define keyRSRCMessage     'RSRC'

#define typeAppConnect     'KCNT'
#define typeDoubleLong     'DBLL'
#define typePascal         'PSTR'
#define typePascal2        'PST2'
#define typePascal3        'PST3'
#define typeWFMTMessage    'WFMT'
#define typeRSRCMessage    'RSRC'
#define typeRSRCType       'RSTY'
#define typeRSRCID         'RSID'
#define typeBlockNum       'BLKN'
	/* These are the various AppleEvent keys and types currently used by the framework.
	** You are free to create your own for your application's use. */

#define kGetWFMTMssg           0
#define kSetWFMTMssg           1
#define kMergeAppResourcesMssg 2
#define kGetAppResourceMssg    3
#define kSetAppResourceMssg    4
	/* AppleEvent sub-messages used by the AppsToGo application editor. */

#define keyReplyErr        'errn'

#define kWrongVersion	1

#define kInvalRefNum	0
#define kInvalVRefNum	0

#define kSaveYes		1
#define kSaveNo			3
#define kSaveCanceled	4

#define kOpenYes		1
#define kOpenNo			3

#define kStdAbout		1

#define kStdNew			1
#define kStdOpen		2
#define kStdClose		3
#define kStdSave		4
#define kStdSaveAs		5
#define kStdPageSetup	6
#define kStdPrint		7
#define kStdQuit		8

#define kStdUndo		1
#define kStdRedo		2
#define kStdCut			3
#define kStdCopy		4
#define kStdPaste		5
#define kStdClear		6
#define kStdViewHier	7

#define kOpenMovie ((FSSpecPtr)-1)

/********/
/********/
/********/

#define kViewHierFileType 'VWHR'

#define rTECtl			4000
#define rListCtl		4016
#define rCIconCtl		4032
#define rPICTCtl		4048
#define rStatTextCtl	4064
#define rICONCtl		4080
#define rDataCtl		4096

#define	rMenuBar	128				/* application's menu bar */

#define	rWindow		128				/* application's primary document window */
#define	rVHWindow	129				/* view hierarchy window */

#define	rErrorAlert		129
#define rYesNoCancel	130
#define rOpenReadOnly	131
#define rPrStatusDlg	132

#define	mApple	128
#define	iAbout	1

#define kSave   0
#define kSaveAs 1
#define kClose  2
#define kQuit   3

#define rNewViewCtl		128

#define rBadNewsStrings		257			/* Not-good-at-all startup error messages. */
#define sWimpyMachine		1			/* Strings to display in the user item */
#define sHeapTooSmall		2
#define sNoFreeRoomInHeap	3
#define sBadThingHappened	4

#define rFileIOStrings	258				/* Strings for StandardFile dialogs. */
#define sSFprompt 1
#define sWClosing 2
#define sQuitting 3

#define rDefaultTitles	259

#define rPPCText    260
#define sTitleText  1
#define sAppText    2


#endif

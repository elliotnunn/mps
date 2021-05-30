/*
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	Copyright © 1998-1999 Apple Computer, Inc., All Rights Reserved
*/
#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif
/*#include <CodeFragments.h>
#include <Dialogs.h>
#include <Events.h>
#include <Gestalt.h>
#include <MacTextEditor.h>
#include <ToolUtils.h>*/

void main(void);
void Initialize(void);
void InitMLTE(void);
void AlertUser(short error);
void EventLoop(void);
void DoEvent(EventRecord *event);
void AdjustCursor(RgnHandle region);
void DoGrowWindow(WindowPtr window, EventRecord *event);
void DoZoomWindow(WindowPtr window, short part);
void DoUpdate(WindowPtr window);
void DoActivate(WindowPtr window, Boolean becomingActive);
void DoContentClick( WindowPtr window, EventRecord *event);
//void DoKeyDown(EventRecord *event);
static UInt32 GetSleep(void);
void DoIdle(void);
void AdjustMenus(void);
void DoMenuCommand(long menuResult);
void DoJustification(WindowPtr window, short menuItem);
void DoWordWrap(WindowPtr window);
OSStatus DoNew(const FSSpec *fileSpecPtr);
Boolean DoCloseWindow( WindowPtr window);
void Terminate(void);
void BigBadError(short error);
Boolean IsAppWindow(WindowPtr window, TXNObject *object);
Boolean IsDAWindow(WindowPtr window);
void InstallAppleEventHandlers(void);
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr HandleOapp (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon);
pascal OSErr HandleOdoc (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon);
pascal OSErr HandlePdoc (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon);
pascal OSErr HandleQuit (const AppleEvent *aevt, AEDescList *reply, UInt32 refCon);
#else
pascal OSErr HandleOapp (const AppleEvent *aevt, AEDescList *reply, long refCon);
pascal OSErr HandleOdoc (const AppleEvent *aevt, AEDescList *reply, long refCon);
pascal OSErr HandlePdoc (const AppleEvent *aevt, AEDescList *reply, long refCon);
pascal OSErr HandleQuit (const AppleEvent *aevt, AEDescList *reply, long refCon);
#endif
 
// GInBackground is maintained by our OSEvent handling routines. Any part of
// the program can check it to find out if it is currently in the background.
Boolean	gInBackground;		// maintained by Initialize and DoEvent

// GNumDocuments is used to keep track of how many open documents there are
// at any time. It is maintained by the routines that open and close documents.
short	gNumDocuments;		// maintained by Initialize, DoNew, and DoCloseWindow

// Constants to identify menus and their items.
#define	mApple					128		// Apple menu
#define	iAbout					1

#define	mFile					129		// File menu
#define	iNew					1
#define	iClose					4
#define	iPageSetup				9
#define	iPrint					10
#define iQuitSeparator			11
#define	iQuit					12

#define	mEdit					130		// Edit menu
#define	iUndo					1
#define	iCut					3
#define	iCopy					4
#define	iPaste					5
#define	iClear					6
#define	iSelectAll				8

#define	mFont 					131		// Font menu

#define	mSize					132		// Size menu
#define	i9Point					1
#define	i10Point				2
#define	i12Point				3
#define	i14Point				4
#define	i18Point				5
#define	i24Point				6
#define	i36Point				7
#define	iSmallerFontSize		9
#define	iLargerFontSize			10
#define	iOtherFontSize			12

#define	mStyle					133		// Style menu
#define	iPlain					1
#define	iBold					2
#define	iItalic					3
#define	iUnderline				4
#define	iOutline				5
#define	iShadow					6
#define	iCondensed				7
#define	iExtended				8

#define	mLayout					134		// Format menu
#define	iDefaultJustify			1
#define	iLeftJustify			2
#define	iRightJustify			3
#define	iCenterJustify			4
#define	iFullJustify			5
#define	iForceJustify			6
#define	iAutoWrap				8

TXNFontMenuObject gTXNFontMenuObject;

#define kDefaultFontName	"\pNew York"

const short	kStartHierMenuID = 160;

// For positioning disk initialization dialogs
#define kDITop					0x0050
#define kDILeft					0x0070

/* kMaxOpenDocuments is used to determine whether a new document can be opened
   or created. We keep track of the number of open documents, and disable the
   menu items that create a new document when the maximum is reached. If the
   number of documents falls below the maximum, the items are enabled again. */
#define	kMaxOpenDocuments		1

/* The following are indicies into STR# resources. */
#define	eWrongSystem				1
#define	eNoMemory					2
#define	eNoCut						3
#define	eNoCopy						4
#define	eNoClear					5
#define	eNoWindow					6
#define	eNoPaste					7
#define	eNoMLTE						8
#define eNoAttachObjectToWindow 	9
#define eNoActivate					10
#define eObjectNotAttachedToWindow	11
#define	eNoFontName					12
#define	eNoFontSize					13
#define	eNoFontStyle				14
#define	eNoJustification			15
#define eNoDisposeFontMenuObject	16
#define	eNoWordWrap					17

#define	rMenuBar	128				/* application's menu bar */
#define	rAboutAlert	128				/* about alert */
#define	rUserAlert	129				/* user error alert */
#define	rDocWindow	128				/* application's window */
#define	kErrStrings	128				/* error string list */


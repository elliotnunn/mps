/*-----------------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	Collection of Utilities for DTS Sample code
#
#	Program:	Utilities.c.o
#	File:		Utilities.h	-	Header for C Source
#
#	Copyright © 1988-1990 Apple Computer, Inc.
#	All rights reserved.
#
-----------------------------------------------------------------------------------------*/

#ifndef __UTILITIES__
#define __UTILITIES__

#if defined(applec) || defined (powerc)

#	ifndef __TYPES__
#		include <Types.h>
#	endif

#	ifndef __QUICKDRAW__
#		include <QuickDraw.h>
#	endif

#	ifndef __DIALOGS__
#		include <Dialogs.h>
#	endif

#	ifndef __FILES__
#		include <Files.h>
#	endif

#	ifndef __MEMORY__
#		include <Memory.h>
#	endif

#	ifndef __MENUS__
#		include <Menus.h>
#	endif

#	ifndef __OSUTILS__
#		include <OSUtils.h>
#	endif

#	ifndef __WINDOWS__
#		include <Windows.h>
#	endif

#endif


#include "UtilitiesCommon.h"
#ifndef __STRINGUTILS__
#include "StringUtils.h"
#endif


struct PopupCtlData {
	MenuHandle		mHandle;
	short			mID;
	char			mPrivate[1];
};
typedef struct PopupCtlData PopupCtlData;
typedef PopupCtlData *PopupCtlDataPtr, **PopupCtlDataHandle;
#define	kMenuItemTxtInsert	-1
#define	kMenuItemNumInsert	-2
#define kMenuItemSectionEnd	-3

/*-----------------------------------------------------------------------------------------
	Global constants
-----------------------------------------------------------------------------------------*/
#ifndef applec

#ifndef nil
#define nil	0L
#endif

#ifndef _WaitNextEvent
#define _WaitNextEvent	0xA860
#endif

#ifndef _InitGraf
#define _InitGraf		0xA86E
#endif

#ifndef _Unimplemented
#define _Unimplemented	0xA89F
#endif

/*
#define screenActive			15
*/
#endif

#define	kNoEvents				0			/* no events mask */
#define kDelayTime				4			/* For the delay time when flashing the
											   menubar and highlighting a button.
											   4/60ths of a second*/

#define kStartPtH				2			/* offset from the left of the screen */
#define kStartPtV				2			/* offset from the top of the screen */
#define kStaggerH				12			/* staggering amounts for new windows */
#define kStaggerV				16

#define chHome					'\001'		/* ASCII code for the Home key */
#define chEnter					'\003'		/* ASCII code for Enter character */
#define chEnd					'\004'		/* ASCII code for the End key */
#define chHelp					'\005'		/* ASCII code for Help key */
#define chBackspace				'\010'		/* ASCII code for Backspace character */
#define chTab					'\011'		/* ASCII code for Tab character */
#define chPageUp				'\013'		/* ASCII code for Page Up key */
#define chPageDown				'\014'		/* ASCII code for Page Down key */
#define chReturn				'\015'		/* ASCII code for Return character */
#define chFunction				'\020'		/* ASCII code for any function key */
#define chClear					'\033'		/* ASCII code for Clear key (aka ESC) */
#define chEscape				'\033'		/* ASCII code for Escape (aka Clear) key */
#define chLeft					'\034'		/* ASCII code for left arrow */
#define chRight					'\035'		/* ASCII code for right arrow */
#define chUp					'\036'		/* ASCII code for up arrow */
#define chDown					'\037'		/* ASCII code for down arrow */
#define chFwdDelete				'\177'		/* ASCII code for forward delete */
#define chSpace					' '			/* ASCII code for Space character */

enum { kQDOriginal = 0, kQD8Bit, kQD32Bit };	/* For use with gQDVersion */

/*-----------------------------------------------------------------------------------------
	Types
-----------------------------------------------------------------------------------------*/

typedef short *IntegerPtr, **IntegerHandle;

typedef long *LongintPtr, **LongintHandle;

typedef Boolean *BooleanPtr, **BooleanHandle;

#ifndef THINK_C
typedef Rect *RectPtr, **RectHandle;
#endif

struct	WindowTemplate	{					/*template to a WIND resource*/
	Rect	boundsRect;
	short	procID;
	Boolean	visible;
	Boolean	filler1;
	Boolean	goAwayFlag;
	Boolean	filler2;
	long	refCon;
	Str255	title;
};
typedef	struct	WindowTemplate	WindowTemplate;
typedef			WindowTemplate	*WindowTPtr, **WindowTHndl;

/* following is here to account for lapses in the THINK C headers */

#ifndef applec
#ifndef powerc
#ifndef THINK_C
/*
typedef unsigned char TrapType;
*/
struct NumVersion {
	unsigned char majorRev; 		/* 1st part of version number in BCD*/
/*	unsigned short minorRev : 4;		2nd part is 1 nibble in BCD*/
/*	unsigned short bugFixRev : 4; 		3rd part is 1 nibble in BCD*/
	unsigned char minorAndBugFixRev;
	unsigned char stage;			/*stage code: dev, alpha, beta, final*/
	unsigned char nonRelRev;		/*revision level of non-released version*/
};

typedef struct NumVersion NumVersion;
/* Numeric version part of 'vers' resource */
struct VersRec {
	NumVersion numericVersion;		/*encoded version number*/
	short countryCode;				/*country code from intl utilities*/
	Str255 shortVersion;			/*version number string - worst case*/
	Str255 reserved;				/*longMessage string packed after shortVersion*/
};
typedef struct VersRec VersRec;
typedef VersRec *VersRecPtr, **VersRecHndl;


#define Length(string) (*(unsigned char *)(string))
#define Gestalt			GESTALT
#define NewGestalt		NEWGESTALT
#define ReplaceGestalt	REPLACEGESTALT
#endif
#endif
#endif

#ifdef powerc
#define FlushInstructionCache()
#endif

typedef Rect (*PositionWndProcPtr)(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo);
typedef void (*DrawControlProc)(ControlHandle ctl);


typedef struct PFSSpec {
	FSSpec	fss;
	Str31	volName;
} PFSSpec;
typedef PFSSpec *PFSSpecPtr;

typedef Boolean	(*TrackControlProcPtr)(ControlHandle ctl, short part, EventRecord *event);
typedef void	(*ScrollProcPtr)(ControlHandle ctl, short part, short oldVal, short newVal);
typedef struct ControlStyleInfo {
	short				ctlID;
	TrackControlProcPtr	trackProc;
	ScrollProcPtr		scrollProc;
	short				hArrowVal;
	short				vArrowVal;
	short				hPageVal;
	short				vPageVal;
	DrawControlProc		drawControl;
	short				fontSize;
	Style				fontStyle;
	Str32				font;
	Str63				keyEquivs;
	Str255				balloonHelp;
} ControlStyleInfo;
typedef ControlStyleInfo *ControlStyleInfoPtr;



/*-----------------------------------------------------------------------------------------
	Handy Macros/inlines
-----------------------------------------------------------------------------------------*/
#ifdef false										/* The c++ stuff is turned OFF!!! */

inline Point* TopLeft(Rect& r)						/* provide access to rect.topLeft  */
{	return (Point*)(&r.top); }

inline Point* BotRight(Rect& r)						/* provide access to rect.botRight  */
{	return (Point*)(&r.bottom); }

inline short HiWrd(long aLong)						/* return the hi word of a long */
{	return ((aLong >> 16) & 0xFFFF); }

inline short LoWrd(long aLong)						/* return the lo word of a long */
{	return (aLong & 0xFFFF); }

inline void SETPT(Point *pt,short h,short v)
{	(*pt).h = h; (*pt).v = v); }

inline void SETRECT(Rect *r,short left,short top,short right,short bottom)
{	SETPT(TopLeft(*r), left, top); SETPT(BotRight(*r), right, bottom); }

/* 
 *	Useful functions for testing gestalt attribute responses
 *
 *	BTstBool returns a true boolean value (0 or 1), but is slower than:
 *	BTstQ which simply returns a non-zero value if the bit is set which
 *	means the result could get lost if assigned to a short, for example.
 *
 *	arg is any integer value, bitnbr is the number of the bit to be tested.
 *	bitnbr = 0 is the least significant bit.
 */
inline short BTstBool(arg, bitnbr)	
{	return ((arg >> bitnbr) & 1); }

inline long BTstQ(arg, bitnbr)
{	return (arg & (1 << bitnbr)); }

#else


#ifndef THINK_C
#define QD(whatever) (qd.##whatever)
#else
#define QD(whatever) (whatever)
#endif


#define TopLeft(r)		(* (Point *) &(r).top)
#define BotRight(r)		(* (Point *) &(r).bottom)
#define HiWrd(aLong)	(((aLong) >> 16) & 0xFFFF)
#define LoWrd(aLong)	((aLong) & 0xFFFF)
#define MIN(a, b) ((a) < (b) ? (a) : (b) )
#define MAX(a, b) ((a) > (b) ? (a) : (b) )
#define SETPT(pt, x, y)	(*(pt)).h = (x); (*(pt)).v = (y)
#define SETRECT(r, left, top, right, bottom)	\
						SETPT(&TopLeft(*(r)), (left), (top)); \
						SETPT(&BotRight(*(r)), (right), (bottom))

#define offsetof(structure,field) ((unsigned long)&((structure *) 0)->field)

/* 
 *	Useful macros for testing gestalt attribute responses
 *
 *	BTstBool returns a true boolean value (0 or 1), but is slower than:
 *	BTstQ which simply returns a non-zero value if the bit is set which
 *	means the result could get lost if assigned to a short, for example.
 *
 *	arg is any integer value, bitnbr is the number of the bit to be tested.
 *	bitnbr = 0 is the least significant bit.
 */
#define BTstBool(arg, bitnbr)	((arg >> bitnbr) & 1)
#define BTstQ(arg, bitnbr)		(arg & (1 << bitnbr))

#endif

/*-----------------------------------------------------------------------------------------
	Global variables
-----------------------------------------------------------------------------------------*/
/*	The following global variables are initialized by StardardInitialization to
 *	define the environnment.  This used to be a single SysEnvRec, but now,
 *	all those variables defined in a SysEnvRec can be returned by Gestalt
 *	(except sysVRefNum; see FindSysFolder).  Note that all the variables
 *	below will be correctly initialized whether Gestalt is available or not;
 *	the Gestalt glue handles this.
 */
extern short			gMachineType;			/* which machine this is */
extern short			gSystemVersion;			/* System version number */
extern short			gProcessorType;			/* which CPU this is */
extern Boolean			gHasFPU;				/* true if machine has an FPU */
extern short			gQDVersion;				/* major QD version #; 0 for original, 
													1 for color QD, 2 for 32-bit QD */
extern short			gKeyboardType;			/* which type of keyboard is present */
extern short			gAppleTalkVersion;		/* AppleTalk version number */
		
/*	These are also handled by Gestalt. gHasPMMU has no corresponding SysEnvRec
 *	field, but it is handled by the glue, so we include it here for completeness.
 *	gAUXVersion will be initialized with Gestalt if present, but correctly
 *	set even if Gestalt is not available
 */
extern Boolean			gHasPMMU;				/* true if machine has a PMMU or equivalent */
extern short			gAUXVersion;			/* major A/UX version number (0 if not present) */

/*	
 *	gHasWaitNextEvent is set to TRUE if the Macintosh we are running on has
 *	WaitNextEvent implemented. We can use this in our main event loop to
 *	determine whether to call WaitNextEvent or GetNextEvent.
 */
extern Boolean			gHasWaitNextEvent;

/*
 *	gAppResRef is the application’s resource file reference. I need to save
 *	this since I can open other resource files. The current resource file is
 *	always gAppResRef unless I momentarily set it to another file to read its
 *	resources, and then immediately restore it back.
 */
extern short			gAppResRef;

/*
 *	gInBackground is maintained by our osEvent handling routines. Any part of
 *	the program can check it to find out if it is currently in the background.
 */
extern Boolean			gInBackground;			/* maintained by StandardInitialization
													  and DoEvent */
													  
/*
 *	gAppName holds the name of the application that's running. You can use if
 *	for any purpose you'd like. It is also used by StandardAbout if it can't
 *	find a string to use for the application name in a resource, so make sure
 *	you call InitForStandardAbout if you are going to call StandardAbout. If you
 *	call StandardInitialization, this is done for you.
 */
extern Str255			gAppName;

/*
 *	gSignature holds the creator signature for the running application. It follows the
 *	same rules as those for gAppName.
 */
extern OSType			gSignature;

/*
 *	Initial values of these global variables are set to zero or FALSE by MPW's 
 *	runtime initialization routines.  If the Utilities initialization routines
 *	have been properly called, then gUtilitiesInited will be true.  If it is
 *	not true, then the values of the above global variables are invalid.
 */
extern Boolean			gUtilitiesInited;

/*
 *	These are global UniversalProcPtrs for AlertFilter() and KeyEquivFilter()
 *	These are always initialized.
 */
extern ModalFilterUPP	gAlertFilterUPP;
extern ModalFilterUPP	gKeyEquivFilterUPP;

/*-----------------------------------------------------------------------------------------
	Interface to routines
-----------------------------------------------------------------------------------------*/

#ifdef __cplusplus
extern "C" {
#endif

Rect		SetWindowPlacementRect(Rect *rct);
			/* Set the window placement rect.  This rect overrides normal window positioning
			   in favor of the rect passed in.  For reference, the function also returns the
			   old window placement rect.  If nil is passed in for the new rect, then no
			   change to the positioning rect is made.  The old rect is still returned. */

short		CenteredAlert(short alertID, WindowPtr relatedWindow, ModalFilterUPP filter);
			/* Given an Alert ID and a related window pointer, this routine will center
			   the alert on the same device as the related window.  If the related
			   window pointer is nil, then the alert will be centered on the device
			   that the alert would normally be placed if Alert was called directly. */

void		CenterRectInRect(Rect outerRect, Rect *innerRect);
			/* Given two rectangles, this routine centers the second one within the first. */

Rect		CenterWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo);
			/* Given a window pointer and a related window pointer, this routine will
			   center the window on the same device as the related window.  If the
			   related window pointer is nil, then the window will be centered on the
			   device that the window already is.
			   WARNING: This routine may move or purge memory. */

void		CloseAnyWindow(WindowPtr window);
			/* Closes the indicated window.  Does the right thing, taking into account
			   that the window may belong to a DA.
			   WARNING: An application window is closed via a CloseWindow call.  Use
			   			this call when you want to keep the storage for the window
						record.  (Compare against DisposeAnyWindow.) */

void		DisposeAnyWindow(WindowPtr window);
			/* Disposes of the indicated window.  Does the right thing, taking into account
			   that the window may belong to a DA.
			   WARNING: An application window is closed via a DisposeWindow call.  Use
			   			this call when you want to free up the storage for the window
						record.  (Compare against CloseAnyWindow.) */

void		DeathAlert(short errResID, short errStringIndex);
			/* Display an alert that tells the user an error occurred, then exit the
			   program. This routine is used as an ultimate bail-out for serious errors
			   that prohibit the continuation of the application. */ 

void		DeathAlertMessage(short errResID, short errStringIndex, short message);

void		ErrorAlert(short errResID, short errStringIndex);

void		ErrorAlertMessage(short errResID, short errStringIndex, short message);

OSErr		FindSysFolder(short *foundVRefNum, long *foundDirID);
			/* FindSysFolder returns the (real) vRefNum, and the DirID of the current
			   system folder.  It uses the Folder Manager if present, otherwise
			   it falls back to SysEnvirons.  It returns zero on success, otherwise
			   a standard system error. */

Handle		GetAppIndResource(ResType theType, short index, OSErr *err);
			/* GetAppIndResource gets a resource from the application's res file by index */

Handle		GetAppNamedResource(ResType theType, StringPtr name, OSErr *err);
			/* GetAppNamedResource gets a resource from the application's res file by name */

Handle		GetAppResource(ResType theType, short theID, OSErr *err);
			/* GetAppResource gets a resource from the application's res file by resource ID */

short		GetAUXVersion( void);
			/* getAUXVersion -- Checks for the presence of A/UX by whatever means is
			   appropriate.  Returns the major version number of A/UX (i.e. 0 if A/UX 
			   is not present, 1 for any 1.x.x version 2 for any 2.x version, etc.
			   This code should work for all past, present and future A/UX systems. */

short		GetButtonVariant(ControlHandle ctl);
				/* This function returns which kind of button the control is.  This does more
				** than GetCVariant in that it makes sure that the control is actually a
				** button.  It does this by comparing the defProc against the known defProc
				** for the various button types.  For 7.0, there is only one defProc for all
				** variants, but for pre-7.0, there is one defProc value for each variant.
				** The method below handles either case. */

OSErr		SimpleCanDialog(void);
			/* Check to see if dialogs are allowed.  They may not be if AppleScript is
			   running the show. */

DialogPtr	GetCenteredDialog(short id, DialogPtr storage, WindowPtr relatedWindow, WindowPtr behind);
			/* Given a dialog ID and a related window pointer, this routine will center
			   the dialog on the same device as the related window.  If the related
			   window pointer is nil, then the dialog will be centered on the device
			   that the dialog would normally be placed if GetNewDialog was called. */

WindowPtr	GetCenteredWindow(short id, Ptr storage, Boolean vis, WindowPtr relWindow,
							  WindowPtr behind, Boolean inColor, Rect sizeInfo, long refCon);
			/* Given a window ID and a related window pointer, this routine will center
			   the window on the same device as the related window.  If the related
			   window pointer is nil, then the window will be centered on the device
			   that the window would normally be placed if GetNewWindow was called.  The
			   function is also passed the sizeInfo rect, which holds min and max size
			   information for the window.  (See GetSomeKindOfWindow.) */

Boolean 	GetCheckOrRadio(DialogPtr dlgPtr, short itemNo);

long		GetGestaltResult(OSType gestaltSelector);
			/* GetGestaltResult returns the result value from Gestalt for the specified
			   selector.  If Gestalt returned an error GetGestaltResult returns zero.  Use 
			   of this function is only cool if we don't care whether Gestalt returned an 
			   error.  In many casesyou may need to know the exact Gestalt error code so 
			   then this routine would be inappropriate. */

Point		GetGlobalMouse(void);
			/* Returns the location of the mouse in local coordinates. It does this by
			   calling OSEventAvail(). */ 

Point		GetGlobalTopLeft(WindowPtr window);
			/* 	Given a window, this will return the top left point of the window’s port in
			  	global coordinates. Something this doesn’t include, is the window’s drag
			  	region (or title bar). This returns the top left point of the window’s
			  	content area only. */

long		GetKFreeSpace(short vRefNum);

Rect		GetMainScreenRect(void);

GDHandle	GetRectDevice(Rect globalRect);
			/* Find the greatest overlap device for the given global rectangle.
			** This function assumes that you have a system that GDHandle can happen.
			** If you call this function on other QuickDraws, you will crash. */

Rect		GetRectDeviceRect(Rect globalRect);
			/* Find the rect of the greatest overlap device for the given global rect. */

WindowPtr	GetSomeKindOfWindow(PositionWndProcPtr whatKind, short windID, Ptr storage,
								Boolean vis, WindowPtr relatedWindow, WindowPtr behind,
								Boolean inColor, Rect sizeInfo, long refCon);
			/* Given a window positioning procedure pointer, a window ID and a window
			   pointer the window relates to, this function open a new window by either
			   a NewCWindow or a NewWindow call, depending on the value of inColor.  The
			   window will be opened invisible, independent of what the resource says.
			   Once the window is opened successfully, the positioning procedure is
			   called.  The positioning procedure is passed a pointer to the just-opened
			   invisible window,a pointer to the related window, and the sizeInfo rect.
			   The sizeInfo rect holds the minimum size in the upper-left point, and the
			   max size in the lower-left point.  It is up to the positioning procedure
			   to move the invisible window to the correct location on the correct device.
			   Once the positioning procedure returns, the window will be made visible if
			   so indicated by the resource. */

WindowPtr	GetStaggeredWindow(short id, Ptr storage, Boolean vis, WindowPtr relWindow,
							   WindowPtr behind, Boolean inColor, Rect sizeInfo, long refCon);
			/* Given a window ID and a window pointer the window relates to, this function
			   will stagger the window’s rectangle before showing it on the proper screen.
			   This follows the Apple Human Interface Guidelines for where to place a
			   staggered window on the screen.  If the window is not closely associated
			   with another window, pass a nil for the window pointer of the related
			   window.  If you pass a nil, the window is simply displayed where the
			   resource would indicate.  The function is also passed the sizeInfo rect, which
			   holds min and max size information for the window.  (See GetSomeKindOfWindow.) */

void		GetSystemInfo(void);
			/* This sets up some global variables for use by the utilities package and
			   your application.  If you call StandardInitialization, you don't need to
			   call this, as it will do it for you. */ 

TrapType	GetTrapType(short theTrap);
			/* Returns the type (OSType or ToolType) of the trap. It does this by checking
			   the bits of the trap word. */ 

Rect		GetWindowContentRect(WindowPtr window);
			/* Given a window pointer, return the global rectangle that encloses the
			   content area of the window. */

short		GetWindowCount(Boolean includeDAs, Boolean includeDLOGs, Boolean includeInvisibles);
			/* This procedure counts the number of windows in the application plane.  You have the
			   choices of also counting DAs, DLOGs, and invisible windows in this count. */

GDHandle	GetWindowDevice(WindowPtr window);
			/* Find the greatest overlap device for the given window. */

Rect		GetWindowDeviceRect(WindowPtr window);
			/* Given a window pointer, find the device that contains most of the window
			   and return the device's bounding rectangle. */

Rect		GetWindowDeviceRectNMB(WindowPtr window);
			/* Given a window pointer, find the device that contains most of the window
			   and return the device's bounding rectangle.  If this device is the main
			   device, then remove the menubar area from the rectangle. */

Rect		GetWindowStructureRect(WindowPtr window);
			/* This procedure is used to get the rectangle that surrounds the entire
			   structure of a window.  This is true whether or not the window is visible.
			   If the window is visible, then it is a simple matter of using the bounding
			   rectangle of the structure region.  If the window is invisible, then the
			   strucRgn is not correct.  To make it correct, then window has to be moved
			   way off the screen and then made visible.  This generates a valid strucRgn,
			   although it is valid for the position that is way off the screen.  It still
			   needs to be offset back into the original position.  Once the bounding
			   rectangle for the strucRgn is obtained, the window can then be hidden again
			   and moved back to its correct location.  Note that ShowHide is used,
			   instead of ShowWindow and HideWindow.  HideWindow can change the plane of
			   the window.  Also, ShowHide does not affect the hiliting of windows. */
  
void		GlobalToLocalRect(Rect *aRect);

void		InitToolBox(void);

Boolean		IsAppWindow(WindowPtr window);
			/* Returns TRUE if the windowKind of the window is greater than or equal to
			   userKind. If it is less, or the window is NIL, then return FALSE. */ 

Boolean		IsDAWindow(WindowPtr window);
			/* Returns TRUE if the windowKind of the window is less than zero. If not, or
			   the window is NIL, then return FALSE. */ 

Boolean		IsScrollBar(ControlHandle ctl);
			/* Returns TRUE if the control is a scrollbar. */

void		LocalToGlobalRect(Rect *aRect);

char		LockHandleHigh(Handle theHandle);
			/* Does a MoveHHi on the handle and then locks it.  Also, the original state
			   of the handle is returned, so you can keep it and set the handle back to it's
			   original state with a HSetState call. */

short		NumToolboxTraps(void);
			/* Determines the size of the Tool trap table. It does this by sampling a
			   couple of trap locations and seeing which, if any are Unimplemented. */ 

void		OutlineControl(ControlHandle button);

void 		OutlineDialogItem(DialogPtr dlgPtr, short item);

void		PositionRectInRect(Rect outerRect, Rect *innerRect, Fixed horzRatio, Fixed vertRatio);
			/* Given two rectangles, this routine positions the second within the first one
			   so that the it maintains the spacing specified the the horzRatio and vertRatio
			   parameters. In other words, to center an inner rectangle hoizontally, but
			   have its center be 1/3 from the top of the outer rectangle, call this
			   routine with horzRatio = FixRatio(1, 2), vertRatio = FixRatio(1, 3). */

void		PullApplicationToFront(void);
			
void		SelectButton(ControlHandle button);
			/* Given the button control handle, this will cause the button to look as if it
			   has been clicked in. This is nice to do for the user if they type return or
			   enter to select the default item. */

void		SetCheckOrRadioButton(DialogPtr dlgPtr, short itemNo, short state);

Rect		StaggerWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo);
			/* This algorithm for staggering windows does quite a good job.  It also is
			   quite gnarly.  Here's the deal:
			   There are pre-designated positions that we will try when positioning a
			   window.  These slots will be tried from the upper-left corner towards the
			   lower-right corner.  If there are other windows in that slot, then we will
			   consider that slot taken, and proceed to the next slot.  A slot is
			   determined to be taken by checking a point with a slop area.  This slop
			   area is diamond-shaped, not simply rectangular.  If there is no other
			   visible window with an upper-left corner within the slopt diamond, then
			   we are allowed to position our window there.
			   The above rule holds true unless this forces the window to be partly
			   off the screen.  If the window ends up partly off the screen, then we give
			   up and just put it in the first slot. */

void		StandardAbout(short appNameStringID);
			/* Shows a standard about box with the name of the application, its version
			   number, a copyright notice, and DTS credits. Most of this information is
			   taking from a standard DITL and the application’s 'vers' resource. The name
			   of the application is taken either from the 'STR ' resource passed in to
			   this routine, or from GetAppParms() if that resource doesn’t exist, or you
			   pass in -1. */ 

void		StandardInitialization(short callsToMoreMasters);
			/* Initializes “gInBackGround” to FALSE. Makes the following InitXXX calls:
			   InitGraf(), InitFonts(), InitWindows(), InitMenus(), TEInit(),
			   InitDialogs(), InitCursor(). Brings application to front with 3 EventAvail
			   calls. Calls SysEnvirons to initialize “gMac”. Calls TrapExists() to
			   initialize “gHasWaitNextEvent”. */ 
   
void		StandardMenuSetup(short MBARID, short AppleMenuID);
			/* Installs and draws the menus indicated by 'MBAR'(MBARID). Adds DA’s to the
			   menu indicated by AppleMenuID by calling AddResMenu. If the menuBar cannot
			   be created, the alert specified by rDeathAlert is displayed. */   

void		InsertHierMenus(MenuHandle menu);
			/* Look through the menu items for hierarchical references.  For each found,
			   insert the hierarchical menu, and then recursively search that menu for
			   hierarchical menus.  This function is called by StandardMenuSetup so that
			   all hierarchical menus are inserted at application startup time. */

void 		ToggleCheck(DialogPtr dlgPtr, short cChkItem);

Boolean		TrapExists(short theTrap);
				/* Returns TRUE if the trap exists (i.e., it’s callable without getting DS
				   error 12) */ 

Boolean		WhichControl(Point mouseLoc, long when, WindowPtr window, ControlHandle *ctlHit);
				/* Returns which visible control mouseLoc is within, independent of
				   the state of the control.  Scrollbars that are inactive are not
				   found by FindControl. */

void		ZoomToWindowDevice(WindowPtr window, short maxWidth, short maxHeight,
							   short zoomDir, Boolean front);



pascal Boolean	AlertFilter(DialogPtr dlg, EventRecord *event, short *item);
/* The alert filter makes sure that that the outline for the button gets
** redrawn.  This is important if balloon help is on, as the balloon window
** can overlap the outline of the button and leave a portion of it erased. */

pascal Boolean	KeyEquivFilter(DialogPtr dlg, EventRecord *event, short *item);
/* The key equivalent filter allows you to assign key equivalents to dialog
** items.  Each item can have as many key equivalents as you wish.  You can
** also specify the exact state of the modifiers that you will or won't allow.
** The key equivalent information is stored in the resource fork, so the
** key equivalents can be easily localized.
** This code expects the key equivalents to be in item #2, which is a StatText
** item that is located so the text is outside of the dialog.  This allows us
** to put key equivalent information in the resource fork, so the key
** equivalents are localizable.
**
** An example save changes before closing or quitting res source with
** keyEquiv info would look like:
**
** resource 'DITL' (rYesNoCancel, purgeable) {
**     {
**         {71, 315, 91, 367}, Button     { enabled, "Save" },
**         {0, -1000, 20, 2},  StaticText { disabled,
**             "=S190001,=s190001,=D190003,=d190003,=.190104,1B190004" },
**         {71, 80, 91, 162},  Button { enabled, "Don’t Save" },
**         {71, 244, 91, 302}, Button { enabled, "Cancel" },
**         {11, 78, 61, 366},  StaticText { disabled,
**             "Save changes to the document “^0” before ^1?" },
**         {11, 23, 43, 55},        Icon { disabled, 2 }
**     }
** };
**
** The document name would be the string for param #0.
** The text "closing" or "quitting" would be the string for param #1.
**
** The keyEquiv entry is item #2, which has a rect that pushes it out of the
** dialog.  The string info is interpreted as to what the key/modifier combo
** is, and what dialog item it relates to.
**
** A single key equiv entry is 8 characters.  Entries are separated by commas.
**
** If the first character of an entry is an =, then the next character is the 
** key.  If the first character isn't an =, then the first two characters are 
** the hex value of the key.  (Ex:  =S or =s for save, 1B for ESC.)
**
** If the key pressed is the same as the key value for any of the entries, then 
** the next two characters are the hex value for which modifiers to test.  This
** modifier test value is anded with the modifier.  The result is then compared 
** to the value of the next two hex digits.  If they are equal, then the 
** modifiers are correct, as well as the key.  If this is so, we have a winner.
**
** "=S190001,=s190001,=D190003,=d190003,=.190104,1B190004"
**
** The above string breaks down as follows:
** =S190001  =S  if event keypress is an S, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           00  all modifiers we are testing for should be false
**           01  if above is true, keypress maps to item # 1
** =s190001  Same as =S, but lowercase
** =D190001  Same as =S, but maps to item #3
** =d190001  Same as =D, but lowercase
** =.190104  =.  if event keypress is a period, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           01  controlKey/optionKey should be false, cmdKey should be true
**           04  if above is true, keypress maps to item # 4
** 1B190004  1B  if event keypress is an ESC, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           00  all modifiers we are testing for should be false
**           04  if above is true, keypress maps to item # 4
*/

void			OffsetControl(ControlHandle ctl, short dx, short dy);
/* This function is a convenient way to move a control a specified amount. */

void			DoDrawGrowIcon(WindowPtr window, Boolean horLine, Boolean verLine);
/* This function draws the grow icon for the window in the specified manner.  You
** can clip out the horizontal or vertical line that is also drawn along with
** the grow icon, or you can have them draw. */

void			DoDrawControls(WindowPtr window, Boolean scrollBarsOnly);
/* This function drawn all of the controls in a window, or just the scrollbar
** controls.  The reason for this function is that scrollbars are really
** tri-state, especially now with 7.0.  A scrollbar can be hilighted or not,
** or it can be drawn in a window that isn't the frontmost of the application
** plane.  DoDrawControls takes this third scrollbar state into consideration. */

void			DoDraw1Control(ControlHandle ctl, Boolean scrollBarsOnly);
/* This function is where the work for scrollbar/control drawing is actually
** done.  DoDrawControls calls this function for each control in a window. */

ControlHandle	GetPopupCtlHandle(DialogPtr theDialog, short itemNum);
/* GetPopupCtlHandle takes a dialog and its item number and (assuming it is a
** popup menu control) and returns the control handle for the popup. */

MenuHandle	GetPopupMenuHandle(ControlHandle popupCtl);
/* GetPopupMenuHandle takes a popup control and returns the menu handle from
** the control. */

short	GetPopupCtlValue(DialogPtr theDialog, short popItem);
/* GetPopupCtlValue returns value for the popup control. */

void	SetPopupCtlValue(DialogPtr theDialog, short popItem, short value);
/* SetPopupCtlValue makes value the new value for the popup control. */

short	SmartInsMenuItem(MenuHandle theMenu, StringPtr theText, short section, short where);
/* This is used to "intelligently" insert a menu item into a menu.  Pass it
** the menu to be modified, the text of the item being added, plus where the
** item is to be inserted.  The location to be inserted is described by two
** parameters:  section & where.
**
** section:  Indicates which group of menu items you wish to add an item to.
**           Menu item section 1 is all of the items before the first
**           dividing line.  Menu item section 2 is all items after the
**           first dividing line and before the second, and so on.  If you
**           have no dividing lines, you have just 1 section so pass in 1.
**
** where:    Indicates the item position relative to the section.  To add an
**           item such that it is the first item in a section, pass in a 1.
**           It will be added in front of the first item in the section.
**
**           NOTE:  You should never pass in a section or where parameter of 0.
**
** Negative values for "where" are magic.  If where = kMenuItemTxtInsert, then
** it inserts the item alphabetically into the section.  A where of 
** kMenuItemNumInsert works the same as kMenuItemTxtInsert, except it treats
** the strings are numbers for comparison purposes.  If you want to add the
** item to the end of a section, use kMenuItemSectionEnd.
**
** As a final goodie, SmartInsMenuItem returns the menu item # from the
** beginning of the menu, not section. */

short	CountMSections(MenuHandle theMenu);
/* Return the number of menu sections.  The number of sections is equal to the
** number of dividing lines + 1. */

short	FindMenuItem(MenuHandle theMenu, StringPtr cmpTxt);
/* Find the menu item number, given the text of the menu. */

OSErr	PersistFSSpec(PFSSpecPtr pfss);
/* Do what is necessary to get an FSSpec to persist when saved to disk.  The parID
** will still be valid, along with the file name.  The part that isn't valid is
** the vRefNum.  This function converts the FSSpec's vRefNum to a volume name, or
** converts the volume name into a vRefNum.  An extended FSSpec is used.  The
** extension is, logically enough, a volume name.  If the FSSpec's vRefNum is non-0,
** then it fills in the volume name for that vRefNum.  If the vRefNum is 0, it then
** uses the volume name to generate a vRefNum.
** Prior to saving a PFSSpec to disk, call PersistFSSpec.  It will fill in the
** volume name.  After having read a PFSSpec from disk, set the vRefNum to 0 and
** then call PersistFSSpec.  It will fill in the vRefNum that corresponds to the
** volume name. */

StringPtr	PathNameFromDirID(long DirID, short vRefNum, StringPtr str);
/* This function is straight out of tech note #238.  See this note for more info. */

void	InitQuickTime(void);
/* Call this to generically initialize QuickTime.  It sets two globals:
**     gQTVersion					QuickTime version (0 means not available).
**     gMovieControllerComponent	QuickTime movie controller component reference. */

RgnHandle	LocalScreenDepthRegion(short depth);
/* This function serves the same purpose as ScreenDepthRegion(), except that it localizes the
** region to the current port.  If the global gScreenPort is not nil, then it localizes to that
** port.  The reason for this is that the currentl port may be an offscreen port.  If it is
** offscreen, then it doesn't have a direct relationship to the screen. */

void	MoveStyledControl(ControlHandle ctl, short xloc, short yloc);
void	SizeStyledControl(ControlHandle ctl, short xsize, short ysize);
void	SetStyledCtlValue(ControlHandle ctl, short value);
void	ShowStyledControl(ControlHandle ctl);
void	HideStyledControl(ControlHandle ctl);
void	UseControlStyle(ControlHandle ctl);
void	SetStyledCTitle(ControlHandle ctl, StringPtr title);
short	GetControlID(ControlHandle ctl);
Boolean	GetControlStyle(ControlHandle ctl, ControlStyleInfoPtr cinfo);
OSErr	SetControlStyle(ControlHandle ctl, ControlStyleInfoPtr cinfo);
void	SetTrackControlProc(ControlHandle ctl, TrackControlProcPtr proc);
Boolean	ControlKeyEquiv(WindowPtr window, EventRecord *event, ControlHandle *retCtl, StringPtr defaultEquivs);
	/* These functions are for extending the functionality of controls.  The structure
	** ControlStyleInfo is appended to a control, immediately after the title field.
	** This is valid, as the only control manager function that changes the size of a
	** control is SetCTitle.  (The function SetStyledCTitle is used instead to maintain
	** the control style info.) */



#ifdef __cplusplus
}
#endif

#endif

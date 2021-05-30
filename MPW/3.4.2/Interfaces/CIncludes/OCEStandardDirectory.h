/*
 	File:		OCEStandardDirectory.h
 
 	Contains:	Apple Open Collaboration Environment Standard Directory Interfaces.
 
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

#ifndef __OCESTANDARDDIRECTORY__
#define __OCESTANDARDDIRECTORY__

#ifndef REZ

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

#ifndef __ICONS__
#include <Icons.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

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


enum {
	gestaltSDPStandardDirectoryVersion = 'sdvr',
	gestaltSDPFindVersion		= 'dfnd',
	gestaltSDPPromptVersion		= 'prpv'
};

#define kSDPNewPanel 100
#define kSDPGetNewPanel 101
#define kSDPDisposePanel 102
#define kSDPHidePanel 103
#define kSDPShowPanel 104
#define kSDPEnablePanel 105
#define kSDPUpdatePanel 106
#define kSDPMovePanel 107
#define kSDPSizePanel 108
#define kSDPOpenSelectedItem 109
#define kSDPGetPanelSelectionState 110
#define kSDPGetPanelSelection 111
#define kSDPSetPath 112
#define kSDPPanelEvent 113
#define kSDPGetPanelSelectionSize 114
#define kSDPSetIdentity 115
#define kSDPSelectString 116
#define kSDPGetPathLength 117
#define kSDPGetPath 118
#define kSDPSetFocus 119
#define kSDPSetPanelBalloonHelp 120
#define kSDPInstallPanelBusyProc 121
#define kSDPPromptForID 904
#define kSDPNewFindPanel 2300
#define kSDPDisposeFindPanel 2301
#define kSDPStartFind 2302
#define kSDPStopFind 2303
#define kSDPFindPanelEvent 2304
#define kSDPDrawFindPanel 2305
#define kSDPShowFindPanel 2306
#define kSDPHideFindPanel 2307
#define kSDPMoveFindPanel 2308
#define kSDPEnableFindPanel 2309
#define kSDPSetFindPanelFocus 2310
#define kSDPGetFindPanelState 2311
#define kSDPGetFindPanelSelectionSize 2312
#define kSDPGetFindPanelSelection 2313
#define kSDPSetFindPanelBalloonHelp 2314
#define kSDPSetFindIdentity 2315
#define kSDPInstallFindPanelBusyProc 2316
#define kSDPGetIconByType 1024
#define kSDPGetDSSpecIcon 1025
#define kSDPGetCategories 1026
#define kSDPGetCategoryTypes 1027
#define kSDPResolveAliasFile 3700
#define kSDPResolveAliasDSSpec 3701
#define kSDPRepairPersonalDirectory 6700
#endif /* REZ */
#define genericDirectoryIconResource -16721
#define genericLockedDirectoryIconResource -16716
#define genericRecordIconResource -16722
#define genericAttributeIconResource -16723
#define genericTemplateIconResource -16746
#define directoryFolderIconResource -16720
#define lockedDirectoryFolderIconResource -16719
#define personalDirectoryIconResource -16718
#define directoriesIconResource -16717
#define preferredPersonalDirectoryIconResource -16724
#define kFirstSpinnerIcon -16745
#define kLastSpinnerIcon -16738
#define kSDPPanelResourceType 'panl'
#define kSDPFindPanelResourceType 'find'
#define kStandardFindLayout -16700
#ifndef REZ
/* Prompt For Identity structures */
enum {
	kSDPGuestBit,
	kSDPSpecificIdentityBit,
	kSDPLocalIdentityBit
};

/* Values of SDPIdentityKind */
enum {
	kSDPGuestMask				= 1 << kSDPGuestBit,
	kSDPSpecificIdentityMask	= 1 << kSDPSpecificIdentityBit,
	kSDPLocalIdentityMask		= 1 << kSDPLocalIdentityBit
};

typedef unsigned short SDPIdentityKind;


enum {
	kSDPSuggestionOnly,
	kSDPRestrictToDirectory,
	kSDPRestrictToRecord
};

typedef unsigned short SDPLoginFilterKind;

/* Panel Structures */
/*
While the panel is in operation, four selection states may exist.
	1) kSDPNothingSelected means nothing is selected.
	2) kContainSelected means a volume, folder, catalog, dnode, or PAB is selected.
	3) kSDPLockedContainerSelected means one of the above, but no access privledges.
	4) kSDPRecordSelected means that a record is currently selected.
*/
/* Values of SDPSelectionState */

enum {
	kSDPNothingSelected,
	kSDPLockedContainerSelected,
	kSDPContainerSelected,
	kSDPRecordSelected,
	kSDPRecordAliasSelected,
	kSDPContainerAliasSelected
};

typedef unsigned short SDPSelectionState;

/*
This type informs the caller of the action the user took, either as the result
of an event (as returned by SDPPanelEvent) or when SDPOpenSelectedItem is called.

kSDPProcessed means that the event (or call to SDPOpenSelectedItem) resulted in no
state change.

kSDPSelectedAnItem indicates that the user wants to select the currently-hilited
record. This is returned, for example, when a user double-clicks on a record.

kSDPChangedSelection implies that the user clicked on a new item (which may mean
that no item is selected).
*/
/* Values of SDPPanelState */

enum {
	kSDPProcessed,
	kSDPSelectedAnItem,
	kSDPChangedSelection
};

typedef unsigned short SDPPanelState;

/*
Your application may read any of the fields in a SDPPanelRecord, but it should
use the appropriate routines to make changes to the records with the exception
of the refCon field which your application may read or write at will.  Private
information follows the SDPPanelRecord, so the handle must not be re-sized.
*/
struct SDPPanelRecord {
	Rect							bounds;
	Boolean							visible;
	Boolean							enabled;
	Boolean							focused;
	Byte							padByte;
	AuthIdentity					identity;
	long							refCon;
	Rect							listRect;
	Rect							popupRect;
	short							numberOfRows;
	short							rowHeight;
	Boolean							pabMode;
	Boolean							filler1;
};

typedef struct SDPPanelRecord SDPPanelRecord;

typedef SDPPanelRecord *SDPPanelPtr, **SDPPanelHandle;

typedef pascal void (*PanelBusyProcPtr)(SDPPanelHandle Panel, Boolean busy);

#if GENERATINGCFM
typedef UniversalProcPtr PanelBusyUPP;
#else
typedef PanelBusyProcPtr PanelBusyUPP;
#endif

enum {
	uppPanelBusyProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SDPPanelHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define NewPanelBusyProc(userRoutine)		\
		(PanelBusyUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPanelBusyProcInfo, GetCurrentArchitecture())
#else
#define NewPanelBusyProc(userRoutine)		\
		((PanelBusyUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallPanelBusyProc(userRoutine, Panel, busy)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPanelBusyProcInfo, (Panel), (busy))
#else
#define CallPanelBusyProc(userRoutine, Panel, busy)		\
		(*(userRoutine))((Panel), (busy))
#endif

typedef PanelBusyUPP PanelBusyProc;

/* Find Panel Structures */

enum {
	kSDPItemIsSelectedBit,
	kSDPFindTextExistsBit
};

/* Values of SDPFindPanelState */
enum {
	kSDPItemIsSelectedMask		= 1 << kSDPItemIsSelectedBit,
	kSDPFindTextExistsMask		= 1 << kSDPFindTextExistsBit
};

typedef unsigned short SDPFindPanelState;

/* Values of SDPFindPanelFocus */

enum {
	kSDPFindPanelNoFocus,
	kSDPFindPanelListHasFocus,
	kSDPFindPanelTextHasFocus
};

typedef unsigned short SDPFindPanelFocus;

struct SDPFindPanelRecord {
	Point							upperLeft;
	Boolean							visible;
	Boolean							enabled;
	Boolean							nowFinding;
	Byte							padByte;
	SDPFindPanelFocus				currentFocus;
	AuthIdentity					identity;
	short							simultaneousSearchCount;
	long							refCon;
};

typedef struct SDPFindPanelRecord SDPFindPanelRecord;

typedef SDPFindPanelRecord *SDPFindPanelPtr, **SDPFindPanelHandle;

/* Values of SDPFindPanelResult */

enum {
	kSDPSelectedAFindItem,
	kSDPFindSelectionChanged,
	kSDPFindCompleted,
	kSDPTextStateChanged,
	kSDPFocusChanged,
	kSDPSelectionAndFocusChanged,
	kSDPMenuChanged,
	kSDPSelectionAndMenuChanged,
	kSDPProcessedFind
};

typedef unsigned short SDPFindPanelResult;

typedef PackedPathNamePtr *PackedRStringListHandle;

typedef PackedDSSpec **PackedDSSpecHandle;

typedef pascal void (*FindPanelBusyProcPtr)(SDPFindPanelHandle findPanel, Boolean busy);

#if GENERATINGCFM
typedef UniversalProcPtr FindPanelBusyUPP;
#else
typedef FindPanelBusyProcPtr FindPanelBusyUPP;
#endif

enum {
	uppFindPanelBusyProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SDPFindPanelHandle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define NewFindPanelBusyProc(userRoutine)		\
		(FindPanelBusyUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFindPanelBusyProcInfo, GetCurrentArchitecture())
#else
#define NewFindPanelBusyProc(userRoutine)		\
		((FindPanelBusyUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallFindPanelBusyProc(userRoutine, findPanel, busy)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFindPanelBusyProcInfo, (findPanel), (busy))
#else
#define CallFindPanelBusyProc(userRoutine, findPanel, busy)		\
		(*(userRoutine))((findPanel), (busy))
#endif

typedef FindPanelBusyUPP FindPanelBusyProc;

/* Prompt For Identity Routines */
extern pascal OSErr SDPPromptForID(AuthIdentity *id, ConstStr255Param guestPrompt, ConstStr255Param specificIDPrompt, ConstStr255Param localIDPrompt, const RString *recordType, SDPIdentityKind permittedKinds, SDPIdentityKind *selectedKind, const RecordID *loginFilter, SDPLoginFilterKind filterKind)
 FOURWORDINLINE(0x203C, 16, 904, 0xAA5D);
/*
SDPNewPanel creates a new panel. You supply the window in which the panel
is to live, the bounds for the panel (which includes both the menu and the list),
whether or not the panel is to be initially visible, the initial RLI (nil for
catalogs and volumes), the types of records that will be shown (only a single
(non-nil) type which may contain wildcards), the identity by which to browse
(for access control reasons), and a refCon which is  available to the caller.
*/
extern pascal OSErr SDPNewPanel(SDPPanelHandle *newPanel, WindowPtr window, const Rect *bounds, Boolean visible, Boolean enabled, const PackedRLI *initialRLI, const RStringPtr *typesList, unsigned long typeCount, AuthIdentity identity, DirEnumChoices enumFlags, DirMatchWith matchTypeHow, long refCon)
 FOURWORDINLINE(0x203C, 21, 100, 0xAA5D);
/*
SDPSetIdentity Sets the identity used for browsing.  NOTE: This call is likely to go
away if the new authentication scheme works.
*/
extern pascal OSErr SDPSetIdentity(SDPPanelHandle panel, AuthIdentity identity)
 FOURWORDINLINE(0x203C, 4, 115, 0xAA5D);
/*
SDPGetNewPanel is similar to SDPNewPanel above, except it takes a resource id of a
'panl' resource.
*/
extern pascal OSErr SDPGetNewPanel(SDPPanelHandle *newPanel, short resourceID, WindowPtr window, const PackedRLI *initialRLI, AuthIdentity identity)
 FOURWORDINLINE(0x203C, 9, 101, 0xAA5D);
/*
Call this when you're completely done with a panel. It deallocates all of the
associated data structures.
*/
extern pascal OSErr SDPDisposePanel(SDPPanelHandle panel)
 FOURWORDINLINE(0x203C, 2, 102, 0xAA5D);
/*
If the panel is visible, it makes it invisible by hiding the menu, turning off
drawing of the list, and erasing and  invaling the list's rectangle.
*/
extern pascal OSErr SDPHidePanel(SDPPanelHandle panel)
 FOURWORDINLINE(0x203C, 2, 103, 0xAA5D);
/* If the panel is invisible, it makes it visible and draws it. */
extern pascal OSErr SDPShowPanel(SDPPanelHandle panel)
 FOURWORDINLINE(0x203C, 2, 104, 0xAA5D);
/* Disables the list and menu so that it won't accept any commands. */
extern pascal OSErr SDPEnablePanel(SDPPanelHandle panel, Boolean enable)
 FOURWORDINLINE(0x203C, 3, 105, 0xAA5D);
/*
Move the upper-left-hand corner of the panel to (h,v), given in local coordinates of
the panel's window.
*/
extern pascal OSErr SDPMovePanel(SDPPanelHandle panel, short h, short v)
 FOURWORDINLINE(0x203C, 4, 107, 0xAA5D);
/*
Resizes the panel to have the given width and height (keeping the upper-left-hand
corner in a fixed position).
*/
extern pascal OSErr SDPSizePanel(SDPPanelHandle panel, short width, short height)
 FOURWORDINLINE(0x203C, 4, 108, 0xAA5D);
/*
This routine simulates a double-click on the selected item (if there is no selected
item, then it does nothing), and it returns the result of that "double-click" via the
whatHappened parameter. If a container is selected, then that container will be
opened and kMovedDownTheHierarchy is returned. If, however, the user is at the lowest
level in the hierarchy, then kSDPSelectedAnItem is returned.
*/
extern pascal OSErr SDPOpenSelectedItem(SDPPanelHandle panel, SDPPanelState *whatHappened)
 FOURWORDINLINE(0x203C, 4, 109, 0xAA5D);
/*
Returns whether a record is selected, something else is selected, or nothing is
selected.
*/
extern pascal OSErr SDPGetPanelSelectionState(SDPPanelHandle panel, SDPSelectionState *itsState)
 FOURWORDINLINE(0x203C, 4, 110, 0xAA5D);
/*
Returns the size of the currently-selected DSSpec, or zero if a record is
not selected.  It is safe to do a NewPtr (SDPGetPanelSelectionSize (...))
*/
extern pascal OSErr SDPGetPanelSelectionSize(SDPPanelHandle panel, unsigned short *dsSpecSize)
 FOURWORDINLINE(0x203C, 4, 114, 0xAA5D);
/*
Returns the currently-selected DSSpec, or a zero-lengthed
DSSpec if a record is not selected. It is assumed that the selection
buffer allocated is large enough.
*/
extern pascal OSErr SDPGetPanelSelection(SDPPanelHandle panel, PackedDSSpec *selection)
 FOURWORDINLINE(0x203C, 4, 111, 0xAA5D);
/*
Forces browsing to the specified RLI. If prli is the current RLI, then it does
nothing.
*/
extern pascal OSErr SDPSetPath(SDPPanelHandle panel, const PackedRLI *prli)
 FOURWORDINLINE(0x203C, 4, 112, 0xAA5D);
/*
This is the main driver for the panel.  You should pass all events to SDPPanelEvent
including NULL events.  If you have more than 1 panel, you will need to
call SDPPanelEvent for each panel.  NOTE:  For Update Events you will also need to call
SDPUpdatePanel as described below.
*/
extern pascal OSErr SDPPanelEvent(SDPPanelHandle panel, const EventRecord *theEvent, SDPPanelState *whatHappened)
 FOURWORDINLINE(0x203C, 6, 113, 0xAA5D);
/*
SDPUpdatePanel should be called in response to an update event.  Generally you will
have first called BeginUpdate, and pass the windows visRgn as theRgn.  If NULL
is passed for theRgn the entire panel is re-drawn.  NOTE:  Drawing is not cliped to
theRgn, if this is desired, you must first call SetClip.
*/
extern pascal OSErr SDPUpdatePanel(SDPPanelHandle panel, RgnHandle theRgn)
 FOURWORDINLINE(0x203C, 4, 106, 0xAA5D);
/*
SDPSelectString scrolls and selects the closest matching string at the current
level.  This is the same behavior as if the user typed in the given string.
*/
extern pascal OSErr SDPSelectString(SDPPanelHandle panel, const RString *name)
 FOURWORDINLINE(0x203C, 4, 116, 0xAA5D);
/*
SDPGetPathLength returns the length in bytes required to hold the current path name
in RLI format.  This corresponds to the path name in the popup menu.
*/
extern pascal OSErr SDPGetPathLength(SDPPanelHandle panel, unsigned short *pathNameLength)
 FOURWORDINLINE(0x203C, 4, 117, 0xAA5D);
/* SDPGetPath returns the current rli. */
extern pascal OSErr SDPGetPath(SDPPanelHandle panel, PackedRLI *prli, short *dsRefNum)
 FOURWORDINLINE(0x203C, 6, 118, 0xAA5D);
/*
SDPSetFocus will draw the focus rectangle or erase the focus rectangle depending upon
the focus boolean.
*/
extern pascal OSErr SDPSetFocus(SDPPanelHandle panel, Boolean focus)
 FOURWORDINLINE(0x203C, 3, 119, 0xAA5D);
/*
SDPSetPanelBalloonHelp allows clients to specify a STR# resource id to use for 
balloon help.  Balloon help is unavailable until this call is made.
*/
extern pascal OSErr SDPSetPanelBalloonHelp(SDPPanelHandle panel, short balloonHelpID)
 FOURWORDINLINE(0x203C, 3, 120, 0xAA5D);
/*
SDPInstallPanelBusyProc allows clients to install a CB that will be called while
the panel is aynchronously busy.
*/
extern pascal OSErr SDPInstallPanelBusyProc(SDPPanelHandle panel, PanelBusyProc busyProc)
 FOURWORDINLINE(0x203C, 4, 121, 0xAA5D);
extern pascal OSErr SDPNewFindPanel(SDPFindPanelHandle *newPanel, WindowPtr window, Point upperLeft, short layoutResourceID, Boolean visible, Boolean enabled, const RStringPtr *typesList, long typeCount, DirMatchWith matchTypeHow, AuthIdentity identity, short simultaneousSearchCount, SDPFindPanelFocus initialFocus, long refCon)
 FOURWORDINLINE(0x203C, 20, 2300, 0xAA5D);
extern pascal OSErr SDPDisposeFindPanel(SDPFindPanelHandle findPanel)
 FOURWORDINLINE(0x203C, 2, 2301, 0xAA5D);
extern pascal OSErr SDPStartFind(SDPFindPanelHandle findPanel)
 FOURWORDINLINE(0x203C, 2, 2302, 0xAA5D);
extern pascal OSErr SDPStopFind(SDPFindPanelHandle findPanel)
 FOURWORDINLINE(0x203C, 2, 2303, 0xAA5D);
extern pascal OSErr SDPFindPanelEvent(SDPFindPanelHandle findPanel, const EventRecord *event, SDPFindPanelResult *whatHappened)
 FOURWORDINLINE(0x203C, 6, 2304, 0xAA5D);
extern pascal OSErr SDPUpdateFindPanel(SDPFindPanelHandle findPanel, RgnHandle theRgn)
 FOURWORDINLINE(0x203C, 4, 2305, 0xAA5D);
extern pascal OSErr SDPShowFindPanel(SDPFindPanelHandle findPanel)
 FOURWORDINLINE(0x203C, 2, 2306, 0xAA5D);
extern pascal OSErr SDPHideFindPanel(SDPFindPanelHandle findPanel)
 FOURWORDINLINE(0x203C, 2, 2307, 0xAA5D);
extern pascal OSErr SDPMoveFindPanel(SDPFindPanelHandle findPanel, short h, short v)
 FOURWORDINLINE(0x203C, 4, 2308, 0xAA5D);
extern pascal OSErr SDPEnableFindPanel(SDPFindPanelHandle findPanel, Boolean enabled)
 FOURWORDINLINE(0x203C, 3, 2309, 0xAA5D);
extern pascal OSErr SDPSetFindPanelFocus(SDPFindPanelHandle findPanel, SDPFindPanelFocus newFocus)
 FOURWORDINLINE(0x203C, 3, 2310, 0xAA5D);
extern pascal OSErr SDPGetFindPanelState(SDPFindPanelHandle findPanel, SDPFindPanelState *itsState)
 FOURWORDINLINE(0x203C, 4, 2311, 0xAA5D);
extern pascal OSErr SDPGetFindPanelSelectionSize(SDPFindPanelHandle findPanel, unsigned short *size)
 FOURWORDINLINE(0x203C, 4, 2312, 0xAA5D);
extern pascal OSErr SDPGetFindPanelSelection(SDPFindPanelHandle findPanel, PackedDSSpec *selection)
 FOURWORDINLINE(0x203C, 4, 2313, 0xAA5D);
extern pascal OSErr SDPSetFindPanelBalloonHelp(SDPFindPanelHandle findPanel, short balloonHelpID)
 FOURWORDINLINE(0x203C, 3, 2314, 0xAA5D);
extern pascal OSErr SDPSetFindIdentity(SDPFindPanelHandle findPanel, AuthIdentity identity)
 FOURWORDINLINE(0x203C, 4, 2315, 0xAA5D);
extern pascal OSErr SDPInstallFindPanelBusyProc(SDPFindPanelHandle findPanel, FindPanelBusyProc busyProc)
 FOURWORDINLINE(0x203C, 4, 2316, 0xAA5D);
extern pascal OSErr SDPGetIconByType(const RString *recordType, IconSelectorValue whichIcons, Handle *iconSuite)
 THREEWORDINLINE(0x303C, 1024, 0xAA5C);
extern pascal OSErr SDPGetDSSpecIcon(const PackedDSSpec *packedDSSpec, IconSelectorValue whichIcons, Handle *iconSuite)
 THREEWORDINLINE(0x303C, 1025, 0xAA5C);
extern pascal OSErr SDPGetCategories(PackedRStringListHandle *categories, PackedRStringListHandle *displayNames)
 THREEWORDINLINE(0x303C, 1026, 0xAA5C);
extern pascal OSErr SDPGetCategoryTypes(const RString *category, PackedRStringListHandle *types)
 THREEWORDINLINE(0x303C, 1027, 0xAA5C);
extern pascal OSErr SDPResolveAliasFile(FSSpecPtr fileSpec, PackedDSSpecHandle resolvedDSSpec, AuthIdentity identity, Boolean mayPromptUser)
 FOURWORDINLINE(0x203C, 7, 3700, 0xAA5D);
extern pascal OSErr SDPResolveAliasDSSpec(PackedDSSpecHandle theAliasDSSpec, AuthIdentity identity, Boolean mayPromptUser)
 FOURWORDINLINE(0x203C, 5, 3701, 0xAA5D);
extern pascal OSErr SDPRepairPersonalDirectory(FSSpec *pd, Boolean showProgress)
 FOURWORDINLINE(0x203C, 3, 6700, 0xAA5D);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* REZ */
#endif /* __OCESTANDARDDIRECTORY__ */

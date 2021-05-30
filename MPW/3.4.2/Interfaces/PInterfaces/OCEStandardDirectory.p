{
 	File:		OCEStandardDirectory.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OCEStandardDirectory;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OCESTANDARDDIRECTORY__}
{$SETC __OCESTANDARDDIRECTORY__ := 1}

{$I+}
{$SETC OCEStandardDirectoryIncludes := UsingIncludes}
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

{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Controls.p													}
{		Menus.p													}

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

CONST
	gestaltSDPStandardDirectoryVersion = 'sdvr';
	gestaltSDPFindVersion		= 'dfnd';
	gestaltSDPPromptVersion		= 'prpv';

	genericDirectoryIconResource = -16721;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	genericLockedDirectoryIconResource = -16716;				{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	genericRecordIconResource	= -16722;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	genericAttributeIconResource = -16723;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	genericTemplateIconResource	= -16746;						{ icl8, icl4, ICN#, ics#, ics4, ics8 }

{ standard icon suites }
	directoryFolderIconResource	= -16720;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	lockedDirectoryFolderIconResource = -16719;					{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	personalDirectoryIconResource = -16718;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	directoriesIconResource		= -16717;						{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }
	preferredPersonalDirectoryIconResource = -16724;			{ icl8, icl4, ICN#, ics#, ics4, ics8, sicn  }

{ icon IDs for spinning arrows }
	kFirstSpinnerIcon			= -16745;
	kLastSpinnerIcon			= -16738;

{ resource types }
	kSDPPanelResourceType		= 'panl';
	kSDPFindPanelResourceType	= 'find';

{ Standard FindPanel resource }
	kStandardFindLayout			= -16700;

{ Prompt For Identity structures }
	kSDPGuestBit				= 0;
	kSDPSpecificIdentityBit		= 1;
	kSDPLocalIdentityBit		= 2;

{ Values of SDPIdentityKind }
	kSDPGuestMask				= 1 * (2**(kSDPGuestBit));
	kSDPSpecificIdentityMask	= 1 * (2**(kSDPSpecificIdentityBit));
	kSDPLocalIdentityMask		= 1 * (2**(kSDPLocalIdentityBit));

	
TYPE
	SDPIdentityKind = INTEGER;


CONST
	kSDPSuggestionOnly			= 0;
	kSDPRestrictToDirectory		= 1;
	kSDPRestrictToRecord		= 2;

	
TYPE
	SDPLoginFilterKind = INTEGER;

{ Panel Structures }
{
While the panel is in operation, four selection states may exist.
	1) kSDPNothingSelected means nothing is selected.
	2) kContainSelected means a volume, folder, catalog, dnode, or PAB is selected.
	3) kSDPLockedContainerSelected means one of the above, but no access privledges.
	4) kSDPRecordSelected means that a record is currently selected.
}
{ Values of SDPSelectionState }

CONST
	kSDPNothingSelected			= 0;
	kSDPLockedContainerSelected	= 1;
	kSDPContainerSelected		= 2;
	kSDPRecordSelected			= 3;
	kSDPRecordAliasSelected		= 4;
	kSDPContainerAliasSelected	= 5;

	
TYPE
	SDPSelectionState = INTEGER;

{
This type informs the caller of the action the user took, either as the result
of an event (as returned by SDPPanelEvent) or when SDPOpenSelectedItem is called.

kSDPProcessed means that the event (or call to SDPOpenSelectedItem) resulted in no
state change.

kSDPSelectedAnItem indicates that the user wants to select the currently-hilited
record. This is returned, for example, when a user double-clicks on a record.

kSDPChangedSelection implies that the user clicked on a new item (which may mean
that no item is selected).
}
{ Values of SDPPanelState }

CONST
	kSDPProcessed				= 0;
	kSDPSelectedAnItem			= 1;
	kSDPChangedSelection		= 2;

	
TYPE
	SDPPanelState = INTEGER;

{
Your application may read any of the fields in a SDPPanelRecord, but it should
use the appropriate routines to make changes to the records with the exception
of the refCon field which your application may read or write at will.  Private
information follows the SDPPanelRecord, so the handle must not be re-sized.
}
	SDPPanelRecord = RECORD
		bounds:					Rect;
		visible:				BOOLEAN;
		enabled:				BOOLEAN;
		focused:				BOOLEAN;
		padByte:				SInt8; (* Byte *)
		identity:				AuthIdentity;
		refCon:					LONGINT;
		listRect:				Rect;
		popupRect:				Rect;
		numberOfRows:			INTEGER;
		rowHeight:				INTEGER;
		pabMode:				BOOLEAN;
		filler1:				BOOLEAN;
	END;

	SDPPanelPtr = ^SDPPanelRecord;
	SDPPanelHandle = ^SDPPanelPtr;

	PanelBusyProcPtr = ProcPtr;  { PROCEDURE PanelBusy(Panel: SDPPanelHandle; busy: BOOLEAN); }
	PanelBusyUPP = UniversalProcPtr;

CONST
	uppPanelBusyProcInfo = $000001C0; { PROCEDURE (4 byte param, 1 byte param); }

FUNCTION NewPanelBusyProc(userRoutine: PanelBusyProcPtr): PanelBusyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallPanelBusyProc(Panel: SDPPanelHandle; busy: BOOLEAN; userRoutine: PanelBusyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	PanelBusyProc = PanelBusyUPP;

{ Find Panel Structures }

CONST
	kSDPItemIsSelectedBit		= 0;
	kSDPFindTextExistsBit		= 1;

{ Values of SDPFindPanelState }
	kSDPItemIsSelectedMask		= 1 * (2**(kSDPItemIsSelectedBit));
	kSDPFindTextExistsMask		= 1 * (2**(kSDPFindTextExistsBit));

	
TYPE
	SDPFindPanelState = INTEGER;

{ Values of SDPFindPanelFocus }

CONST
	kSDPFindPanelNoFocus		= 0;
	kSDPFindPanelListHasFocus	= 1;
	kSDPFindPanelTextHasFocus	= 2;

	
TYPE
	SDPFindPanelFocus = INTEGER;

	SDPFindPanelRecord = RECORD
		upperLeft:				Point;
		visible:				BOOLEAN;
		enabled:				BOOLEAN;
		nowFinding:				BOOLEAN;
		padByte:				SInt8; (* Byte *)
		currentFocus:			SDPFindPanelFocus;
		identity:				AuthIdentity;
		simultaneousSearchCount: INTEGER;
		refCon:					LONGINT;
	END;

	SDPFindPanelPtr = ^SDPFindPanelRecord;
	SDPFindPanelHandle = ^SDPFindPanelPtr;

{ Values of SDPFindPanelResult }

CONST
	kSDPSelectedAFindItem		= 0;
	kSDPFindSelectionChanged	= 1;
	kSDPFindCompleted			= 2;
	kSDPTextStateChanged		= 3;
	kSDPFocusChanged			= 4;
	kSDPSelectionAndFocusChanged = 5;
	kSDPMenuChanged				= 6;
	kSDPSelectionAndMenuChanged	= 7;
	kSDPProcessedFind			= 8;

	
TYPE
	SDPFindPanelResult = INTEGER;

	PackedRStringListHandle = ^PackedPathNamePtr;

	PackedDSSpecHandle = ^PackedDSSpecPtr;

	FindPanelBusyProcPtr = ProcPtr;  { PROCEDURE FindPanelBusy(findPanel: SDPFindPanelHandle; busy: BOOLEAN); }
	FindPanelBusyUPP = UniversalProcPtr;

CONST
	uppFindPanelBusyProcInfo = $000001C0; { PROCEDURE (4 byte param, 1 byte param); }

FUNCTION NewFindPanelBusyProc(userRoutine: FindPanelBusyProcPtr): FindPanelBusyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallFindPanelBusyProc(findPanel: SDPFindPanelHandle; busy: BOOLEAN; userRoutine: FindPanelBusyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	FindPanelBusyProc = FindPanelBusyUPP;

{ Prompt For Identity Routines }

FUNCTION SDPPromptForID(VAR id: AuthIdentity; guestPrompt: ConstStr255Param; specificIDPrompt: ConstStr255Param; localIDPrompt: ConstStr255Param; {CONST}VAR recordType: RString; permittedKinds: SDPIdentityKind; VAR selectedKind: SDPIdentityKind; {CONST}VAR loginFilter: RecordID; filterKind: SDPLoginFilterKind): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 16, 904, $AA5D;
	{$ENDC}
{
SDPNewPanel creates a new panel. You supply the window in which the panel
is to live, the bounds for the panel (which includes both the menu and the list),
whether or not the panel is to be initially visible, the initial RLI (nil for
catalogs and volumes), the types of records that will be shown (only a single
(non-nil) type which may contain wildcards), the identity by which to browse
(for access control reasons), and a refCon which is  available to the caller.
}
FUNCTION SDPNewPanel(VAR newPanel: SDPPanelHandle; window: WindowPtr; {CONST}VAR bounds: Rect; visible: BOOLEAN; enabled: BOOLEAN; {CONST}VAR initialRLI: PackedRLI; {CONST}VAR typesList: RStringPtr; typeCount: LONGINT; identity: AuthIdentity; enumFlags: DirEnumChoices; matchTypeHow: ByteParameter; refCon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 21, 100, $AA5D;
	{$ENDC}
{
SDPSetIdentity Sets the identity used for browsing.  NOTE: This call is likely to go
away if the new authentication scheme works.
}
FUNCTION SDPSetIdentity(panel: SDPPanelHandle; identity: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 115, $AA5D;
	{$ENDC}
{
SDPGetNewPanel is similar to SDPNewPanel above, except it takes a resource id of a
'panl' resource.
}
FUNCTION SDPGetNewPanel(VAR newPanel: SDPPanelHandle; resourceID: INTEGER; window: WindowPtr; {CONST}VAR initialRLI: PackedRLI; identity: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 9, 101, $AA5D;
	{$ENDC}
{
Call this when you're completely done with a panel. It deallocates all of the
associated data structures.
}
FUNCTION SDPDisposePanel(panel: SDPPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 102, $AA5D;
	{$ENDC}
{
If the panel is visible, it makes it invisible by hiding the menu, turning off
drawing of the list, and erasing and  invaling the list's rectangle.
}
FUNCTION SDPHidePanel(panel: SDPPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 103, $AA5D;
	{$ENDC}
{ If the panel is invisible, it makes it visible and draws it. }
FUNCTION SDPShowPanel(panel: SDPPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 104, $AA5D;
	{$ENDC}
{ Disables the list and menu so that it won't accept any commands. }
FUNCTION SDPEnablePanel(panel: SDPPanelHandle; enable: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 105, $AA5D;
	{$ENDC}
{
Move the upper-left-hand corner of the panel to (h,v), given in local coordinates of
the panel's window.
}
FUNCTION SDPMovePanel(panel: SDPPanelHandle; h: INTEGER; v: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 107, $AA5D;
	{$ENDC}
{
Resizes the panel to have the given width and height (keeping the upper-left-hand
corner in a fixed position).
}
FUNCTION SDPSizePanel(panel: SDPPanelHandle; width: INTEGER; height: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 108, $AA5D;
	{$ENDC}
{
This routine simulates a double-click on the selected item (if there is no selected
item, then it does nothing), and it returns the result of that "double-click" via the
whatHappened parameter. If a container is selected, then that container will be
opened and kMovedDownTheHierarchy is returned. If, however, the user is at the lowest
level in the hierarchy, then kSDPSelectedAnItem is returned.
}
FUNCTION SDPOpenSelectedItem(panel: SDPPanelHandle; VAR whatHappened: SDPPanelState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 109, $AA5D;
	{$ENDC}
{
Returns whether a record is selected, something else is selected, or nothing is
selected.
}
FUNCTION SDPGetPanelSelectionState(panel: SDPPanelHandle; VAR itsState: SDPSelectionState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 110, $AA5D;
	{$ENDC}
{
Returns the size of the currently-selected DSSpec, or zero if a record is
not selected.  It is safe to do a NewPtr (SDPGetPanelSelectionSize (...))
}
FUNCTION SDPGetPanelSelectionSize(panel: SDPPanelHandle; VAR dsSpecSize: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 114, $AA5D;
	{$ENDC}
{
Returns the currently-selected DSSpec, or a zero-lengthed
DSSpec if a record is not selected. It is assumed that the selection
buffer allocated is large enough.
}
FUNCTION SDPGetPanelSelection(panel: SDPPanelHandle; VAR selection: PackedDSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 111, $AA5D;
	{$ENDC}
{
Forces browsing to the specified RLI. If prli is the current RLI, then it does
nothing.
}
FUNCTION SDPSetPath(panel: SDPPanelHandle; {CONST}VAR prli: PackedRLI): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 112, $AA5D;
	{$ENDC}
{
This is the main driver for the panel.  You should pass all events to SDPPanelEvent
including NULL events.  If you have more than 1 panel, you will need to
call SDPPanelEvent for each panel.  NOTE:  For Update Events you will also need to call
SDPUpdatePanel as described below.
}
FUNCTION SDPPanelEvent(panel: SDPPanelHandle; {CONST}VAR theEvent: EventRecord; VAR whatHappened: SDPPanelState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 113, $AA5D;
	{$ENDC}
{
SDPUpdatePanel should be called in response to an update event.  Generally you will
have first called BeginUpdate, and pass the windows visRgn as theRgn.  If NULL
is passed for theRgn the entire panel is re-drawn.  NOTE:  Drawing is not cliped to
theRgn, if this is desired, you must first call SetClip.
}
FUNCTION SDPUpdatePanel(panel: SDPPanelHandle; theRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 106, $AA5D;
	{$ENDC}
{
SDPSelectString scrolls and selects the closest matching string at the current
level.  This is the same behavior as if the user typed in the given string.
}
FUNCTION SDPSelectString(panel: SDPPanelHandle; {CONST}VAR name: RString): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 116, $AA5D;
	{$ENDC}
{
SDPGetPathLength returns the length in bytes required to hold the current path name
in RLI format.  This corresponds to the path name in the popup menu.
}
FUNCTION SDPGetPathLength(panel: SDPPanelHandle; VAR pathNameLength: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 117, $AA5D;
	{$ENDC}
{ SDPGetPath returns the current rli. }
FUNCTION SDPGetPath(panel: SDPPanelHandle; VAR prli: PackedRLI; VAR dsRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 118, $AA5D;
	{$ENDC}
{
SDPSetFocus will draw the focus rectangle or erase the focus rectangle depending upon
the focus boolean.
}
FUNCTION SDPSetFocus(panel: SDPPanelHandle; focus: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 119, $AA5D;
	{$ENDC}
{
SDPSetPanelBalloonHelp allows clients to specify a STR# resource id to use for 
balloon help.  Balloon help is unavailable until this call is made.
}
FUNCTION SDPSetPanelBalloonHelp(panel: SDPPanelHandle; balloonHelpID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 120, $AA5D;
	{$ENDC}
{
SDPInstallPanelBusyProc allows clients to install a CB that will be called while
the panel is aynchronously busy.
}
FUNCTION SDPInstallPanelBusyProc(panel: SDPPanelHandle; busyProc: PanelBusyProc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 121, $AA5D;
	{$ENDC}
FUNCTION SDPNewFindPanel(VAR newPanel: SDPFindPanelHandle; window: WindowPtr; upperLeft: Point; layoutResourceID: INTEGER; visible: BOOLEAN; enabled: BOOLEAN; {CONST}VAR typesList: RStringPtr; typeCount: LONGINT; matchTypeHow: ByteParameter; identity: AuthIdentity; simultaneousSearchCount: INTEGER; initialFocus: SDPFindPanelFocus; refCon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 20, 2300, $AA5D;
	{$ENDC}
FUNCTION SDPDisposeFindPanel(findPanel: SDPFindPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2301, $AA5D;
	{$ENDC}
FUNCTION SDPStartFind(findPanel: SDPFindPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2302, $AA5D;
	{$ENDC}
FUNCTION SDPStopFind(findPanel: SDPFindPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2303, $AA5D;
	{$ENDC}
FUNCTION SDPFindPanelEvent(findPanel: SDPFindPanelHandle; {CONST}VAR event: EventRecord; VAR whatHappened: SDPFindPanelResult): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 6, 2304, $AA5D;
	{$ENDC}
FUNCTION SDPUpdateFindPanel(findPanel: SDPFindPanelHandle; theRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2305, $AA5D;
	{$ENDC}
FUNCTION SDPShowFindPanel(findPanel: SDPFindPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2306, $AA5D;
	{$ENDC}
FUNCTION SDPHideFindPanel(findPanel: SDPFindPanelHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 2, 2307, $AA5D;
	{$ENDC}
FUNCTION SDPMoveFindPanel(findPanel: SDPFindPanelHandle; h: INTEGER; v: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2308, $AA5D;
	{$ENDC}
FUNCTION SDPEnableFindPanel(findPanel: SDPFindPanelHandle; enabled: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 2309, $AA5D;
	{$ENDC}
FUNCTION SDPSetFindPanelFocus(findPanel: SDPFindPanelHandle; newFocus: SDPFindPanelFocus): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 2310, $AA5D;
	{$ENDC}
FUNCTION SDPGetFindPanelState(findPanel: SDPFindPanelHandle; VAR itsState: SDPFindPanelState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2311, $AA5D;
	{$ENDC}
FUNCTION SDPGetFindPanelSelectionSize(findPanel: SDPFindPanelHandle; VAR size: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2312, $AA5D;
	{$ENDC}
FUNCTION SDPGetFindPanelSelection(findPanel: SDPFindPanelHandle; VAR selection: PackedDSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2313, $AA5D;
	{$ENDC}
FUNCTION SDPSetFindPanelBalloonHelp(findPanel: SDPFindPanelHandle; balloonHelpID: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 2314, $AA5D;
	{$ENDC}
FUNCTION SDPSetFindIdentity(findPanel: SDPFindPanelHandle; identity: AuthIdentity): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2315, $AA5D;
	{$ENDC}
FUNCTION SDPInstallFindPanelBusyProc(findPanel: SDPFindPanelHandle; busyProc: FindPanelBusyProc): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 4, 2316, $AA5D;
	{$ENDC}
FUNCTION SDPGetIconByType({CONST}VAR recordType: RString; whichIcons: IconSelectorValue; VAR iconSuite: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, 1024, $AA5C;
	{$ENDC}
FUNCTION SDPGetDSSpecIcon({CONST}VAR packedDSSpec: PackedDSSpec; whichIcons: IconSelectorValue; VAR iconSuite: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, 1025, $AA5C;
	{$ENDC}
FUNCTION SDPGetCategories(VAR categories: PackedRStringListHandle; VAR displayNames: PackedRStringListHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, 1026, $AA5C;
	{$ENDC}
FUNCTION SDPGetCategoryTypes({CONST}VAR category: RString; VAR types: PackedRStringListHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, 1027, $AA5C;
	{$ENDC}
FUNCTION SDPResolveAliasFile(fileSpec: FSSpecPtr; resolvedDSSpec: PackedDSSpecHandle; identity: AuthIdentity; mayPromptUser: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 7, 3700, $AA5D;
	{$ENDC}
FUNCTION SDPResolveAliasDSSpec(theAliasDSSpec: PackedDSSpecHandle; identity: AuthIdentity; mayPromptUser: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 5, 3701, $AA5D;
	{$ENDC}
FUNCTION SDPRepairPersonalDirectory(VAR pd: FSSpec; showProgress: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 3, 6700, $AA5D;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OCEStandardDirectoryIncludes}

{$ENDC} {__OCESTANDARDDIRECTORY__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

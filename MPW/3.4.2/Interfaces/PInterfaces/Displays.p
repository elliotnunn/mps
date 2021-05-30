{
 	File:		Displays.p
 
 	Contains:	Display Manager Interfaces.
 
 	Version:	Technology:	System 7.5
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
 UNIT Displays;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DISPLAYS__}
{$SETC __DISPLAYS__ := 1}

{$I+}
{$SETC DisplaysIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{	Types.p														}
{	MixedMode.p													}

{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{	Quickdraw.p													}
{		QuickdrawText.p											}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{	Memory.p													}
{	OSUtils.p													}
{	Events.p													}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{	Controls.p													}
{		Menus.p													}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}

{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}

{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{	TextEdit.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ AppleEvents Core Suite }
	kAESystemConfigNotice		= 'cnfg';
{ Core Suite types }
	kAEDisplayNotice			= 'dspl';
	kAEDisplaySummary			= 'dsum';
	keyDMConfigVersion			= 'dmcv';
	keyDMConfigFlags			= 'dmcf';
	keyDMConfigReserved			= 'dmcr';
	keyDisplayID				= 'dmid';
	keyDisplayComponent			= 'dmdc';
	keyDisplayDevice			= 'dmdd';
	keyDisplayFlags				= 'dmdf';
	keyDisplayMode				= 'dmdm';
	keyDisplayModeReserved		= 'dmmr';
	keyDisplayReserved			= 'dmdr';
	keyDisplayMirroredId		= 'dmmi';
	keyDeviceFlags				= 'dddf';
	keyDeviceDepthMode			= 'dddm';
	keyDeviceRect				= 'dddr';
	keyPixMapRect				= 'dpdr';
	keyPixMapHResolution		= 'dphr';
	keyPixMapVResolution		= 'dpvr';
	keyPixMapPixelType			= 'dppt';
	keyPixMapPixelSize			= 'dpps';
	keyPixMapCmpCount			= 'dpcc';
	keyPixMapCmpSize			= 'dpcs';
	keyPixMapAlignment			= 'dppa';
	keyPixMapResReserved		= 'dprr';
	keyPixMapReserved			= 'dppr';
	keyPixMapColorTableSeed		= 'dpct';
	keySummaryMenubar			= 'dsmb';
	keySummaryChanges			= 'dsch';
	keyDisplayOldConfig			= 'dold';
	keyDisplayNewConfig			= 'dnew';

	dmOnlyActiveDisplays		= true;
	dmAllDisplays				= false;

{ Switch Flags }
	kNoSwitchConfirmBit			= 0;							{ Flag indicating that there is no need to confirm a switch to this mode }
	kDepthNotAvailableBit		= 1;							{ Current depth not available in new mode }
	kShowModeBit				= 3;							{ Show this mode even though it requires a confirm. }
	kModeNotResizeBit			= 4;							{ Do not use this mode to resize display (for cards that mode drives a different connector). }

{	Summary Change Flags (sticky bits indicating an operation was performed)
	For example, moving a display then moving it back will still set the kMovedDisplayBit.
}
	kBeginEndConfigureBit		= 0;
	kMovedDisplayBit			= 1;
	kSetMainDisplayBit			= 2;
	kSetDisplayModeBit			= 3;
	kAddDisplayBit				= 4;
	kRemoveDisplayBit			= 5;
	kNewDisplayBit				= 6;
	kDisposeDisplayBit			= 7;
	kEnabledDisplayBit			= 8;
	kDisabledDisplayBit			= 9;
	kMirrorDisplayBit			= 10;
	kUnMirrorDisplayBit			= 11;

{ Notification Messages for extended call back routines }
	kDMNotifyInstalled			= 1;							{ At install time }
	kDMNotifyEvent				= 2;							{ Post change time }
	kDMNotifyRemoved			= 3;							{ At remove time }
	kDMNotifyPrep				= 4;							{ Pre change time }
	kDMNotifyExtendEvent		= 5;							{ Allow registrees to extend apple event before it is sent }
	kDMNotifyDependents			= 6;							{ Minor notification check without full update }
{ Notification Flags }
	kExtendedNotificationProc	= 0+(1 * (2**(16)));

{ types for notifyType }
	kFullNotify					= 0;							{ This is the appleevent whole nine yards notify }
	kFullDependencyNotify		= 1;							{ Only sends to those who want to know about interrelated functionality (used for updating UI) }

{ DisplayID/DeviceID constants }
	kDummyDeviceID				= $0FF;							{ This is the ID of the dummy display, used when the last “real” display is disabled.}
	kInvalidDisplayID			= $000;							{ This is the invalid ID}
	kFirstDisplayID				= $100;

{ bits for panelListFlags }
	kAllowDuplicatesBit			= 0;

{ Constants for fidelity checks }
	kNoFidelity					= 0;
	kMinimumFidelity			= 1;
	kDefaultFidelity			= 500;							{ I'm just picking a number for Apple default panels and engines}
	kDefaultManufacturerFidelity = 1000;						{ I'm just picking a number for Manufacturer's panels and engines (overrides apple defaults)}

	kAnyPanelType				= 0;							{ Pass to DMNewEngineList for list of all panels (as opposed to specific types)}
	kAnyEngineType				= 0;							{ Pass to DMNewEngineList for list of all engines}
	kAnyDeviceType				= 0;							{ Pass to DMNewDeviceList for list of all devices}
	kAnyPortType				= 0;							{ Pass to DMNewDevicePortList for list of all devices}

{ portListFlags for DM_NewDevicePortList }
{ Should offline devices be put into the port list (such as dummy display) }
	kPLIncludeOfflineDevicesBit	= 0;

	
TYPE
	DMFidelityType = LONGINT;

{ AVID is an ID for ports and devices the old DisplayID type
	is carried on for compatibility
}
	AVIDType = LONGINT;

	DisplayIDType = AVIDType;

	DMListType = Ptr;

	DMListIndexType = LONGINT;

	AVPowerStatePtr = Ptr;

	DMComponentListEntryRec = RECORD
		itemID:					DisplayIDType;							{ DisplayID Manager}
		itemComponent:			Component;								{ Component Manager}
		itemDescription:		ComponentDescription;					{ We can always construct this if we use something beyond the compontent mgr.}
		itemClass:				ResType;								{ Class of group to put this panel (eg geometry/color/etc for panels, brightness/contrast for engines, video out/sound/etc for devices)}
		itemFidelity:			DMFidelityType;							{ How good is this item for the specified search?}
		itemSubClass:			ResType;								{ Subclass of group to put this panel.  Can use to do sub-grouping (eg volume for volume panel and mute panel)}
		itemSort:				Point;									{ Set to 0 - future to sort the items in a sub group.}
		itemFlags:				LONGINT;								{ Set to 0 (future expansion)}
		itemReserved:			ResType;								{ What kind of code does the itemReference point to  (right now - kPanelEntryTypeComponentMgr only)}
		itemFuture1:			LONGINT;								{ Set to 0 (future expansion - probably an alternate code style)}
		itemFuture2:			LONGINT;								{ Set to 0 (future expansion - probably an alternate code style)}
		itemFuture3:			LONGINT;								{ Set to 0 (future expansion - probably an alternate code style)}
		itemFuture4:			LONGINT;								{ Set to 0 (future expansion - probably an alternate code style)}
	END;

	DMComponentListEntryPtr = ^DMComponentListEntryRec;

{ ••• Move AVLocationRec to AVComponents.i AFTER AVComponents.i is created}
	AVLocationRec = RECORD
		locationConstant:		LONGINT;								{ Set to 0 (future expansion - probably an alternate code style)}
	END;

	AVLocationPtr = ^AVLocationRec;

	DMDepthInfoRec = RECORD
		depthSwitchInfo:		VDSwitchInfoPtr;						{ This is the switch mode to choose this timing/depth }
		depthVPBlock:			VPBlockPtr;								{ VPBlock (including size, depth and format) }
		depthFlags:				LONGINT;								{ Reserved }
		depthReserved1:			LONGINT;								{ Reserved }
		depthReserved2:			LONGINT;								{ Reserved }
	END;

	DMDepthInfoPtr = ^DMDepthInfoRec;

	DMDepthInfoBlockRec = RECORD
		depthBlockCount:		LONGINT;								{ How many depths are there? }
		depthVPBlock:			DMDepthInfoPtr;							{ Array of DMDepthInfoRec }
		depthBlockFlags:		LONGINT;								{ Reserved }
		depthBlockReserved1:	LONGINT;								{ Reserved }
		depthBlockReserved2:	LONGINT;								{ Reserved }
	END;

	DMDepthInfoBlockPtr = ^DMDepthInfoBlockRec;

	DMDisplayModeListEntryRec = RECORD
		displayModeFlags:		LONGINT;
		displayModeSwitchInfo:	VDSwitchInfoPtr;
		displayModeResolutionInfo: Ptr;
		displayModeTimingInfo:	VDTimingInfoPtr;
		displayModeDepthBlockInfo: DMDepthInfoBlockPtr;					{ Information about all the depths}
		displayModeReserved:	Ptr;									{ Reserved}
		displayModeName:		^Str255;								{ Name of the timing mode}
	END;

	DMDisplayModeListEntryPtr = ^DMDisplayModeListEntryRec;

	DependentNotifyRec = RECORD
		notifyType:				ResType;								{ What type was the engine that made the change (may be zero)}
		notifyClass:			ResType;								{ What class was the change (eg geometry, color etc)}
		notifyPortID:			DisplayIDType;							{ Which device was touched (kInvalidDisplayID -> all or none)}
		notifyComponent:		ComponentInstance;						{ What engine did it (may be 0)?}
		notifyVersion:			LONGINT;								{ Set to 0 (future expansion)}
		notifyFlags:			LONGINT;								{ Set to 0 (future expansion)}
		notifyReserved:			LONGINT;								{ Set to 0 (future expansion)}
		notifyFuture:			LONGINT;								{ Set to 0 (future expansion)}
	END;

	DependentNotifyPtr = ^DependentNotifyRec;

{ Exports to support Interfaces library containing unused calls }
	DMNotificationProcPtr = ProcPtr;  { PROCEDURE DMNotification(VAR theEvent: AppleEvent); }
	DMExtendedNotificationProcPtr = ProcPtr;  { PROCEDURE DMExtendedNotification(userData: UNIV Ptr; theMessage: INTEGER; notifyData: UNIV Ptr); }
	DMComponentListIteratorProcPtr = ProcPtr;  { PROCEDURE DMComponentListIterator(userData: UNIV Ptr; itemIndex: DMListIndexType; componentInfo: DMComponentListEntryPtr); }
	DMDisplayModeListIteratorProcPtr = ProcPtr;  { PROCEDURE DMDisplayModeListIterator(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DMDisplayModeListEntryPtr); }
	DMNotificationUPP = UniversalProcPtr;
	DMExtendedNotificationUPP = UniversalProcPtr;
	DMComponentListIteratorUPP = UniversalProcPtr;
	DMDisplayModeListIteratorUPP = UniversalProcPtr;

CONST
	uppDMNotificationProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppDMExtendedNotificationProcInfo = $00000EC0; { PROCEDURE (4 byte param, 2 byte param, 4 byte param); }
	uppDMComponentListIteratorProcInfo = $00000FC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param); }
	uppDMDisplayModeListIteratorProcInfo = $00000FC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param); }

FUNCTION NewDMNotificationProc(userRoutine: DMNotificationProcPtr): DMNotificationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDMExtendedNotificationProc(userRoutine: DMExtendedNotificationProcPtr): DMExtendedNotificationUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDMComponentListIteratorProc(userRoutine: DMComponentListIteratorProcPtr): DMComponentListIteratorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDMDisplayModeListIteratorProc(userRoutine: DMDisplayModeListIteratorProcPtr): DMDisplayModeListIteratorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallDMNotificationProc(VAR theEvent: AppleEvent; userRoutine: DMNotificationUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDMExtendedNotificationProc(userData: UNIV Ptr; theMessage: INTEGER; notifyData: UNIV Ptr; userRoutine: DMExtendedNotificationUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDMComponentListIteratorProc(userData: UNIV Ptr; itemIndex: DMListIndexType; componentInfo: DMComponentListEntryPtr; userRoutine: DMComponentListIteratorUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallDMDisplayModeListIteratorProc(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DMDisplayModeListEntryPtr; userRoutine: DMDisplayModeListIteratorUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION DMGetFirstScreenDevice(activeOnly: BOOLEAN): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $ABEB;
	{$ENDC}
FUNCTION DMGetNextScreenDevice(theDevice: GDHandle; activeOnly: BOOLEAN): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $ABEB;
	{$ENDC}
PROCEDURE DMDrawDesktopRect(VAR globalRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $ABEB;
	{$ENDC}
PROCEDURE DMDrawDesktopRegion(globalRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $ABEB;
	{$ENDC}
FUNCTION DMBeginConfigureDisplays(VAR displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0206, $ABEB;
	{$ENDC}
FUNCTION DMEndConfigureDisplays(displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0207, $ABEB;
	{$ENDC}
FUNCTION DMAddDisplay(newDevice: GDHandle; driver: INTEGER; mode: LONGINT; reserved: LONGINT; displayID: LONGINT; displayComponent: Component; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0D08, $ABEB;
	{$ENDC}
FUNCTION DMMoveDisplay(moveDevice: GDHandle; x: INTEGER; y: INTEGER; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0609, $ABEB;
	{$ENDC}
FUNCTION DMDisableDisplay(disableDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040A, $ABEB;
	{$ENDC}
FUNCTION DMEnableDisplay(enableDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040B, $ABEB;
	{$ENDC}
FUNCTION DMRemoveDisplay(removeDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040C, $ABEB;
	{$ENDC}
FUNCTION DMSetMainDisplay(newMainDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0410, $ABEB;
	{$ENDC}
FUNCTION DMSetDisplayMode(theDevice: GDHandle; mode: LONGINT; VAR depthMode: LONGINT; reserved: LONGINT; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A11, $ABEB;
	{$ENDC}
FUNCTION DMCheckDisplayMode(theDevice: GDHandle; mode: LONGINT; depthMode: LONGINT; VAR switchFlags: LONGINT; reserved: LONGINT; VAR modeOk: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0C12, $ABEB;
	{$ENDC}
FUNCTION DMGetDeskRegion(VAR desktopRegion: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0213, $ABEB;
	{$ENDC}
FUNCTION DMRegisterNotifyProc(notificationProc: DMNotificationUPP; whichPSN: ProcessSerialNumberPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0414, $ABEB;
	{$ENDC}
FUNCTION DMRemoveNotifyProc(notificationProc: DMNotificationUPP; whichPSN: ProcessSerialNumberPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0415, $ABEB;
	{$ENDC}
FUNCTION DMQDIsMirroringCapable(VAR qdIsMirroringCapable: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0216, $ABEB;
	{$ENDC}
FUNCTION DMCanMirrorNow(VAR canMirrorNow: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0217, $ABEB;
	{$ENDC}
FUNCTION DMIsMirroringOn(VAR isMirroringOn: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0218, $ABEB;
	{$ENDC}
FUNCTION DMMirrorDevices(gD1: GDHandle; gD2: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0619, $ABEB;
	{$ENDC}
FUNCTION DMUnmirrorDevice(gDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041A, $ABEB;
	{$ENDC}
FUNCTION DMGetNextMirroredDevice(gDevice: GDHandle; VAR mirroredDevice: GDHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041B, $ABEB;
	{$ENDC}
FUNCTION DMBlockMirroring: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $ABEB;
	{$ENDC}
FUNCTION DMUnblockMirroring: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $ABEB;
	{$ENDC}
FUNCTION DMGetDisplayMgrA5World(VAR dmA5: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021E, $ABEB;
	{$ENDC}
FUNCTION DMGetDisplayIDByGDevice(displayDevice: GDHandle; VAR displayID: DisplayIDType; failToMain: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $051F, $ABEB;
	{$ENDC}
FUNCTION DMGetGDeviceByDisplayID(displayID: DisplayIDType; VAR displayDevice: GDHandle; failToMain: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0520, $ABEB;
	{$ENDC}
FUNCTION DMSetDisplayComponent(theDevice: GDHandle; displayComponent: Component): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0421, $ABEB;
	{$ENDC}
FUNCTION DMGetDisplayComponent(theDevice: GDHandle; VAR displayComponent: Component): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0422, $ABEB;
	{$ENDC}
FUNCTION DMNewDisplay(VAR newDevice: GDHandle; driverRefNum: INTEGER; mode: LONGINT; reserved: LONGINT; displayID: DisplayIDType; displayComponent: Component; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0D23, $ABEB;
	{$ENDC}
FUNCTION DMDisposeDisplay(disposeDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0424, $ABEB;
	{$ENDC}
FUNCTION DMResolveDisplayComponents: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $ABEB;
	{$ENDC}
FUNCTION DMRegisterExtendedNotifyProc(notifyProc: DMExtendedNotificationUPP; notifyUserData: UNIV Ptr; nofifyOnFlags: INTEGER; whichPSN: ProcessSerialNumberPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $07EF, $ABEB;
	{$ENDC}
FUNCTION DMRemoveExtendedNotifyProc(notifyProc: DMExtendedNotificationUPP; notifyUserData: UNIV Ptr; whichPSN: ProcessSerialNumberPtr; removeFlags: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0726, $ABEB;
	{$ENDC}
FUNCTION DMNewAVPanelList(displayID: DisplayIDType; panelType: ResType; minimumFidelity: DMFidelityType; panelListFlags: LONGINT; reserved: LONGINT; VAR thePanelCount: DMListIndexType; VAR thePanelList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0C27, $ABEB;
	{$ENDC}
FUNCTION DMNewAVEngineList(displayID: DisplayIDType; engineType: ResType; minimumFidelity: DMFidelityType; engineListFlags: LONGINT; reserved: LONGINT; VAR engineCount: DMListIndexType; VAR engineList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0C28, $ABEB;
	{$ENDC}
FUNCTION DMNewAVDeviceList(deviceType: ResType; deviceListFlags: LONGINT; reserved: LONGINT; VAR deviceCount: DMListIndexType; VAR deviceList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A29, $ABEB;
	{$ENDC}
FUNCTION DMNewAVPortListByPortType(subType: ResType; portListFlags: LONGINT; reserved: LONGINT; VAR devicePortCount: DMListIndexType; VAR theDevicePortList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A2A, $ABEB;
	{$ENDC}
FUNCTION DMGetIndexedComponentFromList(panelList: DMListType; itemIndex: DMListIndexType; reserved: LONGINT; listIterator: DMComponentListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A2B, $ABEB;
	{$ENDC}
FUNCTION DMDisposeList(panelList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022C, $ABEB;
	{$ENDC}
FUNCTION DMGetNameByAVID(theID: AVIDType; nameFlags: LONGINT; VAR name: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $062D, $ABEB;
	{$ENDC}
FUNCTION DMNewAVIDByPortComponent(thePortComponent: Component; portKind: ResType; reserved: LONGINT; VAR newID: AVIDType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $082E, $ABEB;
	{$ENDC}
FUNCTION DMGetPortComponentByAVID(thePortID: DisplayIDType; VAR thePortComponent: Component; VAR theDesciption: ComponentDescription; VAR thePortKind: ResType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $082F, $ABEB;
	{$ENDC}
FUNCTION DMSendDependentNotification(notifyType: ResType; notifyClass: ResType; displayID: AVIDType; notifyComponent: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A30, $ABEB;
	{$ENDC}
FUNCTION DMDisposeAVComponent(theAVComponent: Component): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0231, $ABEB;
	{$ENDC}
FUNCTION DMSaveScreenPrefs(reserved1: LONGINT; saveFlags: LONGINT; reserved2: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0632, $ABEB;
	{$ENDC}
FUNCTION DMNewAVIDByDeviceComponent(theDeviceComponent: Component; portKind: ResType; reserved: LONGINT; VAR newID: DisplayIDType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0833, $ABEB;
	{$ENDC}
FUNCTION DMNewAVPortListByDeviceAVID(theID: AVIDType; minimumFidelity: DMFidelityType; portListFlags: LONGINT; reserved: LONGINT; VAR devicePortCount: DMListIndexType; VAR theDevicePortList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0C34, $ABEB;
	{$ENDC}
FUNCTION DMGetDeviceComponentByAVID(theDeviceID: AVIDType; VAR theDeviceComponent: Component; VAR theDesciption: ComponentDescription; VAR theDeviceKind: ResType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0835, $ABEB;
	{$ENDC}
FUNCTION DMNewDisplayModeList(displayID: DisplayIDType; modeListFlags: LONGINT; reserved: LONGINT; VAR thePanelCount: DMListIndexType; VAR thePanelList: DMListType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A36, $ABEB;
	{$ENDC}
FUNCTION DMGetIndexedDisplayModeFromList(panelList: DMListType; itemIndex: DMListIndexType; reserved: LONGINT; listIterator: DMDisplayModeListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0A37, $ABEB;
	{$ENDC}
FUNCTION DMGetGraphicInfoByAVID(theID: AVIDType; VAR theAVPcit: PicHandle; VAR theAVIconSuite: Handle; VAR theAVLocation: AVLocationRec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0838, $ABEB;
	{$ENDC}
FUNCTION DMGetAVPowerState(theID: AVIDType; getPowerState: AVPowerStatePtr; reserved1: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0839, $ABEB;
	{$ENDC}
FUNCTION DMSetAVPowerState(theID: AVIDType; setPowerState: AVPowerStatePtr; powerFlags: LONGINT; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $083A, $ABEB;
	{$ENDC}
FUNCTION DMGetDeviceAVIDByPortAVID(portAVID: AVIDType; VAR deviceAVID: AVIDType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $043B, $ABEB;
	{$ENDC}
FUNCTION DMGetEnableByAVID(theAVID: AVIDType; VAR isAVIDEnabledNow: BOOLEAN; VAR canChangeEnableNow: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $063C, $ABEB;
	{$ENDC}
FUNCTION DMSetEnableByAVID(theAVID: AVIDType; doEnable: BOOLEAN; displayState: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $053D, $ABEB;
	{$ENDC}
FUNCTION DMGetDisplayMode(theDevice: GDHandle; switchInfo: VDSwitchInfoPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $043E, $ABEB;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DisplaysIncludes}

{$ENDC} {__DISPLAYS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

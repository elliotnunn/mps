{
     File:       Displays.p
 
     Contains:   Display Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	DMProcessInfoPtr					= ProcessSerialNumberPtr;
	DMModalFilterUPP					= ModalFilterUPP;


CONST
																{  AppleEvents Core Suite  }
	kAESystemConfigNotice		= 'cnfg';						{  Core Suite types  }
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


																{  DMSendDependentNotification notifyClass  }
	kDependentNotifyClassShowCursor = 'shcr';					{  When display mgr shows a hidden cursor during an unmirror  }
	kDependentNotifyClassDriverOverride = 'ndrv';				{  When a driver is overridden  }
	kDependentNotifyClassDisplayMgrOverride = 'dmgr';			{  When display manager is upgraded  }
	kDependentNotifyClassProfileChanged = 'prof';				{  When DMSetProfileByAVID is called  }


																{  Switch Flags  }
	kNoSwitchConfirmBit			= 0;							{  Flag indicating that there is no need to confirm a switch to this mode  }
	kDepthNotAvailableBit		= 1;							{  Current depth not available in new mode  }
	kShowModeBit				= 3;							{  Show this mode even though it requires a confirm.  }
	kModeNotResizeBit			= 4;							{  Do not use this mode to resize display (for cards that mode drives a different connector).  }
	kNeverShowModeBit			= 5;							{  This mode should not be shown in the user interface.  }

	{	    Summary Change Flags (sticky bits indicating an operation was performed)
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


																{  Notification Messages for extended call back routines  }
	kDMNotifyRequestConnectionProbe = 0;						{  Like kDMNotifyRequestDisplayProbe only not for smart displays (used in wake before all busses are awake)  }
	kDMNotifyInstalled			= 1;							{  At install time  }
	kDMNotifyEvent				= 2;							{  Post change time  }
	kDMNotifyRemoved			= 3;							{  At remove time  }
	kDMNotifyPrep				= 4;							{  Pre change time  }
	kDMNotifyExtendEvent		= 5;							{  Allow registrees to extend apple event before it is sent  }
	kDMNotifyDependents			= 6;							{  Minor notification check without full update  }
	kDMNotifySuspendConfigure	= 7;							{  Temporary end of configuration  }
	kDMNotifyResumeConfigure	= 8;							{  Resume configuration  }
	kDMNotifyRequestDisplayProbe = 9;							{  Request smart displays re-probe (used in sleep and hot plugging)  }
																{  Notification Flags  }
	kExtendedNotificationProc	= $00010000;


	{	 types for notifyType 	}
	kFullNotify					= 0;							{  This is the appleevent whole nine yards notify  }
	kFullDependencyNotify		= 1;							{  Only sends to those who want to know about interrelated functionality (used for updating UI)  }

	{	 DisplayID/DeviceID constants 	}
	kDummyDeviceID				= $00FF;						{  This is the ID of the dummy display, used when the last “real” display is disabled. }
	kInvalidDisplayID			= $0000;						{  This is the invalid ID }
	kFirstDisplayID				= $0100;

																{  bits for panelListFlags  }
	kAllowDuplicatesBit			= 0;

																{  bits for nameFlags  }
	kSuppressNumberBit			= 0;
	kSuppressNumberMask			= 1;
	kForceNumberBit				= 1;
	kForceNumberMask			= 2;
	kSuppressNameBit			= 2;
	kSuppressNameMask			= 4;

	{  DMGetNameByAVID masks }
	kDMSupressNumbersMask		= $01;							{  Supress the numbers and return only names }
	kDMForceNumbersMask			= $02;							{  Force numbers to always be shown (even on single display configs) }
	kDMSupressNameMask			= $04;							{  Supress the names and return only numbers. }



	{	 Constants for fidelity checks 	}
	kNoFidelity					= 0;
	kMinimumFidelity			= 1;
	kDefaultFidelity			= 500;							{  I'm just picking a number for Apple default panels and engines }
	kDefaultManufacturerFidelity = 1000;						{  I'm just picking a number for Manufacturer's panels and engines (overrides apple defaults) }

	kAnyPanelType				= 0;							{  Pass to DMNewEngineList for list of all panels (as opposed to specific types) }
	kAnyEngineType				= 0;							{  Pass to DMNewEngineList for list of all engines }
	kAnyDeviceType				= 0;							{  Pass to DMNewDeviceList for list of all devices }
	kAnyPortType				= 0;							{  Pass to DMNewDevicePortList for list of all devices }

	{	 portListFlags for DM_NewDevicePortList 	}
																{  Should offline devices be put into the port list (such as dummy display)  }
	kPLIncludeOfflineDevicesBit	= 0;


	{	 confirmFlags for DMConfirmConfiguration 	}
	kForceConfirmBit			= 0;							{  Force a confirm dialog  }
	kForceConfirmMask			= $01;


	{	 Flags for displayModeFlags 	}
	kDisplayModeListNotPreferredBit = 0;
	kDisplayModeListNotPreferredMask = $01;


	{	 Flags for itemFlags 	}
	kComponentListNotPreferredBit = 0;
	kComponentListNotPreferredMask = $01;

	kDisplayTimingInfoVersionZero = 1;
	kDisplayTimingInfoReservedCountVersionZero = 16;
	kDisplayModeEntryVersionZero = 0;							{  displayModeVersion - original version }
	kDisplayModeEntryVersionOne	= 1;							{  displayModeVersion - added displayModeOverrideInfo }


	kMakeAndModelReservedCount	= 4;							{  Number of reserved fields }


	{  Display Gestalt for DMDisplayGestalt }
	kDisplayGestaltDisplayCommunicationAttr = 'comm';
	kDisplayGestaltForbidI2CMask = $01;							{  Some displays have firmware problems if they get I2C communication.  If this bit is set, then I2C communication is forbidden }
	kDisplayGestaltUseI2CPowerMask = $02;						{  Some displays require I2C power settings (most use DPMS). }
	kDisplayGestaltCalibratorAttr = 'cali';
	kDisplayGestaltBrightnessAffectsGammaMask = $01;			{  Used by default calibrator (should we show brightness panel)  }
	kDisplayGestaltViewAngleAffectsGammaMask = $02;				{  Currently not used by color sync }



TYPE
	DMFidelityType						= UInt32;
	{
	   AVID is an ID for ports and devices the old DisplayID type
	    is carried on for compatibility
	}


	DMListType							= Ptr;
	DMListIndexType						= UInt32;
	AVPowerStateRec						= VDPowerStateRec;
	AVPowerStateRecPtr 					= ^AVPowerStateRec;
	AVPowerStatePtr						= ^VDPowerStateRec;
	DMDisplayTimingInfoRecPtr = ^DMDisplayTimingInfoRec;
	DMDisplayTimingInfoRec = RECORD
		timingInfoVersion:		UInt32;
		timingInfoAttributes:	UInt32;									{  Flags  }
		timingInfoRelativeQuality: SInt32;								{  quality of the timing  }
		timingInfoRelativeDefault: SInt32;								{  relative default of the timing  }
		timingInfoReserved:		ARRAY [0..15] OF UInt32;				{  Reserved  }
	END;

	DMDisplayTimingInfoPtr				= ^DMDisplayTimingInfoRec;

	DMComponentListEntryRecPtr = ^DMComponentListEntryRec;
	DMComponentListEntryRec = RECORD
		itemID:					DisplayIDType;							{  DisplayID Manager }
		itemComponent:			Component;								{  Component Manager }
		itemDescription:		ComponentDescription;					{  We can always construct this if we use something beyond the compontent mgr. }
		itemClass:				ResType;								{  Class of group to put this panel (eg geometry/color/etc for panels, brightness/contrast for engines, video out/sound/etc for devices) }
		itemFidelity:			DMFidelityType;							{  How good is this item for the specified search? }
		itemSubClass:			ResType;								{  Subclass of group to put this panel.  Can use to do sub-grouping (eg volume for volume panel and mute panel) }
		itemSort:				Point;									{  Set to 0 - future to sort the items in a sub group. }
		itemFlags:				UInt32;									{  Set to 0 (future expansion) }
		itemReserved:			ResType;								{  What kind of code does the itemReference point to  (right now - kPanelEntryTypeComponentMgr only) }
		itemFuture1:			UInt32;									{  Set to 0 (future expansion - probably an alternate code style) }
		itemFuture2:			UInt32;									{  Set to 0 (future expansion - probably an alternate code style) }
		itemFuture3:			UInt32;									{  Set to 0 (future expansion - probably an alternate code style) }
		itemFuture4:			UInt32;									{  Set to 0 (future expansion - probably an alternate code style) }
	END;

	DMComponentListEntryPtr				= ^DMComponentListEntryRec;
	{  ••• Move AVLocationRec to AVComponents.i AFTER AVComponents.i is created }
	AVLocationRecPtr = ^AVLocationRec;
	AVLocationRec = RECORD
		locationConstant:		UInt32;									{  Set to 0 (future expansion - probably an alternate code style) }
	END;

	AVLocationPtr						= ^AVLocationRec;
	DMDepthInfoRecPtr = ^DMDepthInfoRec;
	DMDepthInfoRec = RECORD
		depthSwitchInfo:		VDSwitchInfoPtr;						{  This is the switch mode to choose this timing/depth  }
		depthVPBlock:			VPBlockPtr;								{  VPBlock (including size, depth and format)  }
		depthFlags:				UInt32;									{  VDVideoParametersInfoRec.csDepthFlags   }
		depthReserved1:			UInt32;									{  Reserved  }
		depthReserved2:			UInt32;									{  Reserved  }
	END;

	DMDepthInfoPtr						= ^DMDepthInfoRec;
	DMDepthInfoBlockRecPtr = ^DMDepthInfoBlockRec;
	DMDepthInfoBlockRec = RECORD
		depthBlockCount:		UInt32;									{  How many depths are there?  }
		depthVPBlock:			DMDepthInfoPtr;							{  Array of DMDepthInfoRec  }
		depthBlockFlags:		UInt32;									{  Reserved  }
		depthBlockReserved1:	UInt32;									{  Reserved  }
		depthBlockReserved2:	UInt32;									{  Reserved  }
	END;

	DMDepthInfoBlockPtr					= ^DMDepthInfoBlockRec;
	DMDisplayModeListEntryRecPtr = ^DMDisplayModeListEntryRec;
	DMDisplayModeListEntryRec = RECORD
		displayModeFlags:		UInt32;
		displayModeSwitchInfo:	VDSwitchInfoPtr;
		displayModeResolutionInfo: VDResolutionInfoPtr;
		displayModeTimingInfo:	VDTimingInfoPtr;
		displayModeDepthBlockInfo: DMDepthInfoBlockPtr;					{  Information about all the depths }
		displayModeVersion:		UInt32;									{  What version is this record (now kDisplayModeEntryVersionOne) }
		displayModeName:		StringPtr;								{  Name of the timing mode }
		displayModeDisplayInfo:	DMDisplayTimingInfoPtr;					{  Information from the display. }
	END;

	DMDisplayModeListEntryPtr			= ^DMDisplayModeListEntryRec;

	DependentNotifyRecPtr = ^DependentNotifyRec;
	DependentNotifyRec = RECORD
		notifyType:				ResType;								{  What type was the engine that made the change (may be zero) }
		notifyClass:			ResType;								{  What class was the change (eg geometry, color etc) }
		notifyPortID:			DisplayIDType;							{  Which device was touched (kInvalidDisplayID -> all or none) }
		notifyComponent:		ComponentInstance;						{  What engine did it (may be 0)? }
		notifyVersion:			UInt32;									{  Set to 0 (future expansion) }
		notifyFlags:			UInt32;									{  Set to 0 (future expansion) }
		notifyReserved:			UInt32;									{  Set to 0 (future expansion) }
		notifyFuture:			UInt32;									{  Set to 0 (future expansion) }
	END;

	DependentNotifyPtr					= ^DependentNotifyRec;

	DMMakeAndModelRecPtr = ^DMMakeAndModelRec;
	DMMakeAndModelRec = RECORD
		manufacturer:			ResType;
		model:					UInt32;
		serialNumber:			UInt32;
		manufactureDate:		UInt32;
		makeReserved:			ARRAY [0..3] OF UInt32;
	END;

	DMMakeAndModelPtr					= ^DMMakeAndModelRec;
	{  DMNewDisplayList displayListIncludeFlags }

CONST
	kIncludeOnlineActiveDisplaysMask = $01;
	kIncludeOnlineDisabledDisplaysMask = $02;
	kIncludeOfflineDisplaysMask	= $04;
	kIncludeOfflineDummyDisplaysMask = $08;
	kIncludeHardwareMirroredDisplaysMask = $10;


																{  modeListFlags for DMNewDisplayModeList  }
	kDMModeListIncludeAllModesMask = $01;						{  Include all timing modes not _explicitly_ excluded (see other bits) }
	kDMModeListIncludeOfflineModesMask = $02;
	kDMModeListExcludeDriverModesMask = $04;					{  Exclude old-style timing modes (cscGetNextResolution/kDisplayModeIDFindFirstResolution modes) }
	kDMModeListExcludeDisplayModesMask = $08;					{  Exclude timing modes that come from the display (always arbritrary timing modes) }
	kDMModeListExcludeCustomModesMask = $10;					{  Exclude custom modes that came neither from the driver or display (need a better name) }
	kDMModeListPreferStretchedModesMask = $20;					{  Prefer modes that are stretched over modes that are letterboxed when setting kDisplayModeListNotPreferredBit }
	kDMModeListPreferSafeModesMask = $40;						{  Prefer modes that are safe over modes that are not when setting kDisplayModeListNotPreferredBit }


	{  DMNewDisplayList displayListFlags }

TYPE
	DisplayListEntryRecPtr = ^DisplayListEntryRec;
	DisplayListEntryRec = RECORD
		displayListEntryGDevice: GDHandle;
		displayListEntryDisplayID: DisplayIDType;
		displayListEntryIncludeFlags: UInt32;							{  Reason this entry was included }
		displayListEntryReserved1: UInt32;
		displayListEntryReserved2: UInt32;								{  Zero }
		displayListEntryReserved3: UInt32;								{  Zero }
		displayListEntryReserved4: UInt32;								{  Zero }
		displayListEntryReserved5: UInt32;								{  Zero }
	END;

	DisplayListEntryPtr					= ^DisplayListEntryRec;
	DMProfileListEntryRecPtr = ^DMProfileListEntryRec;
	DMProfileListEntryRec = RECORD
		profileRef:				CMProfileRef;
		profileReserved1:		Ptr;									{  Reserved }
		profileReserved2:		Ptr;									{  Reserved }
		profileReserved3:		Ptr;									{  Reserved }
	END;

	DMProfileListEntryPtr				= ^DMProfileListEntryRec;
{$IFC TYPED_FUNCTION_POINTERS}
	DMNotificationProcPtr = PROCEDURE(VAR theEvent: AppleEvent);
{$ELSEC}
	DMNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DMExtendedNotificationProcPtr = PROCEDURE(userData: UNIV Ptr; theMessage: INTEGER; notifyData: UNIV Ptr);
{$ELSEC}
	DMExtendedNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DMComponentListIteratorProcPtr = PROCEDURE(userData: UNIV Ptr; itemIndex: DMListIndexType; componentInfo: DMComponentListEntryPtr);
{$ELSEC}
	DMComponentListIteratorProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DMDisplayModeListIteratorProcPtr = PROCEDURE(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DMDisplayModeListEntryPtr);
{$ELSEC}
	DMDisplayModeListIteratorProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DMProfileListIteratorProcPtr = PROCEDURE(userData: UNIV Ptr; itemIndex: DMListIndexType; profileInfo: DMProfileListEntryPtr);
{$ELSEC}
	DMProfileListIteratorProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DMDisplayListIteratorProcPtr = PROCEDURE(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DisplayListEntryPtr);
{$ELSEC}
	DMDisplayListIteratorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DMNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DMExtendedNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMExtendedNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DMComponentListIteratorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMComponentListIteratorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DMDisplayModeListIteratorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMDisplayModeListIteratorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DMProfileListIteratorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMProfileListIteratorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DMDisplayListIteratorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DMDisplayListIteratorUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDMNotificationProcInfo = $000000C0;
	uppDMExtendedNotificationProcInfo = $00000EC0;
	uppDMComponentListIteratorProcInfo = $00000FC0;
	uppDMDisplayModeListIteratorProcInfo = $00000FC0;
	uppDMProfileListIteratorProcInfo = $00000FC0;
	uppDMDisplayListIteratorProcInfo = $00000FC0;
	{
	 *  NewDMNotificationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDMNotificationUPP(userRoutine: DMNotificationProcPtr): DMNotificationUPP; { old name was NewDMNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDMExtendedNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDMExtendedNotificationUPP(userRoutine: DMExtendedNotificationProcPtr): DMExtendedNotificationUPP; { old name was NewDMExtendedNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDMComponentListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDMComponentListIteratorUPP(userRoutine: DMComponentListIteratorProcPtr): DMComponentListIteratorUPP; { old name was NewDMComponentListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDMDisplayModeListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDMDisplayModeListIteratorUPP(userRoutine: DMDisplayModeListIteratorProcPtr): DMDisplayModeListIteratorUPP; { old name was NewDMDisplayModeListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDMProfileListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDMProfileListIteratorUPP(userRoutine: DMProfileListIteratorProcPtr): DMProfileListIteratorUPP; { old name was NewDMProfileListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDMDisplayListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDMDisplayListIteratorUPP(userRoutine: DMDisplayListIteratorProcPtr): DMDisplayListIteratorUPP; { old name was NewDMDisplayListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDMNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMNotificationUPP(userUPP: DMNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDMExtendedNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMExtendedNotificationUPP(userUPP: DMExtendedNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDMComponentListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMComponentListIteratorUPP(userUPP: DMComponentListIteratorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDMDisplayModeListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMDisplayModeListIteratorUPP(userUPP: DMDisplayModeListIteratorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDMProfileListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMProfileListIteratorUPP(userUPP: DMProfileListIteratorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDMDisplayListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDMDisplayListIteratorUPP(userUPP: DMDisplayListIteratorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDMNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMNotificationUPP(VAR theEvent: AppleEvent; userRoutine: DMNotificationUPP); { old name was CallDMNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDMExtendedNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMExtendedNotificationUPP(userData: UNIV Ptr; theMessage: INTEGER; notifyData: UNIV Ptr; userRoutine: DMExtendedNotificationUPP); { old name was CallDMExtendedNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDMComponentListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMComponentListIteratorUPP(userData: UNIV Ptr; itemIndex: DMListIndexType; componentInfo: DMComponentListEntryPtr; userRoutine: DMComponentListIteratorUPP); { old name was CallDMComponentListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDMDisplayModeListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMDisplayModeListIteratorUPP(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DMDisplayModeListEntryPtr; userRoutine: DMDisplayModeListIteratorUPP); { old name was CallDMDisplayModeListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDMProfileListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMProfileListIteratorUPP(userData: UNIV Ptr; itemIndex: DMListIndexType; profileInfo: DMProfileListEntryPtr; userRoutine: DMProfileListIteratorUPP); { old name was CallDMProfileListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDMDisplayListIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDMDisplayListIteratorUPP(userData: UNIV Ptr; itemIndex: DMListIndexType; displaymodeInfo: DisplayListEntryPtr; userRoutine: DMDisplayListIteratorUPP); { old name was CallDMDisplayListIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DMDisplayGestalt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMDisplayGestalt(theDisplayID: DisplayIDType; displayGestaltSelector: ResType; VAR displayGestaltResponse: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $06D3, $ABEB;
	{$ENDC}

{
 *  DMUseScreenPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMUseScreenPrefs(usePrefs: BOOLEAN; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $03EC, $ABEB;
	{$ENDC}

{
 *  DMSuspendConfigure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMSuspendConfigure(displayState: Handle; reserved1: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $04E9, $ABEB;
	{$ENDC}

{
 *  DMResumeConfigure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMResumeConfigure(displayState: Handle; reserved1: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $04E8, $ABEB;
	{$ENDC}

{
 *  DMSetGammaByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMSetGammaByAVID(gammaAVID: AVIDType; setGammaFlags: UInt32; theGamma: GammaTblHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $06D1, $ABEB;
	{$ENDC}

{
 *  DMGetGammaByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMGetGammaByAVID(gammaAVID: AVIDType; getGammaFlags: UInt32; VAR theGamma: GammaTblHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $06D0, $ABEB;
	{$ENDC}

{
 *  DMGetMakeAndModelByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMGetMakeAndModelByAVID(theAVID: AVIDType; theMakeAndModel: DMMakeAndModelPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $04D7, $ABEB;
	{$ENDC}

{
 *  DMNewDisplayList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMNewDisplayList(displayListIncludeFlags: UInt32; reserved1: UInt32; reserved2: UInt32; VAR theCount: DMListIndexType; VAR theDisplayList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0AD6, $ABEB;
	{$ENDC}

{
 *  DMGetIndexedDisplayFromList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMGetIndexedDisplayFromList(theDisplayList: DMListType; itemIndex: DMListIndexType; reserved: UInt32; listIterator: DMDisplayListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0AD5, $ABEB;
	{$ENDC}

{
 *  DMNewProfileListByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMNewProfileListByAVID(theAVID: AVIDType; reserved: UInt32; VAR profileCount: DMListIndexType; VAR profileList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $08DC, $ABEB;
	{$ENDC}

{
 *  DMGetIndexedProfileFromList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMGetIndexedProfileFromList(profileList: DMListType; itemIndex: DMListIndexType; reserved: UInt32; listIterator: DMProfileListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0ADB, $ABEB;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DMGetFirstScreenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetFirstScreenDevice(activeOnly: BOOLEAN): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $ABEB;
	{$ENDC}

{
 *  DMGetNextScreenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetNextScreenDevice(theDevice: GDHandle; activeOnly: BOOLEAN): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $ABEB;
	{$ENDC}

{
 *  DMDrawDesktopRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DMDrawDesktopRect(VAR globalRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $ABEB;
	{$ENDC}

{
 *  DMDrawDesktopRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DMDrawDesktopRegion(globalRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $ABEB;
	{$ENDC}



{
 *  DMBeginConfigureDisplays()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMBeginConfigureDisplays(VAR displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $ABEB;
	{$ENDC}

{
 *  DMEndConfigureDisplays()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMEndConfigureDisplays(displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0207, $ABEB;
	{$ENDC}

{
 *  DMAddDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMAddDisplay(newDevice: GDHandle; driver: INTEGER; mode: UInt32; reserved: UInt32; displayID: UInt32; displayComponent: Component; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D08, $ABEB;
	{$ENDC}

{
 *  DMMoveDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMMoveDisplay(moveDevice: GDHandle; x: INTEGER; y: INTEGER; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0609, $ABEB;
	{$ENDC}

{
 *  DMDisableDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMDisableDisplay(disableDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040A, $ABEB;
	{$ENDC}

{
 *  DMEnableDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMEnableDisplay(enableDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040B, $ABEB;
	{$ENDC}

{
 *  DMRemoveDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMRemoveDisplay(removeDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040C, $ABEB;
	{$ENDC}




{
 *  DMSetMainDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSetMainDisplay(newMainDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $ABEB;
	{$ENDC}

{
 *  DMSetDisplayMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSetDisplayMode(theDevice: GDHandle; mode: UInt32; VAR depthMode: UInt32; reserved: UInt32; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A11, $ABEB;
	{$ENDC}

{
 *  DMCheckDisplayMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMCheckDisplayMode(theDevice: GDHandle; mode: UInt32; depthMode: UInt32; VAR switchFlags: UInt32; reserved: UInt32; VAR modeOk: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C12, $ABEB;
	{$ENDC}

{
 *  DMGetDeskRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDeskRegion(VAR desktopRegion: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0213, $ABEB;
	{$ENDC}

{
 *  DMRegisterNotifyProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMRegisterNotifyProc(notificationProc: DMNotificationUPP; whichPSN: DMProcessInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0414, $ABEB;
	{$ENDC}

{
 *  DMRemoveNotifyProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMRemoveNotifyProc(notificationProc: DMNotificationUPP; whichPSN: DMProcessInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0415, $ABEB;
	{$ENDC}

{
 *  DMQDIsMirroringCapable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMQDIsMirroringCapable(VAR qdIsMirroringCapable: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0216, $ABEB;
	{$ENDC}

{
 *  DMCanMirrorNow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMCanMirrorNow(VAR canMirrorNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0217, $ABEB;
	{$ENDC}

{
 *  DMIsMirroringOn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMIsMirroringOn(VAR isMirroringOn: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0218, $ABEB;
	{$ENDC}

{
 *  DMMirrorDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMMirrorDevices(gD1: GDHandle; gD2: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0619, $ABEB;
	{$ENDC}

{
 *  DMUnmirrorDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMUnmirrorDevice(gDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041A, $ABEB;
	{$ENDC}

{
 *  DMGetNextMirroredDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetNextMirroredDevice(gDevice: GDHandle; VAR mirroredDevice: GDHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041B, $ABEB;
	{$ENDC}

{
 *  DMBlockMirroring()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMBlockMirroring: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $ABEB;
	{$ENDC}

{
 *  DMUnblockMirroring()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMUnblockMirroring: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $ABEB;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DMGetDisplayMgrA5World()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DMGetDisplayMgrA5World(VAR dmA5: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021E, $ABEB;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DMGetDisplayIDByGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDisplayIDByGDevice(displayDevice: GDHandle; VAR displayID: DisplayIDType; failToMain: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $051F, $ABEB;
	{$ENDC}

{
 *  DMGetGDeviceByDisplayID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetGDeviceByDisplayID(displayID: DisplayIDType; VAR displayDevice: GDHandle; failToMain: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0520, $ABEB;
	{$ENDC}

{
 *  DMSetDisplayComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSetDisplayComponent(theDevice: GDHandle; displayComponent: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0421, $ABEB;
	{$ENDC}

{
 *  DMGetDisplayComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDisplayComponent(theDevice: GDHandle; VAR displayComponent: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0422, $ABEB;
	{$ENDC}

{
 *  DMNewDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewDisplay(VAR newDevice: GDHandle; driverRefNum: INTEGER; mode: UInt32; reserved: UInt32; displayID: DisplayIDType; displayComponent: Component; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D23, $ABEB;
	{$ENDC}

{
 *  DMDisposeDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMDisposeDisplay(disposeDevice: GDHandle; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0424, $ABEB;
	{$ENDC}

{
 *  DMResolveDisplayComponents()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMResolveDisplayComponents: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $ABEB;
	{$ENDC}

{
 *  DMRegisterExtendedNotifyProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMRegisterExtendedNotifyProc(notifyProc: DMExtendedNotificationUPP; notifyUserData: UNIV Ptr; nofifyOnFlags: UInt16; whichPSN: DMProcessInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $07EF, $ABEB;
	{$ENDC}

{
 *  DMRemoveExtendedNotifyProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMRemoveExtendedNotifyProc(notifyProc: DMExtendedNotificationUPP; notifyUserData: UNIV Ptr; whichPSN: DMProcessInfoPtr; removeFlags: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0726, $ABEB;
	{$ENDC}

{
 *  DMNewAVPanelList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVPanelList(displayID: DisplayIDType; panelType: ResType; minimumFidelity: DMFidelityType; panelListFlags: UInt32; reserved: UInt32; VAR thePanelCount: DMListIndexType; VAR thePanelList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C27, $ABEB;
	{$ENDC}

{
 *  DMNewAVEngineList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVEngineList(displayID: DisplayIDType; engineType: ResType; minimumFidelity: DMFidelityType; engineListFlags: UInt32; reserved: UInt32; VAR engineCount: DMListIndexType; VAR engineList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C28, $ABEB;
	{$ENDC}

{
 *  DMNewAVDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVDeviceList(deviceType: ResType; deviceListFlags: UInt32; reserved: UInt32; VAR deviceCount: DMListIndexType; VAR deviceList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A29, $ABEB;
	{$ENDC}

{
 *  DMNewAVPortListByPortType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVPortListByPortType(subType: ResType; portListFlags: UInt32; reserved: UInt32; VAR devicePortCount: DMListIndexType; VAR theDevicePortList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A2A, $ABEB;
	{$ENDC}

{
 *  DMGetIndexedComponentFromList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetIndexedComponentFromList(panelList: DMListType; itemIndex: DMListIndexType; reserved: UInt32; listIterator: DMComponentListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A2B, $ABEB;
	{$ENDC}

{
 *  DMDisposeList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMDisposeList(panelList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $ABEB;
	{$ENDC}

{
 *  DMGetNameByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetNameByAVID(theID: AVIDType; nameFlags: UInt32; VAR name: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $062D, $ABEB;
	{$ENDC}

{
 *  DMNewAVIDByPortComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVIDByPortComponent(thePortComponent: Component; portKind: ResType; reserved: UInt32; VAR newID: AVIDType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $082E, $ABEB;
	{$ENDC}

{
 *  DMGetPortComponentByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetPortComponentByAVID(thePortID: DisplayIDType; VAR thePortComponent: Component; VAR theDesciption: ComponentDescription; VAR thePortKind: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $082F, $ABEB;
	{$ENDC}

{
 *  DMSendDependentNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSendDependentNotification(notifyType: ResType; notifyClass: ResType; displayID: AVIDType; notifyComponent: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0830, $ABEB;
	{$ENDC}

{
 *  DMDisposeAVComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMDisposeAVComponent(theAVComponent: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0231, $ABEB;
	{$ENDC}

{
 *  DMSaveScreenPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSaveScreenPrefs(reserved1: UInt32; saveFlags: UInt32; reserved2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0632, $ABEB;
	{$ENDC}

{
 *  DMNewAVIDByDeviceComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVIDByDeviceComponent(theDeviceComponent: Component; portKind: ResType; reserved: UInt32; VAR newID: DisplayIDType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0833, $ABEB;
	{$ENDC}

{
 *  DMNewAVPortListByDeviceAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewAVPortListByDeviceAVID(theID: AVIDType; minimumFidelity: DMFidelityType; portListFlags: UInt32; reserved: UInt32; VAR devicePortCount: DMListIndexType; VAR theDevicePortList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0C34, $ABEB;
	{$ENDC}

{
 *  DMGetDeviceComponentByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDeviceComponentByAVID(theDeviceID: AVIDType; VAR theDeviceComponent: Component; VAR theDesciption: ComponentDescription; VAR theDeviceKind: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0835, $ABEB;
	{$ENDC}

{
 *  DMNewDisplayModeList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMNewDisplayModeList(displayID: DisplayIDType; modeListFlags: UInt32; reserved: UInt32; VAR thePanelCount: DMListIndexType; VAR thePanelList: DMListType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A36, $ABEB;
	{$ENDC}

{
 *  DMGetIndexedDisplayModeFromList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetIndexedDisplayModeFromList(panelList: DMListType; itemIndex: DMListIndexType; reserved: UInt32; listIterator: DMDisplayModeListIteratorUPP; userData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0A37, $ABEB;
	{$ENDC}

{
 *  DMGetGraphicInfoByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetGraphicInfoByAVID(theID: AVIDType; VAR theAVPcit: PicHandle; VAR theAVIconSuite: Handle; VAR theAVLocation: AVLocationRec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0838, $ABEB;
	{$ENDC}

{
 *  DMGetAVPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetAVPowerState(theID: AVIDType; getPowerState: AVPowerStatePtr; reserved1: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0839, $ABEB;
	{$ENDC}

{
 *  DMSetAVPowerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSetAVPowerState(theID: AVIDType; setPowerState: AVPowerStatePtr; powerFlags: UInt32; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $083A, $ABEB;
	{$ENDC}

{
 *  DMGetDeviceAVIDByPortAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDeviceAVIDByPortAVID(portAVID: AVIDType; VAR deviceAVID: AVIDType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $043B, $ABEB;
	{$ENDC}

{
 *  DMGetEnableByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetEnableByAVID(theAVID: AVIDType; VAR isAVIDEnabledNow: BOOLEAN; VAR canChangeEnableNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $063C, $ABEB;
	{$ENDC}

{
 *  DMSetEnableByAVID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMSetEnableByAVID(theAVID: AVIDType; doEnable: BOOLEAN; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $053D, $ABEB;
	{$ENDC}

{
 *  DMGetDisplayMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib68k 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMGetDisplayMode(theDevice: GDHandle; switchInfo: VDSwitchInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $043E, $ABEB;
	{$ENDC}

{
 *  DMConfirmConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DisplayLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DMConfirmConfiguration(filterProc: DMModalFilterUPP; confirmFlags: UInt32; reserved: UInt32; displayState: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $083F, $ABEB;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DisplaysIncludes}

{$ENDC} {__DISPLAYS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

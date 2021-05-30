{
     File:       ColorPickerComponents.p
 
     Contains:   Color Picker Component Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ColorPickerComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COLORPICKERCOMPONENTS__}
{$SETC __COLORPICKERCOMPONENTS__ := 1}

{$I+}
{$SETC ColorPickerComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COLORPICKER__}
{$I ColorPicker.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __BALLOONS__}
{$I Balloons.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kPickerComponentType		= 'cpkr';

	kPickerInit					= 0;
	kPickerTestGraphicsWorld	= 1;
	kPickerGetDialog			= 2;
	kPickerGetItemList			= 3;
	kPickerGetColor				= 4;
	kPickerSetColor				= 5;
	kPickerEvent				= 6;
	kPickerEdit					= 7;
	kPickerSetVisibility		= 8;
	kPickerDisplay				= 9;
	kPickerItemHit				= 10;
	kPickerSetBaseItem			= 11;
	kPickerGetProfile			= 12;
	kPickerSetProfile			= 13;
	kPickerGetPrompt			= 14;
	kPickerSetPrompt			= 15;
	kPickerGetIconData			= 16;
	kPickerGetEditMenuState		= 17;
	kPickerSetOrigin			= 18;
	kPickerExtractHelpItem		= 19;
	kPickerSetColorChangedProc	= 20;
	kNPickerGetColor			= 21;
	kNPickerSetColor			= 22;
	kNPickerGetProfile			= 23;
	kNPickerSetProfile			= 24;
	kNPickerSetColorChangedProc	= 25;

	{	 These structs were moved here from the ColorPicker header.	}

TYPE
	PickerAction 				= SInt16;
CONST
	kPickerDidNothing			= 0;							{  was kDidNothing  }
	kPickerColorChanged			= 1;							{  was kColorChanged  }
	kPickerOkHit				= 2;							{  was kOkHit  }
	kPickerCancelHit			= 3;							{  was kCancelHit  }
	kPickerNewPickerChosen		= 4;							{  was kNewPickerChosen  }
	kPickerApplItemHit			= 5;							{  was kApplItemHit  }


TYPE
	PickerColorType 			= SInt16;
CONST
	kOriginalColor				= 0;
	kNewColor					= 1;


TYPE
	PickerEditOperation 		= SInt16;
CONST
	kPickerCut					= 0;							{  was kCut  }
	kPickerCopy					= 1;							{  was kCopy  }
	kPickerPaste				= 2;							{  was kPaste  }
	kPickerClear				= 3;							{  was kClear  }
	kPickerUndo					= 4;							{  was kUndo  }


TYPE
	PickerItemModifier 			= SInt16;
CONST
	kPickerMouseDown			= 0;							{  was kMouseDown  }
	kPickerKeyDown				= 1;							{  was kKeyDown  }
	kPickerFieldEntered			= 2;							{  was kFieldEntered  }
	kPickerFieldLeft			= 3;							{  was kFieldLeft  }
	kPickerCutOp				= 4;							{  was kCutOp  }
	kPickerCopyOp				= 5;							{  was kCopyOp  }
	kPickerPasteOp				= 6;							{  was kPasteOp  }
	kPickerClearOp				= 7;							{  was kClearOp  }
	kPickerUndoOp				= 8;							{  was kUndoOp  }

	{	 These are for the flags field in the picker's 'thng' resource. 	}
	kPickerCanDoColor			= 1;							{  was CanDoColor  }
	kPickerCanDoBlackWhite		= 2;							{  was CanDoBlackWhite  }
	kPickerAlwaysModifiesPalette = 4;							{  was AlwaysModifiesPalette  }
	kPickerMayModifyPalette		= 8;							{  was MayModifyPalette  }
	kPickerIsColorSyncAware		= 16;							{  was PickerIsColorSyncAware  }
	kPickerCanDoSystemDialog	= 32;							{  was CanDoSystemDialog  }
	kPickerCanDoApplDialog		= 64;							{  was CanDoApplDialog  }
	kPickerHasOwnDialog			= 128;							{  was HasOwnDialog  }
	kPickerCanDetach			= 256;							{  was CanDetach  }
	kPickerIsColorSync2Aware	= 512;							{  was PickerIsColorSync2Aware  }


TYPE
	PickerEventForcaster 		= SInt16;
CONST
	kPickerNoForcast			= 0;							{  was kNoForcast  }
	kPickerMenuChoice			= 1;							{  was kMenuChoice  }
	kPickerDialogAccept			= 2;							{  was kDialogAccept  }
	kPickerDialogCancel			= 3;							{  was kDialogCancel  }
	kPickerLeaveFocus			= 4;							{  was kLeaveFocus  }
	kPickerSwitch				= 5;
	kPickerNormalKeyDown		= 6;							{  was kNormalKeyDown  }
	kPickerNormalMouseDown		= 7;							{  was kNormalMouseDown  }


TYPE
	PickerIconDataPtr = ^PickerIconData;
	PickerIconData = RECORD
		scriptCode:				INTEGER;
		iconSuiteID:			INTEGER;
		helpResType:			ResType;
		helpResID:				INTEGER;
	END;

	PickerInitDataPtr = ^PickerInitData;
	PickerInitData = RECORD
		pickerDialog:			DialogRef;
		choicesDialog:			DialogRef;
		flags:					LONGINT;
		yourself:				Picker;
	END;

	PickerMenuStatePtr = ^PickerMenuState;
	PickerMenuState = RECORD
		cutEnabled:				BOOLEAN;
		copyEnabled:			BOOLEAN;
		pasteEnabled:			BOOLEAN;
		clearEnabled:			BOOLEAN;
		undoEnabled:			BOOLEAN;
		filler:					SInt8;
		undoString:				Str255;
	END;

	SystemDialogInfoPtr = ^SystemDialogInfo;
	SystemDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		placeWhere:				DialogPlacementSpec;
		dialogOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;

	PickerDialogInfoPtr = ^PickerDialogInfo;
	PickerDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		dialogOrigin:			PointPtr;
		mInfo:					PickerMenuItemInfo;
	END;

	ApplicationDialogInfoPtr = ^ApplicationDialogInfo;
	ApplicationDialogInfo = RECORD
		flags:					LONGINT;
		pickerType:				LONGINT;
		theDialog:				DialogRef;
		pickerOrigin:			Point;
		mInfo:					PickerMenuItemInfo;
	END;

	PickerEventDataPtr = ^PickerEventData;
	PickerEventData = RECORD
		event:					EventRecordPtr;
		action:					PickerAction;
		itemHit:				INTEGER;
		handled:				BOOLEAN;
		filler:					SInt8;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		forcast:				PickerEventForcaster;
	END;

	PickerEditDataPtr = ^PickerEditData;
	PickerEditData = RECORD
		theEdit:				PickerEditOperation;
		action:					PickerAction;
		handled:				BOOLEAN;
		filler:					SInt8;
	END;

	PickerItemHitDataPtr = ^PickerItemHitData;
	PickerItemHitData = RECORD
		itemHit:				INTEGER;
		iMod:					PickerItemModifier;
		action:					PickerAction;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		where:					Point;
	END;

	PickerHelpItemInfoPtr = ^PickerHelpItemInfo;
	PickerHelpItemInfo = RECORD
		options:				LONGINT;
		tip:					Point;
		altRect:				Rect;
		theProc:				INTEGER;
		helpVariant:			INTEGER;
		helpMessage:			HMMessageRecord;
	END;

{$IFC OLDROUTINENAMES }

CONST
	kInitPicker					= 0;
	kTestGraphicsWorld			= 1;
	kGetDialog					= 2;
	kGetItemList				= 3;
	kGetColor					= 4;
	kSetColor					= 5;
	kEvent						= 6;
	kEdit						= 7;
	kSetVisibility				= 8;
	kDrawPicker					= 9;
	kItemHit					= 10;
	kSetBaseItem				= 11;
	kGetProfile					= 12;
	kSetProfile					= 13;
	kGetPrompt					= 14;
	kSetPrompt					= 15;
	kGetIconData				= 16;
	kGetEditMenuState			= 17;
	kSetOrigin					= 18;
	kExtractHelpItem			= 19;

	kDidNothing					= 0;
	kColorChanged				= 1;
	kOkHit						= 2;
	kCancelHit					= 3;
	kNewPickerChosen			= 4;
	kApplItemHit				= 5;

	kCut						= 0;
	kCopy						= 1;
	kPaste						= 2;
	kClear						= 3;
	kUndo						= 4;

	kMouseDown					= 0;
	kKeyDown					= 1;
	kFieldEntered				= 2;
	kFieldLeft					= 3;
	kCutOp						= 4;
	kCopyOp						= 5;
	kPasteOp					= 6;
	kClearOp					= 7;
	kUndoOp						= 8;

	kNoForcast					= 0;
	kMenuChoice					= 1;
	kDialogAccept				= 2;
	kDialogCancel				= 3;
	kLeaveFocus					= 4;
	kNormalKeyDown				= 6;
	kNormalMouseDown			= 7;


TYPE
	ColorType							= INTEGER;
	EditOperation						= INTEGER;
	ItemModifier						= INTEGER;
	EventForcaster						= INTEGER;
	EventDataPtr = ^EventData;
	EventData = RECORD
		event:					EventRecordPtr;
		action:					PickerAction;
		itemHit:				INTEGER;
		handled:				BOOLEAN;
		filler:					SInt8;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		forcast:				EventForcaster;
	END;

	EditDataPtr = ^EditData;
	EditData = RECORD
		theEdit:				EditOperation;
		action:					PickerAction;
		handled:				BOOLEAN;
		filler:					SInt8;
	END;

	ItemHitDataPtr = ^ItemHitData;
	ItemHitData = RECORD
		itemHit:				INTEGER;
		iMod:					ItemModifier;
		action:					PickerAction;
		colorProc:				ColorChangedUPP;
		colorProcData:			LONGINT;
		where:					Point;
	END;

	HelpItemInfoPtr = ^HelpItemInfo;
	HelpItemInfo = RECORD
		options:				LONGINT;
		tip:					Point;
		altRect:				Rect;
		theProc:				INTEGER;
		helpVariant:			INTEGER;
		helpMessage:			HMMessageRecord;
	END;

{$ENDC}  {OLDROUTINENAMES}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerOpenProcPtr = FUNCTION(storage: LONGINT; self: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerOpenProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerCloseProcPtr = FUNCTION(storage: LONGINT; self: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerCloseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerCanDoProcPtr = FUNCTION(storage: LONGINT; selector: INTEGER): ComponentResult;
{$ELSEC}
	PickerCanDoProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerVersionProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerVersionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerRegisterProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerRegisterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetTargetProcPtr = FUNCTION(storage: LONGINT; topOfCallChain: ComponentInstance): ComponentResult;
{$ELSEC}
	PickerSetTargetProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PickerOpenUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerOpenUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerCloseUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerCloseUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerCanDoUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerCanDoUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerVersionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerVersionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerRegisterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerRegisterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetTargetUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetTargetUPP = UniversalProcPtr;
{$ENDC}	
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerInit(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerInitProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
{$ELSEC}
	PickerInitProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerTestGraphicsWorld()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerTestGraphicsWorld(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerTestGraphicsWorldProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerInitData): ComponentResult;
{$ELSEC}
	PickerTestGraphicsWorldProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetDialog()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetDialog(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0002, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetDialogProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetDialogProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetItemList()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetItemList(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetItemListProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetItemListProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetColor()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetColor(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0004, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
{$ELSEC}
	PickerGetColorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PickerInitUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerInitUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerTestGraphicsWorldUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerTestGraphicsWorldUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetDialogUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetDialogUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetItemListUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetItemListUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetColorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetColorUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPickerOpenProcInfo = $000003F0;
	uppPickerCloseProcInfo = $000003F0;
	uppPickerCanDoProcInfo = $000002F0;
	uppPickerVersionProcInfo = $000000F0;
	uppPickerRegisterProcInfo = $000000F0;
	uppPickerSetTargetProcInfo = $000003F0;
	uppPickerInitProcInfo = $000003F0;
	uppPickerTestGraphicsWorldProcInfo = $000003F0;
	uppPickerGetDialogProcInfo = $000000F0;
	uppPickerGetItemListProcInfo = $000000F0;
	uppPickerGetColorProcInfo = $00000EF0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPickerOpenUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPickerOpenUPP(userRoutine: PickerOpenProcPtr): PickerOpenUPP; { old name was NewPickerOpenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerCloseUPP(userRoutine: PickerCloseProcPtr): PickerCloseUPP; { old name was NewPickerCloseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerCanDoUPP(userRoutine: PickerCanDoProcPtr): PickerCanDoUPP; { old name was NewPickerCanDoProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerVersionUPP(userRoutine: PickerVersionProcPtr): PickerVersionUPP; { old name was NewPickerVersionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerRegisterUPP(userRoutine: PickerRegisterProcPtr): PickerRegisterUPP; { old name was NewPickerRegisterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetTargetUPP(userRoutine: PickerSetTargetProcPtr): PickerSetTargetUPP; { old name was NewPickerSetTargetProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerInitUPP(userRoutine: PickerInitProcPtr): PickerInitUPP; { old name was NewPickerInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerTestGraphicsWorldUPP(userRoutine: PickerTestGraphicsWorldProcPtr): PickerTestGraphicsWorldUPP; { old name was NewPickerTestGraphicsWorldProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetDialogUPP(userRoutine: PickerGetDialogProcPtr): PickerGetDialogUPP; { old name was NewPickerGetDialogProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetItemListUPP(userRoutine: PickerGetItemListProcPtr): PickerGetItemListUPP; { old name was NewPickerGetItemListProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetColorUPP(userRoutine: PickerGetColorProcPtr): PickerGetColorUPP; { old name was NewPickerGetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePickerOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerOpenUPP(userUPP: PickerOpenUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerCloseUPP(userUPP: PickerCloseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerCanDoUPP(userUPP: PickerCanDoUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerVersionUPP(userUPP: PickerVersionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerRegisterUPP(userUPP: PickerRegisterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetTargetUPP(userUPP: PickerSetTargetUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerInitUPP(userUPP: PickerInitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerTestGraphicsWorldUPP(userUPP: PickerTestGraphicsWorldUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetDialogUPP(userUPP: PickerGetDialogUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetItemListUPP(userUPP: PickerGetItemListUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetColorUPP(userUPP: PickerGetColorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePickerOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerOpenUPP(storage: LONGINT; self: ComponentInstance; userRoutine: PickerOpenUPP): ComponentResult; { old name was CallPickerOpenProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerCloseUPP(storage: LONGINT; self: ComponentInstance; userRoutine: PickerCloseUPP): ComponentResult; { old name was CallPickerCloseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerCanDoUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerCanDoUPP(storage: LONGINT; selector: INTEGER; userRoutine: PickerCanDoUPP): ComponentResult; { old name was CallPickerCanDoProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerVersionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerVersionUPP(storage: LONGINT; userRoutine: PickerVersionUPP): ComponentResult; { old name was CallPickerVersionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerRegisterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerRegisterUPP(storage: LONGINT; userRoutine: PickerRegisterUPP): ComponentResult; { old name was CallPickerRegisterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetTargetUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetTargetUPP(storage: LONGINT; topOfCallChain: ComponentInstance; userRoutine: PickerSetTargetUPP): ComponentResult; { old name was CallPickerSetTargetProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerInitUPP(storage: LONGINT; VAR data: PickerInitData; userRoutine: PickerInitUPP): ComponentResult; { old name was CallPickerInitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerTestGraphicsWorldUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerTestGraphicsWorldUPP(storage: LONGINT; VAR data: PickerInitData; userRoutine: PickerTestGraphicsWorldUPP): ComponentResult; { old name was CallPickerTestGraphicsWorldProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetDialogUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetDialogUPP(storage: LONGINT; userRoutine: PickerGetDialogUPP): ComponentResult; { old name was CallPickerGetDialogProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetItemListUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetItemListUPP(storage: LONGINT; userRoutine: PickerGetItemListUPP): ComponentResult; { old name was CallPickerGetItemListProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetColorUPP(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr; userRoutine: PickerGetColorUPP): ComponentResult; { old name was CallPickerGetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  PickerSetColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PickerSetColor(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0005, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr): ComponentResult;
{$ELSEC}
	PickerSetColorProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerEvent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerEvent(storage: LONGINT; VAR data: PickerEventData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerEventProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerEventData): ComponentResult;
{$ELSEC}
	PickerEventProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerEdit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerEdit(storage: LONGINT; VAR data: PickerEditData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerEditProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerEditData): ComponentResult;
{$ELSEC}
	PickerEditProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetVisibility()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetVisibility(storage: LONGINT; visible: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0008, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetVisibilityProcPtr = FUNCTION(storage: LONGINT; visible: BOOLEAN): ComponentResult;
{$ELSEC}
	PickerSetVisibilityProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerDisplay()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerDisplay(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerDisplayProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerDisplayProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerItemHit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerItemHit(storage: LONGINT; VAR data: PickerItemHitData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerItemHitProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerItemHitData): ComponentResult;
{$ELSEC}
	PickerItemHitProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetBaseItem()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetBaseItem(storage: LONGINT; baseItem: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000B, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetBaseItemProcPtr = FUNCTION(storage: LONGINT; baseItem: INTEGER): ComponentResult;
{$ELSEC}
	PickerSetBaseItemProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetProfile(storage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000C, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetProfileProcPtr = FUNCTION(storage: LONGINT): ComponentResult;
{$ELSEC}
	PickerGetProfileProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetProfile(storage: LONGINT; profile: CMProfileHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetProfileProcPtr = FUNCTION(storage: LONGINT; profile: CMProfileHandle): ComponentResult;
{$ELSEC}
	PickerSetProfileProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetPrompt()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetPrompt(storage: LONGINT; VAR prompt: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetPromptProcPtr = FUNCTION(storage: LONGINT; VAR prompt: Str255): ComponentResult;
{$ELSEC}
	PickerGetPromptProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetPrompt()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetPrompt(storage: LONGINT; prompt: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetPromptProcPtr = FUNCTION(storage: LONGINT; prompt: Str255): ComponentResult;
{$ELSEC}
	PickerSetPromptProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetIconData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetIconData(storage: LONGINT; VAR data: PickerIconData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetIconDataProcPtr = FUNCTION(storage: LONGINT; VAR data: PickerIconData): ComponentResult;
{$ELSEC}
	PickerGetIconDataProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerGetEditMenuState()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerGetEditMenuState(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerGetEditMenuStateProcPtr = FUNCTION(storage: LONGINT; VAR mState: PickerMenuState): ComponentResult;
{$ELSEC}
	PickerGetEditMenuStateProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetOrigin()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetOrigin(storage: LONGINT; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetOriginProcPtr = FUNCTION(storage: LONGINT; where: Point): ComponentResult;
{$ELSEC}
	PickerSetOriginProcPtr = ProcPtr;
{$ENDC}

	{   Below are the ColorPicker 2.1 routines. }


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerSetColorChangedProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerSetColorChangedProc(storage: LONGINT; colorProc: ColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0014, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerSetColorChangedProcProcPtr = FUNCTION(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
{$ELSEC}
	PickerSetColorChangedProcProcPtr = ProcPtr;
{$ENDC}

	{	 New Color Picker 2.1 messages.  If you don't wish to support these you should already be... 	}
	{	 returning a badComponentSelector in your main entry routine.  They have new selectors	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NPickerGetColor()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NPickerGetColor(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0015, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerGetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
{$ELSEC}
	NPickerGetColorProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NPickerSetColor()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NPickerSetColor(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0016, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetColorProcPtr = FUNCTION(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor): ComponentResult;
{$ELSEC}
	NPickerSetColorProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NPickerGetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NPickerGetProfile(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerGetProfileProcPtr = FUNCTION(storage: LONGINT; VAR profile: CMProfileRef): ComponentResult;
{$ELSEC}
	NPickerGetProfileProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NPickerSetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NPickerSetProfile(storage: LONGINT; profile: CMProfileRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetProfileProcPtr = FUNCTION(storage: LONGINT; profile: CMProfileRef): ComponentResult;
{$ELSEC}
	NPickerSetProfileProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NPickerSetColorChangedProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NPickerSetColorChangedProc(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0019, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	NPickerSetColorChangedProcProcPtr = FUNCTION(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT): ComponentResult;
{$ELSEC}
	NPickerSetColorChangedProcProcPtr = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PickerExtractHelpItem()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PickerExtractHelpItem(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PickerExtractHelpItemProcPtr = FUNCTION(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo): ComponentResult;
{$ELSEC}
	PickerExtractHelpItemProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PickerSetColorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetColorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerEventUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerEditUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerEditUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetVisibilityUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetVisibilityUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerDisplayUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerDisplayUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerItemHitUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerItemHitUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetBaseItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetBaseItemUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetProfileUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetProfileUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetProfileUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetProfileUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetPromptUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetPromptUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetPromptUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetPromptUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetIconDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetIconDataUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerGetEditMenuStateUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerGetEditMenuStateUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetOriginUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetOriginUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerSetColorChangedProcUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerSetColorChangedProcUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NPickerGetColorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NPickerGetColorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NPickerSetColorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NPickerSetColorUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NPickerGetProfileUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NPickerGetProfileUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NPickerSetProfileUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NPickerSetProfileUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	NPickerSetColorChangedProcUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	NPickerSetColorChangedProcUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PickerExtractHelpItemUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PickerExtractHelpItemUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPickerSetColorProcInfo = $00000EF0;
	uppPickerEventProcInfo = $000003F0;
	uppPickerEditProcInfo = $000003F0;
	uppPickerSetVisibilityProcInfo = $000001F0;
	uppPickerDisplayProcInfo = $000000F0;
	uppPickerItemHitProcInfo = $000003F0;
	uppPickerSetBaseItemProcInfo = $000002F0;
	uppPickerGetProfileProcInfo = $000000F0;
	uppPickerSetProfileProcInfo = $000003F0;
	uppPickerGetPromptProcInfo = $000003F0;
	uppPickerSetPromptProcInfo = $000003F0;
	uppPickerGetIconDataProcInfo = $000003F0;
	uppPickerGetEditMenuStateProcInfo = $000003F0;
	uppPickerSetOriginProcInfo = $000003F0;
	uppPickerSetColorChangedProcProcInfo = $00000FF0;
	uppNPickerGetColorProcInfo = $00000EF0;
	uppNPickerSetColorProcInfo = $00000EF0;
	uppNPickerGetProfileProcInfo = $000003F0;
	uppNPickerSetProfileProcInfo = $000003F0;
	uppNPickerSetColorChangedProcProcInfo = $00000FF0;
	uppPickerExtractHelpItemProcInfo = $00003AF0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPickerSetColorUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPickerSetColorUPP(userRoutine: PickerSetColorProcPtr): PickerSetColorUPP; { old name was NewPickerSetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerEventUPP(userRoutine: PickerEventProcPtr): PickerEventUPP; { old name was NewPickerEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerEditUPP(userRoutine: PickerEditProcPtr): PickerEditUPP; { old name was NewPickerEditProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetVisibilityUPP(userRoutine: PickerSetVisibilityProcPtr): PickerSetVisibilityUPP; { old name was NewPickerSetVisibilityProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerDisplayUPP(userRoutine: PickerDisplayProcPtr): PickerDisplayUPP; { old name was NewPickerDisplayProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerItemHitUPP(userRoutine: PickerItemHitProcPtr): PickerItemHitUPP; { old name was NewPickerItemHitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetBaseItemUPP(userRoutine: PickerSetBaseItemProcPtr): PickerSetBaseItemUPP; { old name was NewPickerSetBaseItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetProfileUPP(userRoutine: PickerGetProfileProcPtr): PickerGetProfileUPP; { old name was NewPickerGetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetProfileUPP(userRoutine: PickerSetProfileProcPtr): PickerSetProfileUPP; { old name was NewPickerSetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetPromptUPP(userRoutine: PickerGetPromptProcPtr): PickerGetPromptUPP; { old name was NewPickerGetPromptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetPromptUPP(userRoutine: PickerSetPromptProcPtr): PickerSetPromptUPP; { old name was NewPickerSetPromptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetIconDataUPP(userRoutine: PickerGetIconDataProcPtr): PickerGetIconDataUPP; { old name was NewPickerGetIconDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerGetEditMenuStateUPP(userRoutine: PickerGetEditMenuStateProcPtr): PickerGetEditMenuStateUPP; { old name was NewPickerGetEditMenuStateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetOriginUPP(userRoutine: PickerSetOriginProcPtr): PickerSetOriginUPP; { old name was NewPickerSetOriginProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerSetColorChangedProcUPP(userRoutine: PickerSetColorChangedProcProcPtr): PickerSetColorChangedProcUPP; { old name was NewPickerSetColorChangedProcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNPickerGetColorUPP(userRoutine: NPickerGetColorProcPtr): NPickerGetColorUPP; { old name was NewNPickerGetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNPickerSetColorUPP(userRoutine: NPickerSetColorProcPtr): NPickerSetColorUPP; { old name was NewNPickerSetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNPickerGetProfileUPP(userRoutine: NPickerGetProfileProcPtr): NPickerGetProfileUPP; { old name was NewNPickerGetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNPickerSetProfileUPP(userRoutine: NPickerSetProfileProcPtr): NPickerSetProfileUPP; { old name was NewNPickerSetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewNPickerSetColorChangedProcUPP(userRoutine: NPickerSetColorChangedProcProcPtr): NPickerSetColorChangedProcUPP; { old name was NewNPickerSetColorChangedProcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewPickerExtractHelpItemUPP(userRoutine: PickerExtractHelpItemProcPtr): PickerExtractHelpItemUPP; { old name was NewPickerExtractHelpItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetColorUPP(userUPP: PickerSetColorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerEventUPP(userUPP: PickerEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerEditUPP(userUPP: PickerEditUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetVisibilityUPP(userUPP: PickerSetVisibilityUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerDisplayUPP(userUPP: PickerDisplayUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerItemHitUPP(userUPP: PickerItemHitUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetBaseItemUPP(userUPP: PickerSetBaseItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetProfileUPP(userUPP: PickerGetProfileUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetProfileUPP(userUPP: PickerSetProfileUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetPromptUPP(userUPP: PickerGetPromptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetPromptUPP(userUPP: PickerSetPromptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetIconDataUPP(userUPP: PickerGetIconDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerGetEditMenuStateUPP(userUPP: PickerGetEditMenuStateUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetOriginUPP(userUPP: PickerSetOriginUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerSetColorChangedProcUPP(userUPP: PickerSetColorChangedProcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNPickerGetColorUPP(userUPP: NPickerGetColorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNPickerSetColorUPP(userUPP: NPickerSetColorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNPickerGetProfileUPP(userUPP: NPickerGetProfileUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNPickerSetProfileUPP(userUPP: NPickerSetProfileUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeNPickerSetColorChangedProcUPP(userUPP: NPickerSetColorChangedProcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePickerExtractHelpItemUPP(userUPP: PickerExtractHelpItemUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetColorUPP(storage: LONGINT; whichColor: PickerColorType; color: PMColorPtr; userRoutine: PickerSetColorUPP): ComponentResult; { old name was CallPickerSetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerEventUPP(storage: LONGINT; VAR data: PickerEventData; userRoutine: PickerEventUPP): ComponentResult; { old name was CallPickerEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerEditUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerEditUPP(storage: LONGINT; VAR data: PickerEditData; userRoutine: PickerEditUPP): ComponentResult; { old name was CallPickerEditProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetVisibilityUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetVisibilityUPP(storage: LONGINT; visible: BOOLEAN; userRoutine: PickerSetVisibilityUPP): ComponentResult; { old name was CallPickerSetVisibilityProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerDisplayUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerDisplayUPP(storage: LONGINT; userRoutine: PickerDisplayUPP): ComponentResult; { old name was CallPickerDisplayProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerItemHitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerItemHitUPP(storage: LONGINT; VAR data: PickerItemHitData; userRoutine: PickerItemHitUPP): ComponentResult; { old name was CallPickerItemHitProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetBaseItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetBaseItemUPP(storage: LONGINT; baseItem: INTEGER; userRoutine: PickerSetBaseItemUPP): ComponentResult; { old name was CallPickerSetBaseItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetProfileUPP(storage: LONGINT; userRoutine: PickerGetProfileUPP): ComponentResult; { old name was CallPickerGetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetProfileUPP(storage: LONGINT; profile: CMProfileHandle; userRoutine: PickerSetProfileUPP): ComponentResult; { old name was CallPickerSetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetPromptUPP(storage: LONGINT; VAR prompt: Str255; userRoutine: PickerGetPromptUPP): ComponentResult; { old name was CallPickerGetPromptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetPromptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetPromptUPP(storage: LONGINT; prompt: Str255; userRoutine: PickerSetPromptUPP): ComponentResult; { old name was CallPickerSetPromptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetIconDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetIconDataUPP(storage: LONGINT; VAR data: PickerIconData; userRoutine: PickerGetIconDataUPP): ComponentResult; { old name was CallPickerGetIconDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerGetEditMenuStateUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerGetEditMenuStateUPP(storage: LONGINT; VAR mState: PickerMenuState; userRoutine: PickerGetEditMenuStateUPP): ComponentResult; { old name was CallPickerGetEditMenuStateProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetOriginUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetOriginUPP(storage: LONGINT; where: Point; userRoutine: PickerSetOriginUPP): ComponentResult; { old name was CallPickerSetOriginProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerSetColorChangedProcUPP(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT; userRoutine: PickerSetColorChangedProcUPP): ComponentResult; { old name was CallPickerSetColorChangedProcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNPickerGetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNPickerGetColorUPP(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor; userRoutine: NPickerGetColorUPP): ComponentResult; { old name was CallNPickerGetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNPickerSetColorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNPickerSetColorUPP(storage: LONGINT; whichColor: PickerColorType; VAR color: NPMColor; userRoutine: NPickerSetColorUPP): ComponentResult; { old name was CallNPickerSetColorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNPickerGetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNPickerGetProfileUPP(storage: LONGINT; VAR profile: CMProfileRef; userRoutine: NPickerGetProfileUPP): ComponentResult; { old name was CallNPickerGetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNPickerSetProfileUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNPickerSetProfileUPP(storage: LONGINT; profile: CMProfileRef; userRoutine: NPickerSetProfileUPP): ComponentResult; { old name was CallNPickerSetProfileProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeNPickerSetColorChangedProcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeNPickerSetColorChangedProcUPP(storage: LONGINT; colorProc: NColorChangedUPP; colorProcData: LONGINT; userRoutine: NPickerSetColorChangedProcUPP): ComponentResult; { old name was CallNPickerSetColorChangedProcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePickerExtractHelpItemUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePickerExtractHelpItemUPP(storage: LONGINT; itemNo: INTEGER; whichMsg: INTEGER; VAR helpInfo: PickerHelpItemInfo; userRoutine: PickerExtractHelpItemUPP): ComponentResult; { old name was CallPickerExtractHelpItemProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ColorPickerComponentsIncludes}

{$ENDC} {__COLORPICKERCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

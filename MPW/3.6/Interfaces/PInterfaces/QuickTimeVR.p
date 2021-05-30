{
     File:       QuickTimeVR.p
 
     Contains:   QuickTime VR interfaces
 
     Version:    Technology: QuickTime VR 5.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeVR;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMEVR__}
{$SETC __QUICKTIMEVR__ := 1}

{$I+}
{$SETC QuickTimeVRIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	QTVRInstance    = ^LONGINT; { an opaque 32-bit type }
	QTVRInstancePtr = ^QTVRInstance;  { when a VAR xx:QTVRInstance parameter can be nil, it is changed to xx: QTVRInstancePtr }


CONST
	kQTVRControllerSubType		= 'ctyp';
	kQTVRQTVRType				= 'qtvr';
	kQTVRPanoramaType			= 'pano';
	kQTVRObjectType				= 'obje';
	kQTVROldPanoType			= 'STpn';						{  Used in QTVR 1.0 release }
	kQTVROldObjectType			= 'stna';						{  Used in QTVR 1.0 release }

{$IFC TARGET_OS_MAC }
{$ELSEC}
{$ENDC}  {TARGET_OS_MAC}

	{  QTVR hot spot types }
	kQTVRHotSpotLinkType		= 'link';
	kQTVRHotSpotURLType			= 'url ';
	kQTVRHotSpotUndefinedType	= 'undf';

	{  Special Values for nodeID in QTVRGoToNodeID }
	kQTVRCurrentNode			= 0;
	kQTVRPreviousNode			= $80000000;
	kQTVRDefaultNode			= $80000001;

	{  Panorama correction modes used for the kQTVRImagingCorrection imaging property }
	kQTVRNoCorrection			= 0;
	kQTVRPartialCorrection		= 1;
	kQTVRFullCorrection			= 2;

	{  Imaging Modes used by QTVRSetImagingProperty, QTVRGetImagingProperty, QTVRUpdate, QTVRBeginUpdate }

TYPE
	QTVRImagingMode 			= UInt32;
CONST
	kQTVRStatic					= 1;
	kQTVRMotion					= 2;
	kQTVRCurrentMode			= 0;							{  Special Value for QTVRUpdate }
	kQTVRAllModes				= 100;							{  Special value for QTVRSetProperty }

	{  Imaging Properties used by QTVRSetImagingProperty, QTVRGetImagingProperty }
	kQTVRImagingCorrection		= 1;
	kQTVRImagingQuality			= 2;
	kQTVRImagingDirectDraw		= 3;
	kQTVRImagingCurrentMode		= 100;							{  Get Only }

	{  OR the above with kImagingDefaultValue to get/set the default value }
	kImagingDefaultValue		= $80000000;

	{  Transition Types used by QTVRSetTransitionProperty, QTVREnableTransition }
	kQTVRTransitionSwing		= 1;

	{  Transition Properties QTVRSetTransitionProperty }
	kQTVRTransitionSpeed		= 1;
	kQTVRTransitionDirection	= 2;

	{  Constraint values used to construct value returned by GetConstraintStatus }
	kQTVRUnconstrained			= 0;
	kQTVRCantPanLeft			= $00000001;
	kQTVRCantPanRight			= $00000002;
	kQTVRCantPanUp				= $00000004;
	kQTVRCantPanDown			= $00000008;
	kQTVRCantZoomIn				= $00000010;
	kQTVRCantZoomOut			= $00000020;
	kQTVRCantTranslateLeft		= $00000040;
	kQTVRCantTranslateRight		= $00000080;
	kQTVRCantTranslateUp		= $00000100;
	kQTVRCantTranslateDown		= $00000200;

	{  Object-only mouse mode values used to construct value returned by QTVRGetCurrentMouseMode }
	kQTVRPanning				= $00000001;					{  standard objects, "object only" controllers }
	kQTVRTranslating			= $00000002;					{  all objects }
	kQTVRZooming				= $00000004;					{  all objects }
	kQTVRScrolling				= $00000008;					{  standard object arrow scrollers and joystick object }
	kQTVRSelecting				= $00000010;					{  object absolute controller }

	{  Properties for use with QTVRSetInteractionProperty/GetInteractionProperty }
	kQTVRInteractionMouseClickHysteresis = 1;					{  pixels within which the mouse is considered not to have moved (UInt16) }
	kQTVRInteractionMouseClickTimeout = 2;						{  ticks after which a mouse click times out and turns into panning (UInt32) }
	kQTVRInteractionPanTiltSpeed = 3;							{  control the relative pan/tilt speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionZoomSpeed	= 4;							{  control the relative zooming speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5; }
	kQTVRInteractionTranslateOnMouseDown = 101;					{  Holding MouseDown with this setting translates zoomed object movies (Boolean) }
	kQTVRInteractionMouseMotionScale = 102;						{  The maximum angle of rotation caused by dragging across the display window. (* float) }
	kQTVRInteractionNudgeMode	= 103;							{  A QTVRNudgeMode: rotate, translate, or the same as the current mouse mode. Requires QTVR 2.1 }

	{  OR the above with kQTVRInteractionDefaultValue to get/set the default value }
	kQTVRInteractionDefaultValue = $80000000;


	{  Geometry constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRUseMovieGeometry		= 0;
	kQTVRVerticalCylinder		= 'vcyl';
	kQTVRHorizontalCylinder		= 'hcyl';
	kQTVRCube					= 'cube';

	{  Resolution constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRDefaultRes				= 0;
	kQTVRFullRes				= $00000001;
	kQTVRHalfRes				= $00000002;
	kQTVRQuarterRes				= $00000004;

	{  QTVR-specific pixelFormat constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo }
	kQTVRUseMovieDepth			= 0;

	{  Cache Size Pref constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings }
	kQTVRMinimumCache			= -1;
	kQTVRSuggestedCache			= 0;
	kQTVRFullCache				= 1;

	{  Angular units used by QTVRSetAngularUnits }

TYPE
	QTVRAngularUnits 			= UInt32;
CONST
	kQTVRDegrees				= 0;
	kQTVRRadians				= 1;

	{  Values for enableFlag parameter in QTVREnableHotSpot }
	kQTVRHotSpotID				= 0;
	kQTVRHotSpotType			= 1;
	kQTVRAllHotSpots			= 2;

	{  Values for viewParameter for QTVRSet/GetViewParameter }
	kQTVRPanAngle				= $0100;						{  default units; &float, &float }
	kQTVRTiltAngle				= $0101;						{  default units; &float, &float }
	kQTVRFieldOfViewAngle		= $0103;						{  default units; &float, &float }
	kQTVRViewCenter				= $0104;						{  pixels (per object movies); &QTVRFloatPoint, &QTVRFloatPoint }
	kQTVRHotSpotsVisible		= $0200;						{  Boolean, &Boolean }

	{  Values for flagsIn for QTVRSet/GetViewParameter }
	kQTVRValueIsRelative		= $00000001;					{  Is the value absolute or relative to the current value? }
	kQTVRValueIsRate			= $00000002;					{  Is the value absolute or a rate of change to be applied? }
	kQTVRValueIsUserPrefRelative = $00000004;					{  Is the value a percentage of the user rate pref? }

	{  Values for kind parameter in QTVRGet/SetConstraints, QTVRGetViewingLimits }
	kQTVRPan					= 0;
	kQTVRTilt					= 1;
	kQTVRFieldOfView			= 2;
	kQTVRViewCenterH			= 4;							{  WrapAndConstrain only }
	kQTVRViewCenterV			= 5;							{  WrapAndConstrain only }

	{  Values for setting parameter in QTVRSetAnimationSetting, QTVRGetAnimationSetting }

TYPE
	QTVRObjectAnimationSetting 	= UInt32;
CONST
																{  View Frame Animation Settings }
	kQTVRPalindromeViewFrames	= 1;
	kQTVRStartFirstViewFrame	= 2;
	kQTVRDontLoopViewFrames		= 3;
	kQTVRPlayEveryViewFrame		= 4;							{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
																{  View Animation Settings }
	kQTVRSyncViewToFrameRate	= 16;
	kQTVRPalindromeViews		= 17;
	kQTVRPlayStreamingViews		= 18;							{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }


TYPE
	QTVRControlSetting 			= UInt32;
CONST
	kQTVRWrapPan				= 1;
	kQTVRWrapTilt				= 2;
	kQTVRCanZoom				= 3;
	kQTVRReverseHControl		= 4;
	kQTVRReverseVControl		= 5;
	kQTVRSwapHVControl			= 6;
	kQTVRTranslation			= 7;


TYPE
	QTVRViewStateType 			= UInt32;
CONST
	kQTVRDefault				= 0;
	kQTVRCurrent				= 2;
	kQTVRMouseDown				= 3;


TYPE
	QTVRNudgeControl 			= UInt32;
CONST
	kQTVRRight					= 0;
	kQTVRUpRight				= 45;
	kQTVRUp						= 90;
	kQTVRUpLeft					= 135;
	kQTVRLeft					= 180;
	kQTVRDownLeft				= 225;
	kQTVRDown					= 270;
	kQTVRDownRight				= 315;


TYPE
	QTVRNudgeMode 				= UInt32;
CONST
	kQTVRNudgeRotate			= 0;
	kQTVRNudgeTranslate			= 1;
	kQTVRNudgeSameAsMouse		= 2;


	{  Flags to control elements of the QTVR control bar (set via mcActionSetFlags)  }
	mcFlagQTVRSuppressBackBtn	= $00010000;
	mcFlagQTVRSuppressZoomBtns	= $00020000;
	mcFlagQTVRSuppressHotSpotBtn = $00040000;
	mcFlagQTVRSuppressTranslateBtn = $00080000;
	mcFlagQTVRSuppressHelpText	= $00100000;
	mcFlagQTVRSuppressHotSpotNames = $00200000;
	mcFlagQTVRExplicitFlagSet	= $80000000;					{  bits 0->30 should be interpreted as "explicit on" for the corresponding suppression bits }

	{  Cursor types used in type field of QTVRCursorRecord }
	kQTVRUseDefaultCursor		= 0;
	kQTVRStdCursorType			= 1;
	kQTVRColorCursorType		= 2;

	{  Values for flags parameter in QTVRMouseOverHotSpot callback }
	kQTVRHotSpotEnter			= 0;
	kQTVRHotSpotWithin			= 1;
	kQTVRHotSpotLeave			= 2;

	{  Values for flags parameter in QTVRSetPrescreenImagingCompleteProc }
	kQTVRPreScreenEveryIdle		= $00000001;					{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }

	{  Values for flags field of areasOfInterest in QTVRSetBackBufferImagingProc }
	kQTVRBackBufferEveryUpdate	= $00000001;
	kQTVRBackBufferEveryIdle	= $00000002;
	kQTVRBackBufferAlwaysRefresh = $00000004;
	kQTVRBackBufferHorizontal	= $00000008;					{  Requires that backbuffer proc be long-rowBytes aware (gestaltQDHasLongRowBytes) }

	{  Values for flagsIn parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferRectVisible	= $00000001;
	kQTVRBackBufferWasRefreshed	= $00000002;

	{  Values for flagsOut parameter in QTVRBackBufferImaging callback }
	kQTVRBackBufferFlagDidDraw	= $00000001;
	kQTVRBackBufferFlagLastFlag	= $80000000;

	{  QTVRCursorRecord used in QTVRReplaceCursor }

TYPE
	QTVRCursorRecordPtr = ^QTVRCursorRecord;
	QTVRCursorRecord = RECORD
		theType:				UInt16;									{  field was previously named "type" }
		rsrcID:					SInt16;
		handle:					Handle;
	END;

	QTVRFloatPointPtr = ^QTVRFloatPoint;
	QTVRFloatPoint = RECORD
		x:						Single;
		y:						Single;
	END;

	{  Struct used for areasOfInterest parameter in QTVRSetBackBufferImagingProc }
	QTVRAreaOfInterestPtr = ^QTVRAreaOfInterest;
	QTVRAreaOfInterest = RECORD
		panAngle:				Single;
		tiltAngle:				Single;
		width:					Single;
		height:					Single;
		flags:					UInt32;
	END;

	{
	  =================================================================================================
	   Callback routines 
	  -------------------------------------------------------------------------------------------------
	}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRLeavingNodeProcPtr = FUNCTION(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRLeavingNodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVREnteringNodeProcPtr = FUNCTION(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVREnteringNodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRMouseOverHotSpotProcPtr = FUNCTION(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRMouseOverHotSpotProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRImagingCompleteProcPtr = FUNCTION(qtvr: QTVRInstance; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRImagingCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QTVRBackBufferImagingProcPtr = FUNCTION(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32): OSErr;
{$ELSEC}
	QTVRBackBufferImagingProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTVRLeavingNodeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVRLeavingNodeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QTVREnteringNodeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVREnteringNodeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QTVRMouseOverHotSpotUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVRMouseOverHotSpotUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QTVRImagingCompleteUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVRImagingCompleteUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QTVRBackBufferImagingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVRBackBufferImagingUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppQTVRLeavingNodeProcInfo = $0000FFE0;
	uppQTVREnteringNodeProcInfo = $00000FE0;
	uppQTVRMouseOverHotSpotProcInfo = $00003FE0;
	uppQTVRImagingCompleteProcInfo = $000003E0;
	uppQTVRBackBufferImagingProcInfo = $0003FBE0;
	{
	 *  NewQTVRLeavingNodeUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewQTVRLeavingNodeUPP(userRoutine: QTVRLeavingNodeProcPtr): QTVRLeavingNodeUPP; { old name was NewQTVRLeavingNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTVREnteringNodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTVREnteringNodeUPP(userRoutine: QTVREnteringNodeProcPtr): QTVREnteringNodeUPP; { old name was NewQTVREnteringNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTVRMouseOverHotSpotUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTVRMouseOverHotSpotUPP(userRoutine: QTVRMouseOverHotSpotProcPtr): QTVRMouseOverHotSpotUPP; { old name was NewQTVRMouseOverHotSpotProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTVRImagingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTVRImagingCompleteUPP(userRoutine: QTVRImagingCompleteProcPtr): QTVRImagingCompleteUPP; { old name was NewQTVRImagingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTVRBackBufferImagingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTVRBackBufferImagingUPP(userRoutine: QTVRBackBufferImagingProcPtr): QTVRBackBufferImagingUPP; { old name was NewQTVRBackBufferImagingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeQTVRLeavingNodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVRLeavingNodeUPP(userUPP: QTVRLeavingNodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTVREnteringNodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVREnteringNodeUPP(userUPP: QTVREnteringNodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTVRMouseOverHotSpotUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVRMouseOverHotSpotUPP(userUPP: QTVRMouseOverHotSpotUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTVRImagingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVRImagingCompleteUPP(userUPP: QTVRImagingCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTVRBackBufferImagingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVRBackBufferImagingUPP(userUPP: QTVRBackBufferImagingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeQTVRLeavingNodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTVRLeavingNodeUPP(qtvr: QTVRInstance; fromNodeID: UInt32; toNodeID: UInt32; VAR cancel: BOOLEAN; refCon: SInt32; userRoutine: QTVRLeavingNodeUPP): OSErr; { old name was CallQTVRLeavingNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTVREnteringNodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTVREnteringNodeUPP(qtvr: QTVRInstance; nodeID: UInt32; refCon: SInt32; userRoutine: QTVREnteringNodeUPP): OSErr; { old name was CallQTVREnteringNodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTVRMouseOverHotSpotUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTVRMouseOverHotSpotUPP(qtvr: QTVRInstance; hotSpotID: UInt32; flags: UInt32; refCon: SInt32; userRoutine: QTVRMouseOverHotSpotUPP): OSErr; { old name was CallQTVRMouseOverHotSpotProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTVRImagingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTVRImagingCompleteUPP(qtvr: QTVRInstance; refCon: SInt32; userRoutine: QTVRImagingCompleteUPP): OSErr; { old name was CallQTVRImagingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTVRBackBufferImagingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTVRBackBufferImagingUPP(qtvr: QTVRInstance; VAR drawRect: Rect; areaIndex: UInt16; flagsIn: UInt32; VAR flagsOut: UInt32; refCon: SInt32; userRoutine: QTVRBackBufferImagingUPP): OSErr; { old name was CallQTVRBackBufferImagingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  =================================================================================================
    QTVR Intercept Struct, Callback, Routine Descriptors 
  -------------------------------------------------------------------------------------------------
}


TYPE
	QTVRProcSelector 			= UInt32;
CONST
	kQTVRSetPanAngleSelector	= $2000;
	kQTVRSetTiltAngleSelector	= $2001;
	kQTVRSetFieldOfViewSelector	= $2002;
	kQTVRSetViewCenterSelector	= $2003;
	kQTVRMouseEnterSelector		= $2004;
	kQTVRMouseWithinSelector	= $2005;
	kQTVRMouseLeaveSelector		= $2006;
	kQTVRMouseDownSelector		= $2007;
	kQTVRMouseStillDownSelector	= $2008;
	kQTVRMouseUpSelector		= $2009;
	kQTVRTriggerHotSpotSelector	= $200A;
	kQTVRGetHotSpotTypeSelector	= $200B;						{  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
	kQTVRSetViewParameterSelector = $200C;						{  Requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00) }
	kQTVRGetViewParameterSelector = $200D;						{  Requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00) }


TYPE
	QTVRInterceptRecordPtr = ^QTVRInterceptRecord;
	QTVRInterceptRecord = RECORD
		reserved1:				SInt32;
		selector:				SInt32;
		reserved2:				SInt32;
		reserved3:				SInt32;
		paramCount:				SInt32;
		parameter:				ARRAY [0..5] OF Ptr;
	END;

	QTVRInterceptPtr					= ^QTVRInterceptRecord;
	{  Prototype for Intercept Proc callback }
{$IFC TYPED_FUNCTION_POINTERS}
	QTVRInterceptProcPtr = PROCEDURE(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN);
{$ELSEC}
	QTVRInterceptProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTVRInterceptUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTVRInterceptUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppQTVRInterceptProcInfo = $00003FC0;
	{
	 *  NewQTVRInterceptUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewQTVRInterceptUPP(userRoutine: QTVRInterceptProcPtr): QTVRInterceptUPP; { old name was NewQTVRInterceptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeQTVRInterceptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTVRInterceptUPP(userUPP: QTVRInterceptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeQTVRInterceptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQTVRInterceptUPP(qtvr: QTVRInstance; qtvrMsg: QTVRInterceptPtr; refCon: SInt32; VAR cancel: BOOLEAN; userRoutine: QTVRInterceptUPP); { old name was CallQTVRInterceptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
  =================================================================================================
    Initialization QTVR calls 
  -------------------------------------------------------------------------------------------------
   Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) and only work on Non-Macintosh platforms
}
{$IFC NOT TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  InitializeQTVR()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION InitializeQTVR: OSErr; C;

{
 *  TerminateQTVR()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION TerminateQTVR: OSErr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
  =================================================================================================
    General QTVR calls 
  -------------------------------------------------------------------------------------------------
}
{
 *  QTVRGetQTVRTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetQTVRTrack(theMovie: Movie; index: SInt32): Track; C;

{
 *  QTVRGetQTVRInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetQTVRInstance(VAR qtvr: QTVRInstance; qtvrTrack: Track; mc: MovieController): OSErr; C;

{
  =================================================================================================
    Viewing Angles and Zooming 
  -------------------------------------------------------------------------------------------------
}

{  QTVRSetViewParameter requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00) }
{
 *  QTVRSetViewParameter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 5.0 and later
 }
FUNCTION QTVRSetViewParameter(qtvr: QTVRInstance; viewParameter: UInt32; value: UNIV Ptr; flagsIn: UInt32): OSErr; C;

{  QTVRGetViewParameter requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00) }
{
 *  QTVRGetViewParameter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 5.0 and later
 }
FUNCTION QTVRGetViewParameter(qtvr: QTVRInstance; viewParameter: UInt32; value: UNIV Ptr; flagsIn: UInt32; VAR flagsOut: UInt32): OSErr; C;

{
 *  QTVRSetPanAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetPanAngle(qtvr: QTVRInstance; panAngle: Single): OSErr; C;

{
 *  QTVRGetPanAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetPanAngle(qtvr: QTVRInstance): Single; C;

{
 *  QTVRSetTiltAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetTiltAngle(qtvr: QTVRInstance; tiltAngle: Single): OSErr; C;

{
 *  QTVRGetTiltAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetTiltAngle(qtvr: QTVRInstance): Single; C;

{
 *  QTVRSetFieldOfView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetFieldOfView(qtvr: QTVRInstance; fieldOfView: Single): OSErr; C;

{
 *  QTVRGetFieldOfView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetFieldOfView(qtvr: QTVRInstance): Single; C;

{
 *  QTVRShowDefaultView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRShowDefaultView(qtvr: QTVRInstance): OSErr; C;

{  Object Specific }
{
 *  QTVRSetViewCenter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetViewCenter(qtvr: QTVRInstance; {CONST}VAR viewCenter: QTVRFloatPoint): OSErr; C;

{
 *  QTVRGetViewCenter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewCenter(qtvr: QTVRInstance; VAR viewCenter: QTVRFloatPoint): OSErr; C;

{
 *  QTVRNudge()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRNudge(qtvr: QTVRInstance; direction: QTVRNudgeControl): OSErr; C;

{  QTVRInteractionNudge requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
{
 *  QTVRInteractionNudge()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRInteractionNudge(qtvr: QTVRInstance; direction: QTVRNudgeControl): OSErr; C;

{
  =================================================================================================
    Scene and Node Location Information 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRGetVRWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetVRWorld(qtvr: QTVRInstance; VAR VRWorld: QTAtomContainer): OSErr; C;

{
 *  QTVRGetNodeInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetNodeInfo(qtvr: QTVRInstance; nodeID: UInt32; VAR nodeInfo: QTAtomContainer): OSErr; C;

{
 *  QTVRGoToNodeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGoToNodeID(qtvr: QTVRInstance; nodeID: UInt32): OSErr; C;

{
 *  QTVRGetCurrentNodeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetCurrentNodeID(qtvr: QTVRInstance): UInt32; C;

{
 *  QTVRGetNodeType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetNodeType(qtvr: QTVRInstance; nodeID: UInt32): LONGINT; C;

{
  =================================================================================================
    Hot Spot related calls 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRPtToHotSpotID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRPtToHotSpotID(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32): OSErr; C;

{  QTVRGetHotSpotType requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
{
 *  QTVRGetHotSpotType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetHotSpotType(qtvr: QTVRInstance; hotSpotID: UInt32; VAR hotSpotType: OSType): OSErr; C;

{
 *  QTVRTriggerHotSpot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRTriggerHotSpot(qtvr: QTVRInstance; hotSpotID: UInt32; nodeInfo: QTAtomContainer; selectedAtom: QTAtom): OSErr; C;

{
 *  QTVRSetMouseOverHotSpotProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetMouseOverHotSpotProc(qtvr: QTVRInstance; mouseOverHotSpotProc: QTVRMouseOverHotSpotUPP; refCon: SInt32; flags: UInt32): OSErr; C;

{
 *  QTVREnableHotSpot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVREnableHotSpot(qtvr: QTVRInstance; enableFlag: UInt32; hotSpotValue: UInt32; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetVisibleHotSpots()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetVisibleHotSpots(qtvr: QTVRInstance; hotSpots: Handle): UInt32; C;

{
 *  QTVRGetHotSpotRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetHotSpotRegion(qtvr: QTVRInstance; hotSpotID: UInt32; hotSpotRegion: RgnHandle): OSErr; C;

{
  =================================================================================================
    Event & Cursor Handling Calls 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetMouseOverTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetMouseOverTracking(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetMouseOverTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetMouseOverTracking(qtvr: QTVRInstance): BOOLEAN; C;

{
 *  QTVRSetMouseDownTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetMouseDownTracking(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetMouseDownTracking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetMouseDownTracking(qtvr: QTVRInstance): BOOLEAN; C;

{
 *  QTVRMouseEnter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseEnter(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef): OSErr; C;

{
 *  QTVRMouseWithin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseWithin(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef): OSErr; C;

{
 *  QTVRMouseLeave()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseLeave(qtvr: QTVRInstance; pt: Point; w: WindowRef): OSErr; C;

{
 *  QTVRMouseDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseDown(qtvr: QTVRInstance; pt: Point; when: UInt32; modifiers: UInt16; VAR hotSpotID: UInt32; w: WindowRef): OSErr; C;

{
 *  QTVRMouseStillDown()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseStillDown(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef): OSErr; C;

{
 *  QTVRMouseUp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseUp(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef): OSErr; C;

{  These require QTVR 2.01 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion01) }
{
 *  QTVRMouseStillDownExtended()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseStillDownExtended(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef; when: UInt32; modifiers: UInt16): OSErr; C;

{
 *  QTVRMouseUpExtended()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRMouseUpExtended(qtvr: QTVRInstance; pt: Point; VAR hotSpotID: UInt32; w: WindowRef; when: UInt32; modifiers: UInt16): OSErr; C;

{
  =================================================================================================
    Intercept Routines 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRInstallInterceptProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRInstallInterceptProc(qtvr: QTVRInstance; selector: QTVRProcSelector; interceptProc: QTVRInterceptUPP; refCon: SInt32; flags: UInt32): OSErr; C;

{
 *  QTVRCallInterceptedProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRCallInterceptedProc(qtvr: QTVRInstance; VAR qtvrMsg: QTVRInterceptRecord): OSErr; C;

{
  =================================================================================================
    Object Movie Specific Calls 
  -------------------------------------------------------------------------------------------------
   QTVRGetCurrentMouseMode requires QTRVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
}
{
 *  QTVRGetCurrentMouseMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetCurrentMouseMode(qtvr: QTVRInstance): UInt32; C;

{
 *  QTVRSetFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetFrameRate(qtvr: QTVRInstance; rate: Single): OSErr; C;

{
 *  QTVRGetFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetFrameRate(qtvr: QTVRInstance): Single; C;

{
 *  QTVRSetViewRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetViewRate(qtvr: QTVRInstance; rate: Single): OSErr; C;

{
 *  QTVRGetViewRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewRate(qtvr: QTVRInstance): Single; C;

{
 *  QTVRSetViewCurrentTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetViewCurrentTime(qtvr: QTVRInstance; time: TimeValue): OSErr; C;

{
 *  QTVRGetViewCurrentTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewCurrentTime(qtvr: QTVRInstance): TimeValue; C;

{
 *  QTVRGetCurrentViewDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetCurrentViewDuration(qtvr: QTVRInstance): TimeValue; C;

{
  =================================================================================================
   View State Calls - QTVR Object Only
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetViewState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetViewState(qtvr: QTVRInstance; viewStateType: QTVRViewStateType; state: UInt16): OSErr; C;

{
 *  QTVRGetViewState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewState(qtvr: QTVRInstance; viewStateType: QTVRViewStateType; VAR state: UInt16): OSErr; C;

{
 *  QTVRGetViewStateCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewStateCount(qtvr: QTVRInstance): UInt16; C;

{
 *  QTVRSetAnimationSetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetAnimationSetting(qtvr: QTVRInstance; setting: QTVRObjectAnimationSetting; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetAnimationSetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetAnimationSetting(qtvr: QTVRInstance; setting: QTVRObjectAnimationSetting; VAR enable: BOOLEAN): OSErr; C;

{
 *  QTVRSetControlSetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetControlSetting(qtvr: QTVRInstance; setting: QTVRControlSetting; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetControlSetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetControlSetting(qtvr: QTVRInstance; setting: QTVRControlSetting; VAR enable: BOOLEAN): OSErr; C;

{
 *  QTVREnableFrameAnimation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVREnableFrameAnimation(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetFrameAnimation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetFrameAnimation(qtvr: QTVRInstance): BOOLEAN; C;

{
 *  QTVREnableViewAnimation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVREnableViewAnimation(qtvr: QTVRInstance; enable: BOOLEAN): OSErr; C;

{
 *  QTVRGetViewAnimation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewAnimation(qtvr: QTVRInstance): BOOLEAN; C;


{
  =================================================================================================
    Imaging Characteristics 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetVisible(qtvr: QTVRInstance; visible: BOOLEAN): OSErr; C;

{
 *  QTVRGetVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetVisible(qtvr: QTVRInstance): BOOLEAN; C;

{
 *  QTVRSetImagingProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetImagingProperty(qtvr: QTVRInstance; imagingMode: QTVRImagingMode; imagingProperty: UInt32; propertyValue: SInt32): OSErr; C;

{
 *  QTVRGetImagingProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetImagingProperty(qtvr: QTVRInstance; imagingMode: QTVRImagingMode; imagingProperty: UInt32; VAR propertyValue: SInt32): OSErr; C;

{
 *  QTVRUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRUpdate(qtvr: QTVRInstance; imagingMode: QTVRImagingMode): OSErr; C;

{
 *  QTVRBeginUpdateStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRBeginUpdateStream(qtvr: QTVRInstance; imagingMode: QTVRImagingMode): OSErr; C;

{
 *  QTVREndUpdateStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVREndUpdateStream(qtvr: QTVRInstance): OSErr; C;

{
 *  QTVRSetTransitionProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetTransitionProperty(qtvr: QTVRInstance; transitionType: UInt32; transitionProperty: UInt32; transitionValue: SInt32): OSErr; C;

{
 *  QTVREnableTransition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVREnableTransition(qtvr: QTVRInstance; transitionType: UInt32; enable: BOOLEAN): OSErr; C;

{
  =================================================================================================
    Basic Conversion and Math Routines 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetAngularUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetAngularUnits(qtvr: QTVRInstance; units: QTVRAngularUnits): OSErr; C;

{
 *  QTVRGetAngularUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetAngularUnits(qtvr: QTVRInstance): QTVRAngularUnits; C;

{  Pano specific routines }
{
 *  QTVRPtToAngles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRPtToAngles(qtvr: QTVRInstance; pt: Point; VAR panAngle: Single; VAR tiltAngle: Single): OSErr; C;

{
 *  QTVRCoordToAngles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRCoordToAngles(qtvr: QTVRInstance; VAR coord: QTVRFloatPoint; VAR panAngle: Single; VAR tiltAngle: Single): OSErr; C;

{
 *  QTVRAnglesToCoord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRAnglesToCoord(qtvr: QTVRInstance; panAngle: Single; tiltAngle: Single; VAR coord: QTVRFloatPoint): OSErr; C;

{  Object specific routines }
{
 *  QTVRPanToColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRPanToColumn(qtvr: QTVRInstance; panAngle: Single): INTEGER; C;

{  zero based    }
{
 *  QTVRColumnToPan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRColumnToPan(qtvr: QTVRInstance; column: INTEGER): Single; C;

{  zero based    }
{
 *  QTVRTiltToRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRTiltToRow(qtvr: QTVRInstance; tiltAngle: Single): INTEGER; C;

{  zero based    }
{
 *  QTVRRowToTilt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRRowToTilt(qtvr: QTVRInstance; row: INTEGER): Single; C;

{  zero based                }
{
 *  QTVRWrapAndConstrain()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRWrapAndConstrain(qtvr: QTVRInstance; kind: INTEGER; value: Single; VAR result: Single): OSErr; C;


{
  =================================================================================================
    Interaction Routines 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetEnteringNodeProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetEnteringNodeProc(qtvr: QTVRInstance; enteringNodeProc: QTVREnteringNodeUPP; refCon: SInt32; flags: UInt32): OSErr; C;

{
 *  QTVRSetLeavingNodeProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetLeavingNodeProc(qtvr: QTVRInstance; leavingNodeProc: QTVRLeavingNodeUPP; refCon: SInt32; flags: UInt32): OSErr; C;

{
 *  QTVRSetInteractionProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetInteractionProperty(qtvr: QTVRInstance; property: UInt32; value: UNIV Ptr): OSErr; C;

{
 *  QTVRGetInteractionProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetInteractionProperty(qtvr: QTVRInstance; property: UInt32; value: UNIV Ptr): OSErr; C;

{
 *  QTVRReplaceCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRReplaceCursor(qtvr: QTVRInstance; VAR cursRecord: QTVRCursorRecord): OSErr; C;

{
  =================================================================================================
    Viewing Limits and Constraints 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRGetViewingLimits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetViewingLimits(qtvr: QTVRInstance; kind: UInt16; VAR minValue: Single; VAR maxValue: Single): OSErr; C;

{
 *  QTVRGetConstraintStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetConstraintStatus(qtvr: QTVRInstance): UInt32; C;

{
 *  QTVRGetConstraints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetConstraints(qtvr: QTVRInstance; kind: UInt16; VAR minValue: Single; VAR maxValue: Single): OSErr; C;

{
 *  QTVRSetConstraints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetConstraints(qtvr: QTVRInstance; kind: UInt16; minValue: Single; maxValue: Single): OSErr; C;


{
  =================================================================================================
    Back Buffer Memory Management 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRGetAvailableResolutions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetAvailableResolutions(qtvr: QTVRInstance; VAR resolutionsMask: UInt16): OSErr; C;

{  These require QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) }
{
 *  QTVRGetBackBufferMemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetBackBufferMemInfo(qtvr: QTVRInstance; geometry: UInt32; resolution: UInt16; cachePixelFormat: UInt32; VAR minCacheBytes: SInt32; VAR suggestedCacheBytes: SInt32; VAR fullCacheBytes: SInt32): OSErr; C;

{
 *  QTVRGetBackBufferSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRGetBackBufferSettings(qtvr: QTVRInstance; VAR geometry: UInt32; VAR resolution: UInt16; VAR cachePixelFormat: UInt32; VAR cacheSize: SInt16): OSErr; C;

{
 *  QTVRSetBackBufferPrefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetBackBufferPrefs(qtvr: QTVRInstance; geometry: UInt32; resolution: UInt16; cachePixelFormat: UInt32; cacheSize: SInt16): OSErr; C;

{
  =================================================================================================
    Buffer Access 
  -------------------------------------------------------------------------------------------------
}

{
 *  QTVRSetPrescreenImagingCompleteProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetPrescreenImagingCompleteProc(qtvr: QTVRInstance; imagingCompleteProc: QTVRImagingCompleteUPP; refCon: SInt32; flags: UInt32): OSErr; C;

{
 *  QTVRSetBackBufferImagingProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRSetBackBufferImagingProc(qtvr: QTVRInstance; backBufferImagingProc: QTVRBackBufferImagingUPP; numAreas: UInt16; VAR areasOfInterest: QTVRAreaOfInterest; refCon: SInt32): OSErr; C;

{
 *  QTVRRefreshBackBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTVR.lib 2.1 and later
 }
FUNCTION QTVRRefreshBackBuffer(qtvr: QTVRInstance; flags: UInt32): OSErr; C;



{
  =================================================================================================
    Old Names
  -------------------------------------------------------------------------------------------------
}
{$IFC OLDROUTINENAMES }

TYPE
	CursorRecord						= QTVRCursorRecord;
	CursorRecordPtr 					= ^CursorRecord;
	AreaOfInterest						= QTVRAreaOfInterest;
	AreaOfInterestPtr 					= ^AreaOfInterest;
	FloatPoint							= QTVRFloatPoint;
	FloatPointPtr 						= ^FloatPoint;
	LeavingNodeProcPtr					= QTVRLeavingNodeProcPtr;
	LeavingNodeUPP						= QTVRLeavingNodeUPP;
	EnteringNodeProcPtr					= QTVREnteringNodeProcPtr;
	EnteringNodeUPP						= QTVREnteringNodeUPP;
	MouseOverHotSpotProcPtr				= QTVRMouseOverHotSpotProcPtr;
	MouseOverHotSpotUPP					= QTVRMouseOverHotSpotUPP;
	ImagingCompleteProcPtr				= QTVRImagingCompleteProcPtr;
	ImagingCompleteUPP					= QTVRImagingCompleteUPP;
	BackBufferImagingProcPtr			= QTVRBackBufferImagingProcPtr;
	BackBufferImagingUPP				= QTVRBackBufferImagingUPP;
{$ENDC}  {OLDROUTINENAMES}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeVRIncludes}

{$ENDC} {__QUICKTIMEVR__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

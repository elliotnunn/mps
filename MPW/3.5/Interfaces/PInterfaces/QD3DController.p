{
     File:       QD3DController.p
 
     Contains:   Q3Controller methods
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DController;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DCONTROLLER__}
{$SETC __QD3DCONTROLLER__ := 1}

{$I+}
{$SETC QD3DControllerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                             Type Definitions                             **
 **                                                                          **
 ****************************************************************************}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ChannelGetMethod = FUNCTION(controllerRef: TQ3ControllerRef; channel: UInt32; data: UNIV Ptr; VAR dataSize: UInt32): TQ3Status; C;
{$ELSEC}
	TQ3ChannelGetMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ChannelSetMethod = FUNCTION(controllerRef: TQ3ControllerRef; channel: UInt32; data: UNIV Ptr; dataSize: UInt32): TQ3Status; C;
{$ELSEC}
	TQ3ChannelSetMethod = ProcPtr;
{$ENDC}

	TQ3ControllerDataPtr = ^TQ3ControllerData;
	TQ3ControllerData = RECORD
		signature:				CStringPtr;
		valueCount:				UInt32;
		channelCount:			UInt32;
		channelGetMethod:		TQ3ChannelGetMethod;
		channelSetMethod:		TQ3ChannelSetMethod;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                                  Routines                                **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Controller_GetListChanged()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Controller_GetListChanged(VAR listChanged: TQ3Boolean; VAR serialNumber: UInt32): TQ3Status; C;

{
 *  Q3Controller_Next()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_Next(controllerRef: TQ3ControllerRef; VAR nextControllerRef: TQ3ControllerRef): TQ3Status; C;

{
 *  Q3Controller_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_New({CONST}VAR controllerData: TQ3ControllerData): TQ3ControllerRef; C;

{
 *  Q3Controller_Decommission()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_Decommission(controllerRef: TQ3ControllerRef): TQ3Status; C;

{
 *  Q3Controller_SetActivation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetActivation(controllerRef: TQ3ControllerRef; active: TQ3Boolean): TQ3Status; C;

{
 *  Q3Controller_GetActivation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetActivation(controllerRef: TQ3ControllerRef; VAR active: TQ3Boolean): TQ3Status; C;

{
 *  Q3Controller_GetSignature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetSignature(controllerRef: TQ3ControllerRef; signature: CStringPtr; numChars: UInt32): TQ3Status; C;

{
 *  Q3Controller_SetChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetChannel(controllerRef: TQ3ControllerRef; channel: UInt32; data: UNIV Ptr; dataSize: UInt32): TQ3Status; C;

{
 *  Q3Controller_GetChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetChannel(controllerRef: TQ3ControllerRef; channel: UInt32; data: UNIV Ptr; VAR dataSize: UInt32): TQ3Status; C;

{
 *  Q3Controller_GetValueCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetValueCount(controllerRef: TQ3ControllerRef; VAR valueCount: UInt32): TQ3Status; C;

{
 *  Q3Controller_SetTracker()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetTracker(controllerRef: TQ3ControllerRef; tracker: TQ3TrackerObject): TQ3Status; C;

{
 *  Q3Controller_HasTracker()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_HasTracker(controllerRef: TQ3ControllerRef; VAR hasTracker: TQ3Boolean): TQ3Status; C;

{
 *  Q3Controller_Track2DCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_Track2DCursor(controllerRef: TQ3ControllerRef; VAR track2DCursor: TQ3Boolean): TQ3Status; C;

{
 *  Q3Controller_Track3DCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_Track3DCursor(controllerRef: TQ3ControllerRef; VAR track3DCursor: TQ3Boolean): TQ3Status; C;

{
 *  Q3Controller_GetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetButtons(controllerRef: TQ3ControllerRef; VAR buttons: UInt32): TQ3Status; C;

{
 *  Q3Controller_SetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetButtons(controllerRef: TQ3ControllerRef; buttons: UInt32): TQ3Status; C;

{
 *  Q3Controller_GetTrackerPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetTrackerPosition(controllerRef: TQ3ControllerRef; VAR position: TQ3Point3D): TQ3Status; C;

{
 *  Q3Controller_SetTrackerPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetTrackerPosition(controllerRef: TQ3ControllerRef; {CONST}VAR position: TQ3Point3D): TQ3Status; C;

{
 *  Q3Controller_MoveTrackerPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_MoveTrackerPosition(controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Vector3D): TQ3Status; C;

{
 *  Q3Controller_GetTrackerOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetTrackerOrientation(controllerRef: TQ3ControllerRef; VAR orientation: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Controller_SetTrackerOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetTrackerOrientation(controllerRef: TQ3ControllerRef; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Controller_MoveTrackerOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_MoveTrackerOrientation(controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Controller_GetValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_GetValues(controllerRef: TQ3ControllerRef; valueCount: UInt32; VAR values: Single; VAR changed: TQ3Boolean; VAR serialNumber: UInt32): TQ3Status; C;

{
 *  Q3Controller_SetValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Controller_SetValues(controllerRef: TQ3ControllerRef; {CONST}VAR values: Single; valueCount: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                                  Routines                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ControllerState_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ControllerState_New(controllerRef: TQ3ControllerRef): TQ3ControllerStateObject; C;

{
 *  Q3ControllerState_SaveAndReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ControllerState_SaveAndReset(controllerStateObject: TQ3ControllerStateObject): TQ3Status; C;

{
 *  Q3ControllerState_Restore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ControllerState_Restore(controllerStateObject: TQ3ControllerStateObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Type Definitions                             **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3TrackerNotifyFunc = FUNCTION(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef): TQ3Status; C;
{$ELSEC}
	TQ3TrackerNotifyFunc = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                                  Routines                                **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Tracker_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Tracker_New(notifyFunc: TQ3TrackerNotifyFunc): TQ3TrackerObject; C;

{
 *  Q3Tracker_SetNotifyThresholds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_SetNotifyThresholds(trackerObject: TQ3TrackerObject; positionThresh: Single; orientationThresh: Single): TQ3Status; C;

{
 *  Q3Tracker_GetNotifyThresholds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetNotifyThresholds(trackerObject: TQ3TrackerObject; VAR positionThresh: Single; VAR orientationThresh: Single): TQ3Status; C;

{
 *  Q3Tracker_SetActivation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_SetActivation(trackerObject: TQ3TrackerObject; active: TQ3Boolean): TQ3Status; C;

{
 *  Q3Tracker_GetActivation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetActivation(trackerObject: TQ3TrackerObject; VAR active: TQ3Boolean): TQ3Status; C;

{
 *  Q3Tracker_GetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetButtons(trackerObject: TQ3TrackerObject; VAR buttons: UInt32): TQ3Status; C;

{
 *  Q3Tracker_ChangeButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_ChangeButtons(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; buttons: UInt32; buttonMask: UInt32): TQ3Status; C;

{
 *  Q3Tracker_GetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetPosition(trackerObject: TQ3TrackerObject; VAR position: TQ3Point3D; VAR delta: TQ3Vector3D; VAR changed: TQ3Boolean; VAR serialNumber: UInt32): TQ3Status; C;

{
 *  Q3Tracker_SetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_SetPosition(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR position: TQ3Point3D): TQ3Status; C;

{
 *  Q3Tracker_MovePosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_MovePosition(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Vector3D): TQ3Status; C;

{
 *  Q3Tracker_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetOrientation(trackerObject: TQ3TrackerObject; VAR orientation: TQ3Quaternion; VAR delta: TQ3Quaternion; VAR changed: TQ3Boolean; VAR serialNumber: UInt32): TQ3Status; C;

{
 *  Q3Tracker_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_SetOrientation(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Tracker_MoveOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_MoveOrientation(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Tracker_SetEventCoordinates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_SetEventCoordinates(trackerObject: TQ3TrackerObject; timeStamp: UInt32; buttons: UInt32; {CONST}VAR position: TQ3Point3D; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;

{
 *  Q3Tracker_GetEventCoordinates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Tracker_GetEventCoordinates(trackerObject: TQ3TrackerObject; timeStamp: UInt32; VAR buttons: UInt32; VAR position: TQ3Point3D; VAR orientation: TQ3Quaternion): TQ3Status; C;

{*****************************************************************************
 **                                                                          **
 **                              Types                                       **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3CursorTrackerNotifyFunc = PROCEDURE; C;
{$ELSEC}
	TQ3CursorTrackerNotifyFunc = ProcPtr;
{$ENDC}

	{	*****************************************************************************
	 **                                                                          **
	 **                              Routines                                    **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3CursorTracker_PrepareTracking()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3CursorTracker_PrepareTracking: TQ3Status; C;

{
 *  Q3CursorTracker_SetTrackDeltas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CursorTracker_SetTrackDeltas(trackDeltas: TQ3Boolean): TQ3Status; C;

{
 *  Q3CursorTracker_GetAndClearDeltas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CursorTracker_GetAndClearDeltas(VAR depth: Single; VAR orientation: TQ3Quaternion; VAR hasOrientation: TQ3Boolean; VAR changed: TQ3Boolean; VAR serialNumber: UInt32): TQ3Status; C;

{
 *  Q3CursorTracker_SetNotifyFunc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CursorTracker_SetNotifyFunc(notifyFunc: TQ3CursorTrackerNotifyFunc): TQ3Status; C;

{
 *  Q3CursorTracker_GetNotifyFunc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3CursorTracker_GetNotifyFunc(VAR notifyFunc: TQ3CursorTrackerNotifyFunc): TQ3Status; C;





{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DControllerIncludes}

{$ENDC} {__QD3DCONTROLLER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

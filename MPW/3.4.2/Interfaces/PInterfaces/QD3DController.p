{
 	File:		QD3DController.p
 
 	Contains:	Each physical device is represented in the system by a			
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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

{
*****************************************************************************
 **																			 **
 **								Type Definitions							 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3ChannelGetMethod = ProcPtr;  { FUNCTION TQ3ChannelGetMethod(controllerRef: TQ3ControllerRef; channel: LONGINT; data: UNIV Ptr; VAR dataSize: LONGINT): TQ3Status; C; }

	TQ3ChannelSetMethod = ProcPtr;  { FUNCTION TQ3ChannelSetMethod(controllerRef: TQ3ControllerRef; channel: LONGINT; data: UNIV Ptr; dataSize: LONGINT): TQ3Status; C; }

	TQ3ControllerDataPtr = ^TQ3ControllerData;
	TQ3ControllerData = RECORD
		signature:				CStringPtr;
		valueCount:				LONGINT;
		channelCount:			LONGINT;
		channelGetMethod:		TQ3ChannelGetMethod;
		channelSetMethod:		TQ3ChannelSetMethod;
	END;

{
*****************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Controller_GetListChanged(VAR listChanged: TQ3Boolean; VAR serialNumber: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_Next(controllerRef: TQ3ControllerRef; VAR nextControllerRef: TQ3ControllerRef): TQ3Status; C;
FUNCTION Q3Controller_New({CONST}VAR controllerData: TQ3ControllerData): TQ3ControllerRef; C;
FUNCTION Q3Controller_Decommission(controllerRef: TQ3ControllerRef): TQ3Status; C;
FUNCTION Q3Controller_SetActivation(controllerRef: TQ3ControllerRef; active: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Controller_GetActivation(controllerRef: TQ3ControllerRef; VAR active: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Controller_GetSignature(controllerRef: TQ3ControllerRef; signature: CStringPtr; numChars: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_SetChannel(controllerRef: TQ3ControllerRef; channel: LONGINT; data: UNIV Ptr; dataSize: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_GetChannel(controllerRef: TQ3ControllerRef; channel: LONGINT; data: UNIV Ptr; VAR dataSize: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_GetValueCount(controllerRef: TQ3ControllerRef; VAR valueCount: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_SetTracker(controllerRef: TQ3ControllerRef; tracker: TQ3TrackerObject): TQ3Status; C;
FUNCTION Q3Controller_HasTracker(controllerRef: TQ3ControllerRef; VAR hasTracker: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Controller_Track2DCursor(controllerRef: TQ3ControllerRef; VAR track2DCursor: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Controller_Track3DCursor(controllerRef: TQ3ControllerRef; VAR track3DCursor: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Controller_GetButtons(controllerRef: TQ3ControllerRef; VAR buttons: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_SetButtons(controllerRef: TQ3ControllerRef; buttons: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_GetTrackerPosition(controllerRef: TQ3ControllerRef; VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Controller_SetTrackerPosition(controllerRef: TQ3ControllerRef; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Controller_MoveTrackerPosition(controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Controller_GetTrackerOrientation(controllerRef: TQ3ControllerRef; VAR orientation: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Controller_SetTrackerOrientation(controllerRef: TQ3ControllerRef; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Controller_MoveTrackerOrientation(controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Controller_GetValues(controllerRef: TQ3ControllerRef; valueCount: LONGINT; VAR values: Single; VAR changed: TQ3Boolean; VAR serialNumber: LONGINT): TQ3Status; C;
FUNCTION Q3Controller_SetValues(controllerRef: TQ3ControllerRef; {CONST}VAR values: Single; valueCount: LONGINT): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3ControllerState_New(controllerRef: TQ3ControllerRef): TQ3ControllerStateObject; C;
FUNCTION Q3ControllerState_SaveAndReset(controllerStateObject: TQ3ControllerStateObject): TQ3Status; C;
FUNCTION Q3ControllerState_Restore(controllerStateObject: TQ3ControllerStateObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **								Type Definitions							 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3TrackerNotifyFunc = ProcPtr;  { FUNCTION TQ3TrackerNotifyFunc(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef): TQ3Status; C; }

{
*****************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Tracker_New(notifyFunc: TQ3TrackerNotifyFunc): TQ3TrackerObject; C;
FUNCTION Q3Tracker_SetNotifyThresholds(trackerObject: TQ3TrackerObject; positionThresh: Single; orientationThresh: Single): TQ3Status; C;
FUNCTION Q3Tracker_GetNotifyThresholds(trackerObject: TQ3TrackerObject; VAR positionThresh: Single; VAR orientationThresh: Single): TQ3Status; C;
FUNCTION Q3Tracker_SetActivation(trackerObject: TQ3TrackerObject; active: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Tracker_GetActivation(trackerObject: TQ3TrackerObject; VAR active: TQ3Boolean): TQ3Status; C;
FUNCTION Q3Tracker_GetButtons(trackerObject: TQ3TrackerObject; VAR buttons: LONGINT): TQ3Status; C;
FUNCTION Q3Tracker_ChangeButtons(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; buttons: LONGINT; buttonMask: LONGINT): TQ3Status; C;
FUNCTION Q3Tracker_GetPosition(trackerObject: TQ3TrackerObject; VAR position: TQ3Point3D; VAR delta: TQ3Vector3D; VAR changed: TQ3Boolean; VAR serialNumber: LONGINT): TQ3Status; C;
FUNCTION Q3Tracker_SetPosition(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR position: TQ3Point3D): TQ3Status; C;
FUNCTION Q3Tracker_MovePosition(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Vector3D): TQ3Status; C;
FUNCTION Q3Tracker_GetOrientation(trackerObject: TQ3TrackerObject; VAR orientation: TQ3Quaternion; VAR delta: TQ3Quaternion; VAR changed: TQ3Boolean; VAR serialNumber: LONGINT): TQ3Status; C;
FUNCTION Q3Tracker_SetOrientation(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Tracker_MoveOrientation(trackerObject: TQ3TrackerObject; controllerRef: TQ3ControllerRef; {CONST}VAR delta: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Tracker_SetEventCoordinates(trackerObject: TQ3TrackerObject; timeStamp: LONGINT; buttons: LONGINT; {CONST}VAR position: TQ3Point3D; {CONST}VAR orientation: TQ3Quaternion): TQ3Status; C;
FUNCTION Q3Tracker_GetEventCoordinates(trackerObject: TQ3TrackerObject; timeStamp: LONGINT; VAR buttons: LONGINT; VAR position: TQ3Point3D; VAR orientation: TQ3Quaternion): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DControllerIncludes}

{$ENDC} {__QD3DCONTROLLER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

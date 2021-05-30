/******************************************************************************
 **																			 **
 ** 	Module:		QD3DController.h										 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Each physical device is represented in the system by a	 **
 ** 				Controller record.  A device driver typically creates	 **
 ** 				a controller.  Controller feeds changes in coordinates	 **
 ** 				to a Tracker.											 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DController_h
#define QD3DController_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#ifdef __cplusplus
extern "C" {
#endif  /*  __cplusplus  */


/******************************************************************************
 **																			 **
 **								Type Definitions							 **
 **																			 **
 *****************************************************************************/

#define kQ3ControllerSetChannelMaxDataSize		256

typedef TQ3Status (*TQ3ChannelGetMethod) (
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	void						*data,
	unsigned long				*dataSize);

typedef TQ3Status (*TQ3ChannelSetMethod) (
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	const void					*data,
	unsigned long				dataSize);

typedef struct TQ3ControllerData {
	char						*signature;
	unsigned long				valueCount;
	unsigned long				channelCount;
	TQ3ChannelGetMethod			channelGetMethod;
	TQ3ChannelSetMethod			channelSetMethod;
} TQ3ControllerData;


/******************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3Controller_GetListChanged (
	TQ3Boolean					*listChanged,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status Q3Controller_Next(
	TQ3ControllerRef			controllerRef,
	TQ3ControllerRef			*nextControllerRef);

QD3D_EXPORT TQ3ControllerRef Q3Controller_New(
	const TQ3ControllerData		*controllerData);

QD3D_EXPORT TQ3Status Q3Controller_Decommission(
	TQ3ControllerRef			controllerRef);

QD3D_EXPORT TQ3Status Q3Controller_SetActivation(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					active);

QD3D_EXPORT TQ3Status Q3Controller_GetActivation(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*active);

QD3D_EXPORT TQ3Status Q3Controller_GetSignature(
	TQ3ControllerRef			controllerRef,
	char						*signature,
	unsigned long				numChars);

QD3D_EXPORT TQ3Status Q3Controller_SetChannel(
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	const void					*data,
	unsigned long				dataSize);

QD3D_EXPORT TQ3Status Q3Controller_GetChannel(
	TQ3ControllerRef			controllerRef,
	unsigned long				channel,
	void						*data,
	unsigned long				*dataSize);

QD3D_EXPORT TQ3Status Q3Controller_GetValueCount(
	TQ3ControllerRef			controllerRef,
	unsigned long				*valueCount);

QD3D_EXPORT TQ3Status Q3Controller_SetTracker(
	TQ3ControllerRef			controllerRef,
	TQ3TrackerObject			tracker);

QD3D_EXPORT TQ3Status Q3Controller_HasTracker(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*hasTracker);

QD3D_EXPORT TQ3Status Q3Controller_Track2DCursor(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*track2DCursor);

QD3D_EXPORT TQ3Status Q3Controller_Track3DCursor(
	TQ3ControllerRef			controllerRef,
	TQ3Boolean					*track3DCursor);

QD3D_EXPORT TQ3Status Q3Controller_GetButtons(
	TQ3ControllerRef			controllerRef,
	unsigned long				*buttons);

QD3D_EXPORT TQ3Status Q3Controller_SetButtons(
	TQ3ControllerRef			controllerRef,
	unsigned long				buttons);

QD3D_EXPORT TQ3Status Q3Controller_GetTrackerPosition(
	TQ3ControllerRef			controllerRef,
	TQ3Point3D					*position);

QD3D_EXPORT TQ3Status Q3Controller_SetTrackerPosition(
	TQ3ControllerRef			controllerRef,
	const TQ3Point3D			*position);

QD3D_EXPORT TQ3Status Q3Controller_MoveTrackerPosition(
	TQ3ControllerRef			controllerRef,
	const TQ3Vector3D			*delta);

QD3D_EXPORT TQ3Status Q3Controller_GetTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	TQ3Quaternion				*orientation);

QD3D_EXPORT TQ3Status Q3Controller_SetTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status Q3Controller_MoveTrackerOrientation(
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*delta);

QD3D_EXPORT TQ3Status Q3Controller_GetValues(
	TQ3ControllerRef			controllerRef,
	unsigned long				valueCount,
	float						*values,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status Q3Controller_SetValues(
	TQ3ControllerRef			controllerRef,
	const float					*values,
	unsigned long				valueCount);


/******************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ControllerStateObject Q3ControllerState_New(
	TQ3ControllerRef			controllerRef);

QD3D_EXPORT TQ3Status Q3ControllerState_SaveAndReset(
	TQ3ControllerStateObject	controllerStateObject);

QD3D_EXPORT TQ3Status Q3ControllerState_Restore(
	TQ3ControllerStateObject	controllerStateObject);


/******************************************************************************
 **																			 **
 **								Type Definitions							 **
 **																			 **
 *****************************************************************************/

typedef TQ3Status (*TQ3TrackerNotifyFunc) (
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef);


/******************************************************************************
 **																			 **
 **									 Routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3TrackerObject Q3Tracker_New(
	TQ3TrackerNotifyFunc		notifyFunc);

QD3D_EXPORT TQ3Status Q3Tracker_SetNotifyThresholds(
	TQ3TrackerObject			trackerObject,
	float						positionThresh,
	float						orientationThresh);

QD3D_EXPORT TQ3Status Q3Tracker_GetNotifyThresholds(
	TQ3TrackerObject			trackerObject,
	float						*positionThresh,
	float						*orientationThresh);

QD3D_EXPORT TQ3Status Q3Tracker_SetActivation (
	TQ3TrackerObject			trackerObject,
	TQ3Boolean					active);

QD3D_EXPORT TQ3Status Q3Tracker_GetActivation (
	TQ3TrackerObject			trackerObject,
	TQ3Boolean					*active);

QD3D_EXPORT TQ3Status Q3Tracker_GetButtons(
	TQ3TrackerObject			trackerObject,
	unsigned long				*buttons);

QD3D_EXPORT TQ3Status Q3Tracker_ChangeButtons(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	unsigned long				buttons,
	unsigned long				buttonMask);

QD3D_EXPORT TQ3Status Q3Tracker_GetPosition(
	TQ3TrackerObject			trackerObject,
	TQ3Point3D					*position,
	TQ3Vector3D					*delta,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status Q3Tracker_SetPosition(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Point3D			*position);

QD3D_EXPORT TQ3Status Q3Tracker_MovePosition(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Vector3D			*delta);

QD3D_EXPORT TQ3Status Q3Tracker_GetOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3Quaternion				*orientation,
	TQ3Quaternion				*delta,
	TQ3Boolean					*changed,
	unsigned long				*serialNumber);

QD3D_EXPORT TQ3Status Q3Tracker_SetOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status Q3Tracker_MoveOrientation(
	TQ3TrackerObject			trackerObject,
	TQ3ControllerRef			controllerRef,
	const TQ3Quaternion			*delta);

QD3D_EXPORT TQ3Status Q3Tracker_SetEventCoordinates(
	TQ3TrackerObject			trackerObject,
	unsigned long				timeStamp,
	unsigned long				buttons,
	const TQ3Point3D			*position,
	const TQ3Quaternion			*orientation);

QD3D_EXPORT TQ3Status Q3Tracker_GetEventCoordinates(
	TQ3TrackerObject			trackerObject,
	unsigned long				timeStamp,
	unsigned long				*buttons,
	TQ3Point3D					*position,
	TQ3Quaternion				*orientation);


#ifdef __cplusplus
}
#endif  /*  __cplusplus  */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DController_h  */

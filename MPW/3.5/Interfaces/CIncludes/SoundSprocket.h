/*
     File:       SoundSprocket.h
 
     Contains:   SoundSprocket interfaces
 
     Version:    Technology: 1.7
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __SOUNDSPROCKET__
#define __SOUNDSPROCKET__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __QD3D__
#include <QD3D.h>
#endif

#ifndef __QD3DCAMERA__
#include <QD3DCamera.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/*******************************************************************************
 *  SndSetInfo/SndGetInfo Messages
 ******************************************************************************/
/*  The siSSpCPULoadLimit = '3dll' selector for SndGetInfo fills in a value of  */
/*  type UInt32.                                                                */

enum {
  kSSpSpeakerKind_Stereo        = 0,
  kSSpSpeakerKind_Mono          = 1,
  kSSpSpeakerKind_Headphones    = 2
};


/*  This is the data type is used with the SndGet/SetInfo selector              */
/*  siSSpSpeakerSetup = '3dst'                                                  */
struct SSpSpeakerSetupData {
  UInt32              speakerKind;            /* Speaker configuration          */
  float               speakerAngle;           /* Angle formed by user and speakers  */

  UInt32              reserved0;              /* Reserved for future use -- set to 0    */
  UInt32              reserved1;              /* Reserved for future use -- set to 0    */
};
typedef struct SSpSpeakerSetupData      SSpSpeakerSetupData;
enum {
  kSSpMedium_Air                = 0,
  kSSpMedium_Water              = 1
};


enum {
  kSSpSourceMode_Unfiltered     = 0,    /* No filtering applied             */
  kSSpSourceMode_Localized      = 1,    /* Localized by source position      */
  kSSpSourceMode_Ambient        = 2,    /* Coming from all around          */
  kSSpSourceMode_Binaural       = 3     /* Already binaurally localized      */
};


struct SSpLocationData {
  float               elevation;              /* Angle of the meridian -- pos is up */
  float               azimuth;                /* Angle of the parallel -- pos is left   */
  float               distance;               /* Distance between source and listener   */
  float               projectionAngle;        /* Cos(angle) between cone and listener   */
  float               sourceVelocity;         /* Speed of source toward the listener    */
  float               listenerVelocity;       /*Speed of listener toward the source */
};
typedef struct SSpLocationData          SSpLocationData;
struct SSpVirtualSourceData {
  float               attenuation;            /* Attenuation factor           */
  SSpLocationData     location;               /* Location of virtual source        */
};
typedef struct SSpVirtualSourceData     SSpVirtualSourceData;
/*  This is the data type is used with the SndGet/SetInfo selector              */
/*  siSSpLocalization = '3dif'                                                  */
struct SSpLocalizationData {
  UInt32              cpuLoad;                /* CPU load vs. quality -- 0 is best  */

  UInt32              medium;                 /* Medium for sound propagation      */
  float               humidity;               /* Humidity when medium is air         */
  float               roomSize;               /* Reverb model -- distance bet. walls    */
  float               roomReflectivity;       /*Reverb model -- bounce attenuation  */
  float               reverbAttenuation;      /*Reverb model -- mix level      */

  UInt32              sourceMode;             /* Type of filtering to apply        */
  float               referenceDistance;      /*Nominal distance for recording   */
  float               coneAngleCos;           /* Cos(angle/2) of attenuation cone     */
  float               coneAttenuation;        /* Attenuation outside the cone      */
  SSpLocationData     currentLocation;        /* Location of the sound           */

  UInt32              reserved0;              /* Reserved for future use -- set to 0    */
  UInt32              reserved1;              /* Reserved for future use -- set to 0    */
  UInt32              reserved2;              /* Reserved for future use -- set to 0    */
  UInt32              reserved3;              /* Reserved for future use -- set to 0    */

  UInt32              virtualSourceCount;     /*Number of reflections          */
  SSpVirtualSourceData  virtualSource[4];     /*The reflections               */
};
typedef struct SSpLocalizationData      SSpLocalizationData;
#if TARGET_CPU_PPC
typedef CALLBACK_API_C( Boolean , SSpEventProcPtr )(EventRecord * inEvent);

/*******************************************************************************
 *  Global functions
 ******************************************************************************/
/*
 *  SSpConfigureSpeakerSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpConfigureSpeakerSetup(SSpEventProcPtr inEventProcPtr);


/*
 *  SSpGetCPULoadLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpGetCPULoadLimit(UInt32 * outCPULoadLimit);



/*******************************************************************************
 *  Routines for Maniulating Listeners
 ******************************************************************************/
typedef struct OpaqueSSpListenerReference*  SSpListenerReference;
/*
 *  SSpListener_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_New(SSpListenerReference * outListenerReference);


/*
 *  SSpListener_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_Dispose(SSpListenerReference inListenerReference);


/*
 *  SSpListener_SetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetTransform(
  SSpListenerReference   inListenerReference,
  const TQ3Matrix4x4 *   inTransform);


/*
 *  SSpListener_GetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetTransform(
  SSpListenerReference   inListenerReference,
  TQ3Matrix4x4 *         outTransform);


/*
 *  SSpListener_SetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetPosition(
  SSpListenerReference   inListenerReference,
  const TQ3Point3D *     inPosition);


/*
 *  SSpListener_GetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetPosition(
  SSpListenerReference   inListenerReference,
  TQ3Point3D *           outPosition);


/*
 *  SSpListener_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetOrientation(
  SSpListenerReference   inListenerReference,
  const TQ3Vector3D *    inOrientation);


/*
 *  SSpListener_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetOrientation(
  SSpListenerReference   inListenerReference,
  TQ3Vector3D *          outOrientation);


/*
 *  SSpListener_SetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetUpVector(
  SSpListenerReference   inListenerReference,
  const TQ3Vector3D *    inUpVector);


/*
 *  SSpListener_GetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetUpVector(
  SSpListenerReference   inListenerReference,
  TQ3Vector3D *          outUpVector);


/*
 *  SSpListener_SetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetCameraPlacement(
  SSpListenerReference        inListenerReference,
  const TQ3CameraPlacement *  inCameraPlacement);


/*
 *  SSpListener_GetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetCameraPlacement(
  SSpListenerReference   inListenerReference,
  TQ3CameraPlacement *   outCameraPlacement);


/*
 *  SSpListener_SetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetVelocity(
  SSpListenerReference   inListenerReference,
  const TQ3Vector3D *    inVelocity);


/*
 *  SSpListener_GetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetVelocity(
  SSpListenerReference   inListenerReference,
  TQ3Vector3D *          outVelocity);


/*
 *  SSpListener_GetActualVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetActualVelocity(
  SSpListenerReference   inListenerReference,
  TQ3Vector3D *          outVelocity);


/*
 *  SSpListener_SetMedium()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetMedium(
  SSpListenerReference   inListenerReference,
  UInt32                 inMedium,
  float                  inHumidity);


/*
 *  SSpListener_GetMedium()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetMedium(
  SSpListenerReference   inListenerReference,
  UInt32 *               outMedium,
  float *                outHumidity);


/*
 *  SSpListener_SetReverb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetReverb(
  SSpListenerReference   inListenerReference,
  float                  inRoomSize,
  float                  inRoomReflectivity,
  float                  inReverbAttenuation);


/*
 *  SSpListener_GetReverb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetReverb(
  SSpListenerReference   inListenerReference,
  float *                outRoomSize,
  float *                outRoomReflectivity,
  float *                outReverbAttenuation);


/*
 *  SSpListener_SetMetersPerUnit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetMetersPerUnit(
  SSpListenerReference   inListenerReference,
  float                  inMetersPerUnit);


/*
 *  SSpListener_GetMetersPerUnit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetMetersPerUnit(
  SSpListenerReference   inListenerReference,
  float *                outMetersPerUnit);



/*******************************************************************************
 *  Routines for Manipulating Sources
 ******************************************************************************/
typedef struct OpaqueSSpSourceReference*  SSpSourceReference;
/*
 *  SSpSource_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_New(SSpSourceReference * outSourceReference);


/*
 *  SSpSource_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_Dispose(SSpSourceReference inSourceReference);


/*
 *  SSpSource_CalcLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_CalcLocalization(
  SSpSourceReference     inSourceReference,
  SSpListenerReference   inListenerReference,
  SSpLocalizationData *  out3DInfo);


/*
 *  SSpSource_SetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetTransform(
  SSpSourceReference    inSourceReference,
  const TQ3Matrix4x4 *  inTransform);


/*
 *  SSpSource_GetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetTransform(
  SSpSourceReference   inSourceReference,
  TQ3Matrix4x4 *       outTransform);


/*
 *  SSpSource_SetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetPosition(
  SSpSourceReference   inSourceReference,
  const TQ3Point3D *   inPosition);


/*
 *  SSpSource_GetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetPosition(
  SSpSourceReference   inSourceReference,
  TQ3Point3D *         outPosition);


/*
 *  SSpSource_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetOrientation(
  SSpSourceReference   inSourceReference,
  const TQ3Vector3D *  inOrientation);


/*
 *  SSpSource_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetOrientation(
  SSpSourceReference   inSourceReference,
  TQ3Vector3D *        outOrientation);


/*
 *  SSpSource_SetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetUpVector(
  SSpSourceReference   inSourceReference,
  const TQ3Vector3D *  inUpVector);


/*
 *  SSpSource_GetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetUpVector(
  SSpSourceReference   inSourceReference,
  TQ3Vector3D *        outUpVector);


/*
 *  SSpSource_SetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetCameraPlacement(
  SSpSourceReference          inSourceReference,
  const TQ3CameraPlacement *  inCameraPlacement);


/*
 *  SSpSource_GetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetCameraPlacement(
  SSpSourceReference    inSourceReference,
  TQ3CameraPlacement *  outCameraPlacement);


/*
 *  SSpSource_SetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetVelocity(
  SSpSourceReference   inSourceReference,
  const TQ3Vector3D *  inVelocity);


/*
 *  SSpSource_GetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetVelocity(
  SSpSourceReference   inSourceReference,
  TQ3Vector3D *        outVelocity);


/*
 *  SSpSource_GetActualVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetActualVelocity(
  SSpSourceReference   inSourceReference,
  TQ3Vector3D *        outVelocity);


/*
 *  SSpSource_SetCPULoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetCPULoad(
  SSpSourceReference   inSourceReference,
  UInt32               inCPULoad);


/*
 *  SSpSource_GetCPULoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetCPULoad(
  SSpSourceReference   inSourceReference,
  UInt32 *             outCPULoad);


/*
 *  SSpSource_SetMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetMode(
  SSpSourceReference   inSourceReference,
  UInt32               inMode);


/*
 *  SSpSource_GetMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetMode(
  SSpSourceReference   inSourceReference,
  UInt32 *             outMode);


/*
 *  SSpSource_SetReferenceDistance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetReferenceDistance(
  SSpSourceReference   inSourceReference,
  float                inReferenceDistance);


/*
 *  SSpSource_GetReferenceDistance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetReferenceDistance(
  SSpSourceReference   inSourceReference,
  float *              outReferenceDistance);


/*
 *  SSpSource_SetSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetSize(
  SSpSourceReference   inSourceReference,
  float                inLength,
  float                inWidth,
  float                inHeight);


/*
 *  SSpSource_GetSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetSize(
  SSpSourceReference   inSourceReference,
  float *              outLength,
  float *              outWidth,
  float *              outHeight);


/*
 *  SSpSource_SetAngularAttenuation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetAngularAttenuation(
  SSpSourceReference   inSourceReference,
  float                inConeAngle,
  float                inConeAttenuation);


/*
 *  SSpSource_GetAngularAttenuation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetAngularAttenuation(
  SSpSourceReference   inSourceReference,
  float *              outConeAngle,
  float *              outConeAttenuation);


/*******************************************************************************
 *  OpenGL Calling Convention Call Variants
 ******************************************************************************/
/*
 *  SSpListener_SetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetTransformfv(
  SSpListenerReference   inListenerReference,
  const float *          inTransform);


/*
 *  SSpListener_GetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetTransformfv(
  SSpListenerReference   inListenerReference,
  float *                outTransform);


/*
 *  SSpListener_SetPosition3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetPosition3f(
  SSpListenerReference   inListenerReference,
  float                  inX,
  float                  inY,
  float                  inZ);


/*
 *  SSpListener_SetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetPositionfv(
  SSpListenerReference   inListenerReference,
  const float *          inPosition);


/*
 *  SSpListener_GetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetPositionfv(
  SSpListenerReference   inListenerReference,
  float *                outPosition);


/*
 *  SSpListener_SetOrientation3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetOrientation3f(
  SSpListenerReference   inListenerReference,
  float                  inX,
  float                  inY,
  float                  inZ);


/*
 *  SSpListener_SetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetOrientationfv(
  SSpListenerReference   inListenerReference,
  const float *          inOrientation);


/*
 *  SSpListener_GetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetOrientationfv(
  SSpListenerReference   inListenerReference,
  float *                outOrientation);


/*
 *  SSpListener_SetUpVector3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetUpVector3f(
  SSpListenerReference   inListenerReference,
  float                  inX,
  float                  inY,
  float                  inZ);


/*
 *  SSpListener_SetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetUpVectorfv(
  SSpListenerReference   inListenerReference,
  const float *          inUpVector);


/*
 *  SSpListener_GetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetUpVectorfv(
  SSpListenerReference   inListenerReference,
  float *                outUpVector);


/*
 *  SSpListener_SetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetCameraPlacementfv(
  SSpListenerReference   inListenerReference,
  const float *          inCameraLocation,
  const float *          inPointOfInterest,
  const float *          inUpVector);


/*
 *  SSpListener_GetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetCameraPlacementfv(
  SSpListenerReference   inListenerReference,
  float *                outCameraPlacement,
  float *                outPointOfInterest,
  float *                outUpVector);


/*
 *  SSpListener_SetVelocity3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetVelocity3f(
  SSpListenerReference   inListenerReference,
  float                  inX,
  float                  inY,
  float                  inZ);


/*
 *  SSpListener_SetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_SetVelocityfv(
  SSpListenerReference   inListenerReference,
  const float *          inVelocity);


/*
 *  SSpListener_GetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetVelocityfv(
  SSpListenerReference   inListenerReference,
  float *                outVelocity);


/*
 *  SSpListener_GetActualVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpListener_GetActualVelocityfv(
  SSpListenerReference   inListenerReference,
  float *                outVelocity);


/*
 *  SSpSource_SetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetTransformfv(
  SSpSourceReference   inSourceReference,
  const float *        inTransform);


/*
 *  SSpSource_GetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetTransformfv(
  SSpSourceReference   inSourceReference,
  float *              outTransform);


/*
 *  SSpSource_SetPosition3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetPosition3f(
  SSpSourceReference   inSourceReference,
  float                inX,
  float                inY,
  float                inZ);


/*
 *  SSpSource_SetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetPositionfv(
  SSpSourceReference   inSourceReference,
  const float *        inPosition);


/*
 *  SSpSource_GetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetPositionfv(
  SSpSourceReference   inSourceReference,
  float *              outPosition);


/*
 *  SSpSource_SetOrientation3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetOrientation3f(
  SSpSourceReference   inSourceReference,
  float                inX,
  float                inY,
  float                inZ);


/*
 *  SSpSource_SetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetOrientationfv(
  SSpSourceReference   inSourceReference,
  const float *        inOrientation);


/*
 *  SSpSource_GetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetOrientationfv(
  SSpSourceReference   inSourceReference,
  float *              outOrientation);


/*
 *  SSpSource_SetUpVector3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetUpVector3f(
  SSpSourceReference   inSourceReference,
  float                inX,
  float                inY,
  float                inZ);


/*
 *  SSpSource_SetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetUpVectorfv(
  SSpSourceReference   inSourceReference,
  const float *        inUpVector);


/*
 *  SSpSource_GetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetUpVectorfv(
  SSpSourceReference   inSourceReference,
  float *              outUpVector);


/*
 *  SSpSource_SetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetCameraPlacementfv(
  SSpSourceReference   inSourceReference,
  const float *        inCameraLocation,
  const float *        inPointOfInterest,
  const float *        inUpVector);


/*
 *  SSpSource_GetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetCameraPlacementfv(
  SSpSourceReference   inSourceReference,
  float *              outCameraPlacement,
  float *              outPointOfInterest,
  float *              outUpVector);


/*
 *  SSpSource_SetVelocity3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetVelocity3f(
  SSpSourceReference   inSourceReference,
  float                inX,
  float                inY,
  float                inZ);


/*
 *  SSpSource_SetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_SetVelocityfv(
  SSpSourceReference   inSourceReference,
  const float *        inVelocity);


/*
 *  SSpSource_GetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetVelocityfv(
  SSpSourceReference   inSourceReference,
  float *              outVelocity);


/*
 *  SSpSource_GetActualVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
SSpSource_GetActualVelocityfv(
  SSpSourceReference   inSourceReference,
  float *              outVelocity);


#endif  /* TARGET_CPU_PPC */


/*******************************************************************************
 *  LATE-BREAKING NEWS
 *
 *  After the documentation was completed, it was decided that the SSpSetup
 *  were not specific enough.  We renamed them to SSpSpeakerSetup.  These
 *  #defines allow code to be written per the documentation.  But please use
 *  the new, longer names, as the #defines will be removed in a later release.
 ******************************************************************************/
#define SSpConfigureSetup       SSpConfigureSpeakerSetup

#define siSSpSetup              siSSpSpeakerSetup
#define SSpSetupData            SSpSpeakerSetupData


/*******************************************************************************
 *  MORE LATE-BREAKING NEWS
 *
 *  The SndGetInfo selector siSSpFilterVersion and datatype SSpFilterVersionData
 *  have been removed in favor of an alternate way of accessing filter version
 *  information.  The following function may be used for this purpose.
 *******************************************************************************
// **************************** GetSSpFilterVersion ****************************
// Finds the manufacturer and version number of the SoundSprocket filter that
// may be installed.  inManufacturer should be the manufacturer code specified
// at the installation time, which may be zero to allow any manufacturer.
// If no error is encountered, outManufacturer is set to the actual manufacturer
// code and outMajorVersion and outMinorVersion are set to the component
// specification level and manufacturer's implementation revision, respectively.
OSStatus GetSSpFilterVersion(
    OSType                  inManufacturer,
    OSType*                 outManufacturer,
    UInt32*                 outMajorVersion,
    UInt32*                 outMinorVersion)
{
    OSStatus                err;
    ComponentDescription    description;
    Component               componentRef;
    UInt32                  vers;
    
    // Set up the component description
    description.componentType           = kSoundEffectsType;
    description.componentSubType        = kSSpLocalizationSubType;
    description.componentManufacturer   = inManufacturer;
    description.componentFlags          = 0;        
    description.componentFlagsMask      = 0;    
    
    // Find a component matching the description
    componentRef = FindNextComponent(nil, &description);
    if (componentRef == nil)  return couldntGetRequiredComponent;
    
    // Get the component description (for the manufacturer code)
    err = GetComponentInfo(componentRef, &description, nil, nil, nil);
    if (err != noErr)  return err;
    
    // Get the version composite
    vers = (UInt32) GetComponentVersion((ComponentInstance) componentRef);
    
    // Return the results
    *outManufacturer = description.componentManufacturer;
    *outMajorVersion = HiWord(vers);
    *outMinorVersion = LoWord(vers);
    
    return noErr;
}
*******************************************************************************/



#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SOUNDSPROCKET__ */


/*
 	File:		SoundSprocket.h
 
 	Contains:	Public interfaces for SoundSprocket
 
 	Version:	Technology:	Apple Game Sprockets 1.0
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
*/

#ifndef __SOUNDSPROCKET__
#define __SOUNDSPROCKET__

#ifndef __TYPES__
#include <Types.h>
#endif

/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef QD3D_h
#include <QD3D.h>
#endif

#ifndef QD3DCamera_h
#include <QD3DCamera.h>
#endif


#if GENERATINGPOWERPC

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=power
#endif


/*******************************************************************************
 *	• TODO: This stuff will be moved to Errors.h
 ******************************************************************************/
enum {
	kSSpInternalErr			= -30340,
	kSSpVersionErr			= -30341,
	kSSpCantInstallErr		= -30342,
	kSSpParallelUpVectorErr	= -30343,
	kSSpScaleToZeroErr		= -30344
};


/*******************************************************************************
 *	This stuff has been moved to Sound.h
 *
 *	If it is not there in your Sound.h, get a new one.  If you can't find the
 *	new one, #define __USING_OLD_SOUND_H__ 1 before you #include this file.
 ******************************************************************************/
#if defined(__USING_OLD_SOUND_H__) && __USING_OLD_SOUND_H__
	#ifndef __SOUNDCOMPONENTS__
		#include <SoundComponents.h>
	#endif
	
	enum {
	    siPreMixerSoundComponent	= 'prmx',
	    siPostMixerSoundComponent	= 'psmx',
	    kSoundEffectsType			= 'snfx'
	};
	
	struct SoundComponentLink {
		ComponentDescription 	description;/*Describes the sound component*/
		SoundSource 			mixerID;	/*Reserved by Apple*/
		SoundSource *			linkID;		/*Reserved by Apple*/
	};
	
	typedef struct SoundComponentLink SoundComponentLink;
	typedef SoundComponentLink *SoundComponentLinkPtr;
	
	/* Our subtype within kSoundEffectsType for siPreMixerSoundComponent */
	enum {
		kSSpLocalizationSubType		= 'snd3'
	};
	
	/* Selectors for SndSetInfo and SndGetInfo */
	enum {
		siSSpCPULoadLimit	= '3dll',		/* Parameter: UInt32, Get only			*/
		siSSpSpeakerSetup	= '3dst',		/* Parameter: SSpSpeakerSetupData, Set/Get*/
		siSSpLocalization	= '3dif'		/* Parameter: SSpLocalizationData, Set/Get*/
	};
#endif


/*******************************************************************************
 *	SndSetInfo/SndGetInfo Messages
 ******************************************************************************/
// The siSSpCPULoadLimit = '3dll' selector for SndGetInfo fills in a value of
// type UInt32.


enum {
	kSSpSpeakerKind_Stereo			= 0,
	kSSpSpeakerKind_Mono			= 1,
	kSSpSpeakerKind_Headphones		= 2
};


// This is the data type is used with the SndGet/SetInfo selector
// siSSpSpeakerSetup = '3dst'
typedef struct SSpSpeakerSetupData {
	UInt32				speakerKind;	/* Speaker configuration				*/
	float				speakerAngle;	/* Angle formed by user and speakers	*/

	UInt32				reserved0;		/* Reserved for future use -- set to 0	*/
	UInt32				reserved1;		/* Reserved for future use -- set to 0	*/
} SSpSpeakerSetupData;


enum {
	kSSpMedium_Air				= 0,
	kSSpMedium_Water			= 1
};


enum {
	kSSpSourceMode_Unfiltered	= 0,	/* No filtering applied					*/
	kSSpSourceMode_Localized	= 1,	/* Localized by source position			*/
	kSSpSourceMode_Ambient		= 2,	/* Coming from all around				*/
	kSSpSourceMode_Binaural		= 3		/* Already binaurally localized			*/
};


typedef struct SSpLocationData {
	float				elevation;		/* Angle of the meridian -- pos is up	*/
	float				azimuth;		/* Angle of the parallel -- pos is left	*/
	float				distance;		/* Distance between source and listener	*/
	float				projectionAngle;/* Cos(angle) between cone and listener	*/
	float				sourceVelocity;	/* Speed of source toward the listener	*/
	float				listenerVelocity;/*Speed of listener toward the source	*/
} SSpLocationData;


typedef struct SSpVirtualSourceData {
	float				attenuation;	/* Attenuation factor					*/
	SSpLocationData		location;		/* Location of virtual source			*/
} SSpVirtualSourceData;


// This is the data type is used with the SndGet/SetInfo selector
// siSSpLocalization = '3dif'
typedef struct SSpLocalizationData {
	UInt32				cpuLoad;		/* CPU load vs. quality -- 0 is best	*/
	
	UInt32				medium;			/* Medium for sound propagation			*/
	float				humidity;		/* Humidity when medium is air			*/
	float				roomSize;		/* Reverb model -- distance bet. walls	*/
	float				roomReflectivity;/*Reverb model -- bounce attenuation	*/
	float				reverbAttenuation;/*Reverb model -- mix level			*/

	UInt32				sourceMode;		/* Type of filtering to apply			*/
	float				referenceDistance;/*Nominal distance for recording		*/
	float				coneAngleCos;	/* Cos(angle/2) of attenuation cone		*/
	float				coneAttenuation;/* Attenuation outside the cone			*/
	SSpLocationData		currentLocation;/* Location of the sound 				*/

	UInt32				reserved0;		/* Reserved for future use -- set to 0	*/
	UInt32				reserved1;		/* Reserved for future use -- set to 0	*/
	UInt32				reserved2;		/* Reserved for future use -- set to 0	*/
	UInt32				reserved3;		/* Reserved for future use -- set to 0	*/

	UInt32				virtualSourceCount;/*Number of reflections				*/
	SSpVirtualSourceData virtualSource[4];/*The reflections						*/
} SSpLocalizationData;


typedef Boolean (*SSpEventProcPtr) (EventRecord* inEvent);


/*******************************************************************************
 *	Global functions
 ******************************************************************************/
OSStatus SSpConfigureSpeakerSetup(
	SSpEventProcPtr				inEventProcPtr);

OSStatus SSpGetCPULoadLimit(
	UInt32*						outCPULoadLimit);


/*******************************************************************************
 *	Routines for Maniulating Listeners
 ******************************************************************************/
typedef struct SSpListenerPrivate*	SSpListenerReference;

OSStatus SSpListener_New(
	SSpListenerReference*		outListenerReference);

OSStatus SSpListener_Dispose(
	SSpListenerReference		inListenerReference);

OSStatus SSpListener_SetTransform(
	SSpListenerReference		inListenerReference,
	const TQ3Matrix4x4*			inTransform);

OSStatus SSpListener_GetTransform(
	SSpListenerReference		inListenerReference,
	TQ3Matrix4x4*				outTransform);

OSStatus SSpListener_SetPosition(
	SSpListenerReference		inListenerReference,
	const TQ3Point3D*			inPosition);

OSStatus SSpListener_GetPosition(
	SSpListenerReference		inListenerReference,
	TQ3Point3D*					outPosition);

OSStatus SSpListener_SetOrientation(
	SSpListenerReference		inListenerReference,
	const TQ3Vector3D*			inOrientation);

OSStatus SSpListener_GetOrientation(
	SSpListenerReference		inListenerReference,
	TQ3Vector3D*				outOrientation);

OSStatus SSpListener_SetUpVector(
	SSpListenerReference		inListenerReference,
	const TQ3Vector3D*			inUpVector);

OSStatus SSpListener_GetUpVector(
	SSpListenerReference		inListenerReference,
	TQ3Vector3D*				outUpVector);

OSStatus SSpListener_SetCameraPlacement(
	SSpListenerReference		inListenerReference,
	const TQ3CameraPlacement*	inCameraPlacement);

OSStatus SSpListener_GetCameraPlacement(
	SSpListenerReference		inListenerReference,
	TQ3CameraPlacement*			outCameraPlacement);

OSStatus SSpListener_SetVelocity(
	SSpListenerReference		inListenerReference,
	const TQ3Vector3D*			inVelocity);

OSStatus SSpListener_GetVelocity(
	SSpListenerReference		inListenerReference,
	TQ3Vector3D*				outVelocity);

OSStatus SSpListener_GetActualVelocity(
	SSpListenerReference		inListenerReference,
	TQ3Vector3D*				outVelocity);

OSStatus SSpListener_SetMedium(
	SSpListenerReference		inListenerReference,
	UInt32						inMedium,
	float						inHumidity);

OSStatus SSpListener_GetMedium(
	SSpListenerReference		inListenerReference,
	UInt32*						outMedium,
	float*						outHumidity);

OSStatus SSpListener_SetReverb(
	SSpListenerReference		inListenerReference,
	float						inRoomSize,
	float						inRoomReflectivity,
	float						inReverbAttenuation);

OSStatus SSpListener_GetReverb(
	SSpListenerReference		inListenerReference,
	float*						outRoomSize,
	float*						outRoomReflectivity,
	float*						outReverbAttenuation);

OSStatus SSpListener_SetMetersPerUnit(
	SSpListenerReference		inListenerReference,
	float						inMetersPerUnit);

OSStatus SSpListener_GetMetersPerUnit(
	SSpListenerReference		inListenerReference,
	float*						outMetersPerUnit);


/*******************************************************************************
 *	Routines for Manipulating Sources
 ******************************************************************************/
typedef struct SSpSourcePrivate*	SSpSourceReference;

OSStatus SSpSource_New(
	SSpSourceReference*			outSourceReference);

OSStatus SSpSource_Dispose(
	SSpSourceReference			inSourceReference);

OSStatus SSpSource_CalcLocalization(
	SSpSourceReference			inSourceReference,
	SSpListenerReference		inListenerReference,
	SSpLocalizationData*		out3DInfo);

OSStatus SSpSource_SetTransform(
	SSpSourceReference			inSourceReference,
	const TQ3Matrix4x4*			inTransform);

OSStatus SSpSource_GetTransform(
	SSpSourceReference			inSourceReference,
	TQ3Matrix4x4*				outTransform);

OSStatus SSpSource_SetPosition(
	SSpSourceReference			inSourceReference,
	const TQ3Point3D*			inPosition);

OSStatus SSpSource_GetPosition(
	SSpSourceReference			inSourceReference,
	TQ3Point3D*					outPosition);

OSStatus SSpSource_SetOrientation(
	SSpSourceReference			inSourceReference,
	const TQ3Vector3D*			inOrientation);

OSStatus SSpSource_GetOrientation(
	SSpSourceReference			inSourceReference,
	TQ3Vector3D*				outOrientation);

OSStatus SSpSource_SetUpVector(
	SSpSourceReference			inSourceReference,
	const TQ3Vector3D*			inUpVector);

OSStatus SSpSource_GetUpVector(
	SSpSourceReference			inSourceReference,
	TQ3Vector3D*				outUpVector);

OSStatus SSpSource_SetCameraPlacement(
	SSpSourceReference			inSourceReference,
	const TQ3CameraPlacement*	inCameraPlacement);

OSStatus SSpSource_GetCameraPlacement(
	SSpSourceReference			inSourceReference,
	TQ3CameraPlacement*			outCameraPlacement);

OSStatus SSpSource_SetVelocity(
	SSpSourceReference			inSourceReference,
	const TQ3Vector3D*			inVelocity);

OSStatus SSpSource_GetVelocity(
	SSpSourceReference			inSourceReference,
	TQ3Vector3D*				outVelocity);

OSStatus SSpSource_GetActualVelocity(
	SSpSourceReference			inSourceReference,
	TQ3Vector3D*				outVelocity);

OSStatus SSpSource_SetCPULoad(
	SSpSourceReference			inSourceReference,
	UInt32						inCPULoad);

OSStatus SSpSource_GetCPULoad(
	SSpSourceReference			inSourceReference,
	UInt32*						outCPULoad);

OSStatus SSpSource_SetMode(
	SSpSourceReference			inSourceReference,
	UInt32						inMode);

OSStatus SSpSource_GetMode(
	SSpSourceReference			inSourceReference,
	UInt32*						outMode);

OSStatus SSpSource_SetReferenceDistance(
	SSpSourceReference			inSourceReference,
	float						inReferenceDistance);

OSStatus SSpSource_GetReferenceDistance(
	SSpSourceReference			inSourceReference,
	float*						outReferenceDistance);

OSStatus SSpSource_SetSize(
	SSpSourceReference			inSourceReference,
	float						inLength,
	float						inWidth,
	float						inHeight);

OSStatus SSpSource_GetSize(
	SSpSourceReference			inSourceReference,
	float*						outLength,
	float*						outWidth,
	float*						outHeight);

OSStatus SSpSource_SetAngularAttenuation(
	SSpSourceReference			inSourceReference,
	float						inConeAngle,
	float						inConeAttenuation);

OSStatus SSpSource_GetAngularAttenuation(
	SSpSourceReference			inSourceReference,
	float*						outConeAngle,
	float*						outConeAttenuation);


/*******************************************************************************
 *	LATE-BREAKING NEWS
 *
 *	After the documentation was completed, it was decided that the SSpSetup
 *	were not specific enough.  We renamed them to SSpSpeakerSetup.  These
 *	#defines allow code to be written per the documentation.  But please use
 *	the new, longer names, as the #defines will be removed in a later release.
 ******************************************************************************/
#define siSSpSetup				siSSpSpeakerSetup
#define SSpSetupData			SSpSpeakerSetupData
#define SSpConfigureSetup		SSpConfigureSpeakerSetup


/*******************************************************************************
 *	MORE LATE-BREAKING NEWS
 *
 *	The SndGetInfo selector siSSpFilterVersion and datatype SSpFilterVersionData
 *	have been removed in favor of an alternate way of accessing filter version
 *	information.  The following function may be used for this purpose.
 *******************************************************************************
// **************************** GetSSpFilterVersion ****************************
// Finds the manufacturer and version number of the SoundSprocket filter that
// may be installed.  inManufacturer should be the manufacturer code specified
// at the installation time, which may be zero to allow any manufacturer.
// If no error is encountered, outManufacturer is set to the actual manufacturer
// code and outMajorVersion and outMinorVersion are set to the component
// specification level and manufacturer's implementation revision, respectively.
OSStatus GetSSpFilterVersion(
	OSType					inManufacturer,
	OSType*					outManufacturer,
	UInt32*					outMajorVersion,
	UInt32*					outMinorVersion)
{
	OSStatus				err;
	ComponentDescription	description;
	Component				componentRef;
	UInt32					vers;
	
	// Set up the component description
    description.componentType			= kSoundEffectsType;
    description.componentSubType		= kSSpLocalizationSubType;
    description.componentManufacturer	= inManufacturer;
    description.componentFlags			= 0;        
    description.componentFlagsMask		= 0;    
	
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


#ifdef __cplusplus
}
#endif



#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif /* GENERATINGPOWERPC */
#endif /* __SOUNDSPROCKET__ */

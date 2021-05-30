{
     File:       SoundSprocket.p
 
     Contains:   SoundSprocket interfaces
 
     Version:    Technology: 1.7
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SoundSprocket;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDSPROCKET__}
{$SETC __SOUNDSPROCKET__ := 1}

{$I+}
{$SETC SoundSprocketIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DCAMERA__}
{$I QD3DCamera.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{******************************************************************************
 *  SndSetInfo/SndGetInfo Messages
 *****************************************************************************}
{  The siSSpCPULoadLimit = '3dll' selector for SndGetInfo fills in a value of  }
{  type UInt32.                                                                }


CONST
	kSSpSpeakerKind_Stereo		= 0;
	kSSpSpeakerKind_Mono		= 1;
	kSSpSpeakerKind_Headphones	= 2;


	{	  This is the data type is used with the SndGet/SetInfo selector              	}
	{	  siSSpSpeakerSetup = '3dst'                                                  	}

TYPE
	SSpSpeakerSetupDataPtr = ^SSpSpeakerSetupData;
	SSpSpeakerSetupData = RECORD
		speakerKind:			UInt32;									{  Speaker configuration           }
		speakerAngle:			Single;									{  Angle formed by user and speakers   }
		reserved0:				UInt32;									{  Reserved for future use -- set to 0     }
		reserved1:				UInt32;									{  Reserved for future use -- set to 0     }
	END;


CONST
	kSSpMedium_Air				= 0;
	kSSpMedium_Water			= 1;


	kSSpSourceMode_Unfiltered	= 0;							{  No filtering applied              }
	kSSpSourceMode_Localized	= 1;							{  Localized by source position       }
	kSSpSourceMode_Ambient		= 2;							{  Coming from all around           }
	kSSpSourceMode_Binaural		= 3;							{  Already binaurally localized       }



TYPE
	SSpLocationDataPtr = ^SSpLocationData;
	SSpLocationData = RECORD
		elevation:				Single;									{  Angle of the meridian -- pos is up  }
		azimuth:				Single;									{  Angle of the parallel -- pos is left    }
		distance:				Single;									{  Distance between source and listener    }
		projectionAngle:		Single;									{  Cos(angle) between cone and listener    }
		sourceVelocity:			Single;									{  Speed of source toward the listener     }
		listenerVelocity:		Single;									{ Speed of listener toward the source  }
	END;

	SSpVirtualSourceDataPtr = ^SSpVirtualSourceData;
	SSpVirtualSourceData = RECORD
		attenuation:			Single;									{  Attenuation factor            }
		location:				SSpLocationData;						{  Location of virtual source         }
	END;

	{	  This is the data type is used with the SndGet/SetInfo selector              	}
	{	  siSSpLocalization = '3dif'                                                  	}
	SSpLocalizationDataPtr = ^SSpLocalizationData;
	SSpLocalizationData = RECORD
		cpuLoad:				UInt32;									{  CPU load vs. quality -- 0 is best   }
		medium:					UInt32;									{  Medium for sound propagation       }
		humidity:				Single;									{  Humidity when medium is air          }
		roomSize:				Single;									{  Reverb model -- distance bet. walls     }
		roomReflectivity:		Single;									{ Reverb model -- bounce attenuation   }
		reverbAttenuation:		Single;									{ Reverb model -- mix level       }
		sourceMode:				UInt32;									{  Type of filtering to apply         }
		referenceDistance:		Single;									{ Nominal distance for recording    }
		coneAngleCos:			Single;									{  Cos(angle/2) of attenuation cone      }
		coneAttenuation:		Single;									{  Attenuation outside the cone       }
		currentLocation:		SSpLocationData;						{  Location of the sound            }
		reserved0:				UInt32;									{  Reserved for future use -- set to 0     }
		reserved1:				UInt32;									{  Reserved for future use -- set to 0     }
		reserved2:				UInt32;									{  Reserved for future use -- set to 0     }
		reserved3:				UInt32;									{  Reserved for future use -- set to 0     }
		virtualSourceCount:		UInt32;									{ Number of reflections           }
		virtualSource:			ARRAY [0..3] OF SSpVirtualSourceData;	{ The reflections                }
	END;

{$IFC TARGET_CPU_PPC }
{$IFC TYPED_FUNCTION_POINTERS}
	SSpEventProcPtr = FUNCTION(VAR inEvent: EventRecord): BOOLEAN; C;
{$ELSEC}
	SSpEventProcPtr = ProcPtr;
{$ENDC}


	{	******************************************************************************
	 *  Global functions
	 *****************************************************************************	}
	{
	 *  SSpConfigureSpeakerSetup()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION SSpConfigureSpeakerSetup(inEventProcPtr: SSpEventProcPtr): OSStatus; C;

{
 *  SSpGetCPULoadLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpGetCPULoadLimit(VAR outCPULoadLimit: UInt32): OSStatus; C;


{******************************************************************************
 *  Routines for Maniulating Listeners
 *****************************************************************************}

TYPE
	SSpListenerReference    = ^LONGINT; { an opaque 32-bit type }
	SSpListenerReferencePtr = ^SSpListenerReference;  { when a VAR xx:SSpListenerReference parameter can be nil, it is changed to xx: SSpListenerReferencePtr }
	{
	 *  SSpListener_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION SSpListener_New(VAR outListenerReference: SSpListenerReference): OSStatus; C;

{
 *  SSpListener_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_Dispose(inListenerReference: SSpListenerReference): OSStatus; C;

{
 *  SSpListener_SetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetTransform(inListenerReference: SSpListenerReference; {CONST}VAR inTransform: TQ3Matrix4x4): OSStatus; C;

{
 *  SSpListener_GetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetTransform(inListenerReference: SSpListenerReference; VAR outTransform: TQ3Matrix4x4): OSStatus; C;

{
 *  SSpListener_SetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetPosition(inListenerReference: SSpListenerReference; {CONST}VAR inPosition: TQ3Point3D): OSStatus; C;

{
 *  SSpListener_GetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetPosition(inListenerReference: SSpListenerReference; VAR outPosition: TQ3Point3D): OSStatus; C;

{
 *  SSpListener_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetOrientation(inListenerReference: SSpListenerReference; {CONST}VAR inOrientation: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetOrientation(inListenerReference: SSpListenerReference; VAR outOrientation: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_SetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetUpVector(inListenerReference: SSpListenerReference; {CONST}VAR inUpVector: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_GetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetUpVector(inListenerReference: SSpListenerReference; VAR outUpVector: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_SetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetCameraPlacement(inListenerReference: SSpListenerReference; {CONST}VAR inCameraPlacement: TQ3CameraPlacement): OSStatus; C;

{
 *  SSpListener_GetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetCameraPlacement(inListenerReference: SSpListenerReference; VAR outCameraPlacement: TQ3CameraPlacement): OSStatus; C;

{
 *  SSpListener_SetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetVelocity(inListenerReference: SSpListenerReference; {CONST}VAR inVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_GetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetVelocity(inListenerReference: SSpListenerReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_GetActualVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetActualVelocity(inListenerReference: SSpListenerReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpListener_SetMedium()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetMedium(inListenerReference: SSpListenerReference; inMedium: UInt32; inHumidity: Single): OSStatus; C;

{
 *  SSpListener_GetMedium()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetMedium(inListenerReference: SSpListenerReference; VAR outMedium: UInt32; VAR outHumidity: Single): OSStatus; C;

{
 *  SSpListener_SetReverb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetReverb(inListenerReference: SSpListenerReference; inRoomSize: Single; inRoomReflectivity: Single; inReverbAttenuation: Single): OSStatus; C;

{
 *  SSpListener_GetReverb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetReverb(inListenerReference: SSpListenerReference; VAR outRoomSize: Single; VAR outRoomReflectivity: Single; VAR outReverbAttenuation: Single): OSStatus; C;

{
 *  SSpListener_SetMetersPerUnit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetMetersPerUnit(inListenerReference: SSpListenerReference; inMetersPerUnit: Single): OSStatus; C;

{
 *  SSpListener_GetMetersPerUnit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetMetersPerUnit(inListenerReference: SSpListenerReference; VAR outMetersPerUnit: Single): OSStatus; C;


{******************************************************************************
 *  Routines for Manipulating Sources
 *****************************************************************************}

TYPE
	SSpSourceReference    = ^LONGINT; { an opaque 32-bit type }
	SSpSourceReferencePtr = ^SSpSourceReference;  { when a VAR xx:SSpSourceReference parameter can be nil, it is changed to xx: SSpSourceReferencePtr }
	{
	 *  SSpSource_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
	 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
	 *    Mac OS X:         not available
	 	}
FUNCTION SSpSource_New(VAR outSourceReference: SSpSourceReference): OSStatus; C;

{
 *  SSpSource_Dispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_Dispose(inSourceReference: SSpSourceReference): OSStatus; C;

{
 *  SSpSource_CalcLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_CalcLocalization(inSourceReference: SSpSourceReference; inListenerReference: SSpListenerReference; VAR out3DInfo: SSpLocalizationData): OSStatus; C;

{
 *  SSpSource_SetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetTransform(inSourceReference: SSpSourceReference; {CONST}VAR inTransform: TQ3Matrix4x4): OSStatus; C;

{
 *  SSpSource_GetTransform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetTransform(inSourceReference: SSpSourceReference; VAR outTransform: TQ3Matrix4x4): OSStatus; C;

{
 *  SSpSource_SetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetPosition(inSourceReference: SSpSourceReference; {CONST}VAR inPosition: TQ3Point3D): OSStatus; C;

{
 *  SSpSource_GetPosition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetPosition(inSourceReference: SSpSourceReference; VAR outPosition: TQ3Point3D): OSStatus; C;

{
 *  SSpSource_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetOrientation(inSourceReference: SSpSourceReference; {CONST}VAR inOrientation: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetOrientation(inSourceReference: SSpSourceReference; VAR outOrientation: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_SetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetUpVector(inSourceReference: SSpSourceReference; {CONST}VAR inUpVector: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_GetUpVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetUpVector(inSourceReference: SSpSourceReference; VAR outUpVector: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_SetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetCameraPlacement(inSourceReference: SSpSourceReference; {CONST}VAR inCameraPlacement: TQ3CameraPlacement): OSStatus; C;

{
 *  SSpSource_GetCameraPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetCameraPlacement(inSourceReference: SSpSourceReference; VAR outCameraPlacement: TQ3CameraPlacement): OSStatus; C;

{
 *  SSpSource_SetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetVelocity(inSourceReference: SSpSourceReference; {CONST}VAR inVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_GetVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetVelocity(inSourceReference: SSpSourceReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_GetActualVelocity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetActualVelocity(inSourceReference: SSpSourceReference; VAR outVelocity: TQ3Vector3D): OSStatus; C;

{
 *  SSpSource_SetCPULoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetCPULoad(inSourceReference: SSpSourceReference; inCPULoad: UInt32): OSStatus; C;

{
 *  SSpSource_GetCPULoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetCPULoad(inSourceReference: SSpSourceReference; VAR outCPULoad: UInt32): OSStatus; C;

{
 *  SSpSource_SetMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetMode(inSourceReference: SSpSourceReference; inMode: UInt32): OSStatus; C;

{
 *  SSpSource_GetMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetMode(inSourceReference: SSpSourceReference; VAR outMode: UInt32): OSStatus; C;

{
 *  SSpSource_SetReferenceDistance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetReferenceDistance(inSourceReference: SSpSourceReference; inReferenceDistance: Single): OSStatus; C;

{
 *  SSpSource_GetReferenceDistance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetReferenceDistance(inSourceReference: SSpSourceReference; VAR outReferenceDistance: Single): OSStatus; C;

{
 *  SSpSource_SetSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetSize(inSourceReference: SSpSourceReference; inLength: Single; inWidth: Single; inHeight: Single): OSStatus; C;

{
 *  SSpSource_GetSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetSize(inSourceReference: SSpSourceReference; VAR outLength: Single; VAR outWidth: Single; VAR outHeight: Single): OSStatus; C;

{
 *  SSpSource_SetAngularAttenuation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetAngularAttenuation(inSourceReference: SSpSourceReference; inConeAngle: Single; inConeAttenuation: Single): OSStatus; C;

{
 *  SSpSource_GetAngularAttenuation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.0 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetAngularAttenuation(inSourceReference: SSpSourceReference; VAR outConeAngle: Single; VAR outConeAttenuation: Single): OSStatus; C;

{******************************************************************************
 *  OpenGL Calling Convention Call Variants
 *****************************************************************************}
{
 *  SSpListener_SetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetTransformfv(inListenerReference: SSpListenerReference; {CONST}VAR inTransform: Single): OSStatus; C;

{
 *  SSpListener_GetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetTransformfv(inListenerReference: SSpListenerReference; VAR outTransform: Single): OSStatus; C;

{
 *  SSpListener_SetPosition3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetPosition3f(inListenerReference: SSpListenerReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpListener_SetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetPositionfv(inListenerReference: SSpListenerReference; {CONST}VAR inPosition: Single): OSStatus; C;

{
 *  SSpListener_GetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetPositionfv(inListenerReference: SSpListenerReference; VAR outPosition: Single): OSStatus; C;

{
 *  SSpListener_SetOrientation3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetOrientation3f(inListenerReference: SSpListenerReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpListener_SetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetOrientationfv(inListenerReference: SSpListenerReference; {CONST}VAR inOrientation: Single): OSStatus; C;

{
 *  SSpListener_GetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetOrientationfv(inListenerReference: SSpListenerReference; VAR outOrientation: Single): OSStatus; C;

{
 *  SSpListener_SetUpVector3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetUpVector3f(inListenerReference: SSpListenerReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpListener_SetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetUpVectorfv(inListenerReference: SSpListenerReference; {CONST}VAR inUpVector: Single): OSStatus; C;

{
 *  SSpListener_GetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetUpVectorfv(inListenerReference: SSpListenerReference; VAR outUpVector: Single): OSStatus; C;

{
 *  SSpListener_SetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetCameraPlacementfv(inListenerReference: SSpListenerReference; {CONST}VAR inCameraLocation: Single; {CONST}VAR inPointOfInterest: Single; {CONST}VAR inUpVector: Single): OSStatus; C;

{
 *  SSpListener_GetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetCameraPlacementfv(inListenerReference: SSpListenerReference; VAR outCameraPlacement: Single; VAR outPointOfInterest: Single; VAR outUpVector: Single): OSStatus; C;

{
 *  SSpListener_SetVelocity3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetVelocity3f(inListenerReference: SSpListenerReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpListener_SetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_SetVelocityfv(inListenerReference: SSpListenerReference; {CONST}VAR inVelocity: Single): OSStatus; C;

{
 *  SSpListener_GetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetVelocityfv(inListenerReference: SSpListenerReference; VAR outVelocity: Single): OSStatus; C;

{
 *  SSpListener_GetActualVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpListener_GetActualVelocityfv(inListenerReference: SSpListenerReference; VAR outVelocity: Single): OSStatus; C;

{
 *  SSpSource_SetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetTransformfv(inSourceReference: SSpSourceReference; {CONST}VAR inTransform: Single): OSStatus; C;

{
 *  SSpSource_GetTransformfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetTransformfv(inSourceReference: SSpSourceReference; VAR outTransform: Single): OSStatus; C;

{
 *  SSpSource_SetPosition3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetPosition3f(inSourceReference: SSpSourceReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpSource_SetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetPositionfv(inSourceReference: SSpSourceReference; {CONST}VAR inPosition: Single): OSStatus; C;

{
 *  SSpSource_GetPositionfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetPositionfv(inSourceReference: SSpSourceReference; VAR outPosition: Single): OSStatus; C;

{
 *  SSpSource_SetOrientation3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetOrientation3f(inSourceReference: SSpSourceReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpSource_SetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetOrientationfv(inSourceReference: SSpSourceReference; {CONST}VAR inOrientation: Single): OSStatus; C;

{
 *  SSpSource_GetOrientationfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetOrientationfv(inSourceReference: SSpSourceReference; VAR outOrientation: Single): OSStatus; C;

{
 *  SSpSource_SetUpVector3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetUpVector3f(inSourceReference: SSpSourceReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpSource_SetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetUpVectorfv(inSourceReference: SSpSourceReference; {CONST}VAR inUpVector: Single): OSStatus; C;

{
 *  SSpSource_GetUpVectorfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetUpVectorfv(inSourceReference: SSpSourceReference; VAR outUpVector: Single): OSStatus; C;

{
 *  SSpSource_SetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetCameraPlacementfv(inSourceReference: SSpSourceReference; {CONST}VAR inCameraLocation: Single; {CONST}VAR inPointOfInterest: Single; {CONST}VAR inUpVector: Single): OSStatus; C;

{
 *  SSpSource_GetCameraPlacementfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetCameraPlacementfv(inSourceReference: SSpSourceReference; VAR outCameraPlacement: Single; VAR outPointOfInterest: Single; VAR outUpVector: Single): OSStatus; C;

{
 *  SSpSource_SetVelocity3f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetVelocity3f(inSourceReference: SSpSourceReference; inX: Single; inY: Single; inZ: Single): OSStatus; C;

{
 *  SSpSource_SetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_SetVelocityfv(inSourceReference: SSpSourceReference; {CONST}VAR inVelocity: Single): OSStatus; C;

{
 *  SSpSource_GetVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetVelocityfv(inSourceReference: SSpSourceReference; VAR outVelocity: Single): OSStatus; C;

{
 *  SSpSource_GetActualVelocityfv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundSprocketLib 1.7 and later
 *    CarbonLib:        not in Carbon, but SoundSprocketLib is compatible with Carbon
 *    Mac OS X:         not available
 }
FUNCTION SSpSource_GetActualVelocityfv(inSourceReference: SSpSourceReference; VAR outVelocity: Single): OSStatus; C;

{$ENDC}  {TARGET_CPU_PPC}


{******************************************************************************
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
(
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
)
******************************************************************************}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundSprocketIncludes}

{$ENDC} {__SOUNDSPROCKET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

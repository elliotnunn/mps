/*
     File:       ICACamera.h
 
     Contains:   Digital still camera-specific selectors and structures
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __ICACAMERA__
#define __ICACAMERA__



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

/*
   -------------------------------------------------------------------------
                                Selectors           
   -------------------------------------------------------------------------
*/
enum {
                                        /* Camera properties*/
                                        /* Refer to section 13 of the PIMA 15740 (PTP) specification for*/
                                        /* descriptions and usage notes for these standard properties*/
  kICAPropertyCameraBatteryLevel = FOUR_CHAR_CODE('cbat'), /* UInt8   enum/range*/
  kICAPropertyCameraFunctionalMode = FOUR_CHAR_CODE('cfnm'), /* UInt16     enum*/
  kICAPropertyCameraImageSize   = FOUR_CHAR_CODE('cims'), /* CFString     enum/range*/
  kICAPropertyCameraCompressionSetting = FOUR_CHAR_CODE('ccst'), /* UInt8   enum/range*/
  kICAPropertyCameraWhiteBalance = FOUR_CHAR_CODE('cwbl'), /* UInt16     enum*/
  kICAPropertyCameraRGBGain     = FOUR_CHAR_CODE('crgb'), /* null terminated string enum/range*/
  kICAPropertyCameraFNumber     = FOUR_CHAR_CODE('cfst'), /* UInt16     enum*/
  kICAPropertyCameraFocalLength = FOUR_CHAR_CODE('cfoc'), /* UInt32     enum/range*/
  kICAPropertyCameraFocusDistance = FOUR_CHAR_CODE('cfcd'), /* UInt16     enum/range*/
  kICAPropertyCameraFocusMode   = FOUR_CHAR_CODE('cfmd'), /* UInt16     enum*/
  kICAPropertyCameraExposureMeteringMode = FOUR_CHAR_CODE('cexm'), /* UInt16     enum*/
  kICAPropertyCameraFlashMode   = FOUR_CHAR_CODE('cflm'), /* UInt16     enum*/
  kICAPropertyCameraExposureTime = FOUR_CHAR_CODE('cext'), /* UInt32     enum/range*/
  kICAPropertyCameraExposureProgramMode = FOUR_CHAR_CODE('cexp'), /* UInt16     enum*/
  kICAPropertyCameraExposureIndex = FOUR_CHAR_CODE('cexi'), /* UInt16     enum/range*/
  kICAPropertyCameraExposureBiasCompensation = FOUR_CHAR_CODE('cexb'), /* UInt16     enum/range*/
  kICAPropertyCameraDateTime    = FOUR_CHAR_CODE('cdtm'), /* null terminated string     none*/
  kICAPropertyCameraCaptureDelay = FOUR_CHAR_CODE('ccpd'), /* UInt32     enum/range*/
  kICAPropertyCameraStillCaptureMode = FOUR_CHAR_CODE('cstc'), /* UInt16     enum*/
  kICAPropertyCameraContrast    = FOUR_CHAR_CODE('ccon'), /* UInt8   enum/range*/
  kICAPropertyCameraSharpness   = FOUR_CHAR_CODE('csha'), /* UInt8   enum/range*/
  kICAPropertyCameraDigitalZoom = FOUR_CHAR_CODE('cdzm'), /* UInt8   enum/range*/
  kICAPropertyCameraEffectMode  = FOUR_CHAR_CODE('cfxm'), /* UInt16     enum*/
  kICAPropertyCameraBurstNumber = FOUR_CHAR_CODE('cbnm'), /* UInt16     enum/range*/
  kICAPropertyCameraBurstInterval = FOUR_CHAR_CODE('cbin'), /* UInt16     enum/range*/
  kICAPropertyCameraTimelapseNumber = FOUR_CHAR_CODE('ctln'), /* UInt16     enum/range*/
  kICAPropertyCameraTimelapseInterval = FOUR_CHAR_CODE('ctli'), /* UInt32     enum/range*/
  kICAPropertyCameraFocusMeteringMode = FOUR_CHAR_CODE('cfmm') /* UInt16     enum*/
};

enum {
                                        /* Refer to section 5.5.3 of the PTP spec*/
  kICAPropertyCameraStorageType = FOUR_CHAR_CODE('stor'), /* UInt16*/
  kICAPropertyCameraFilesystemType = FOUR_CHAR_CODE('fsys'), /* UInt16*/
  kICAPropertyCameraAccessCapability = FOUR_CHAR_CODE('acap'), /* UInt16*/
  kICAPropertyCameraMaxCapacity = FOUR_CHAR_CODE('maxc'), /* UInt64*/
  kICAPropertyCameraFreeSpaceInBytes = FOUR_CHAR_CODE('fres'), /* UInt64*/
  kICAPropertyCameraFreeSpaceInImages = FOUR_CHAR_CODE('frei'), /* UInt32*/
  kICAPropertyCameraStorageDescription = FOUR_CHAR_CODE('stod'), /* null terminated string*/
  kICAPropertyCameraVolumeLabel = FOUR_CHAR_CODE('voll'), /* null terminated string*/
  kICAPropertyCameraIcon        = FOUR_CHAR_CODE('icon') /* ICAThumbnail*/
};

enum {
                                        /* Values for kICAPropertyCameraStorageType*/
  kICAStorageFixedROM           = 0x0001,
  kICAStorageRemovableROM       = 0x0002,
  kICAStorageFixedRAM           = 0x0003,
  kICAStorageRemovableRAM       = 0x0004
};

enum {
                                        /* Values for kICAPropertyCameraFilesystemType*/
  kICAFileystemGenericFlat      = 0x0001,
  kICAFileystemGenericHierarchical = 0x0002,
  kICAFileystemDCF              = 0x0003
};

enum {
                                        /* Values for kICAPropertyCameraAccessCapability*/
  kICAAccessReadWrite           = 0x0000,
  kICAAccessReadOnly            = 0x0001,
  kICAAccessReadOnlyWithObjectDeletion = 0x0002
};

enum {
                                        /* Camera messages*/
  kICAMessageCameraCaptureNewImage = FOUR_CHAR_CODE('ccni'),
  kICAMessageCameraDeleteOne    = FOUR_CHAR_CODE('del1'),
  kICAMessageCameraDeleteAll    = FOUR_CHAR_CODE('dela'),
  kICAMessageCameraSyncClock    = FOUR_CHAR_CODE('sclk')
};


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

#endif /* __ICACAMERA__ */


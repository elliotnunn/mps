{
     File:       ICACamera.p
 
     Contains:   Digital still camera-specific selectors and structures
 
     Version:    Technology: 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ICACamera;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICACAMERA__}
{$SETC __ICACAMERA__ := 1}

{$I+}
{$SETC ICACameraIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   -------------------------------------------------------------------------
                                Selectors           
   -------------------------------------------------------------------------
}

CONST
																{  Camera properties }
																{  Refer to section 13 of the PIMA 15740 (PTP) specification for }
																{  descriptions and usage notes for these standard properties }
	kICAPropertyCameraBatteryLevel = 'cbat';					{  UInt8   enum/range }
	kICAPropertyCameraFunctionalMode = 'cfnm';					{  UInt16     enum }
	kICAPropertyCameraImageSize	= 'cims';						{  CFString     enum/range }
	kICAPropertyCameraCompressionSetting = 'ccst';				{  UInt8   enum/range }
	kICAPropertyCameraWhiteBalance = 'cwbl';					{  UInt16     enum }
	kICAPropertyCameraRGBGain	= 'crgb';						{  null terminated string enum/range }
	kICAPropertyCameraFNumber	= 'cfst';						{  UInt16     enum }
	kICAPropertyCameraFocalLength = 'cfoc';						{  UInt32     enum/range }
	kICAPropertyCameraFocusDistance = 'cfcd';					{  UInt16     enum/range }
	kICAPropertyCameraFocusMode	= 'cfmd';						{  UInt16     enum }
	kICAPropertyCameraExposureMeteringMode = 'cexm';			{  UInt16     enum }
	kICAPropertyCameraFlashMode	= 'cflm';						{  UInt16     enum }
	kICAPropertyCameraExposureTime = 'cext';					{  UInt32     enum/range }
	kICAPropertyCameraExposureProgramMode = 'cexp';				{  UInt16     enum }
	kICAPropertyCameraExposureIndex = 'cexi';					{  UInt16     enum/range }
	kICAPropertyCameraExposureBiasCompensation = 'cexb';		{  UInt16     enum/range }
	kICAPropertyCameraDateTime	= 'cdtm';						{  null terminated string     none }
	kICAPropertyCameraCaptureDelay = 'ccpd';					{  UInt32     enum/range }
	kICAPropertyCameraStillCaptureMode = 'cstc';				{  UInt16     enum }
	kICAPropertyCameraContrast	= 'ccon';						{  UInt8   enum/range }
	kICAPropertyCameraSharpness	= 'csha';						{  UInt8   enum/range }
	kICAPropertyCameraDigitalZoom = 'cdzm';						{  UInt8   enum/range }
	kICAPropertyCameraEffectMode = 'cfxm';						{  UInt16     enum }
	kICAPropertyCameraBurstNumber = 'cbnm';						{  UInt16     enum/range }
	kICAPropertyCameraBurstInterval = 'cbin';					{  UInt16     enum/range }
	kICAPropertyCameraTimelapseNumber = 'ctln';					{  UInt16     enum/range }
	kICAPropertyCameraTimelapseInterval = 'ctli';				{  UInt32     enum/range }
	kICAPropertyCameraFocusMeteringMode = 'cfmm';				{  UInt16     enum }

																{  Refer to section 5.5.3 of the PTP spec }
	kICAPropertyCameraStorageType = 'stor';						{  UInt16 }
	kICAPropertyCameraFilesystemType = 'fsys';					{  UInt16 }
	kICAPropertyCameraAccessCapability = 'acap';				{  UInt16 }
	kICAPropertyCameraMaxCapacity = 'maxc';						{  UInt64 }
	kICAPropertyCameraFreeSpaceInBytes = 'fres';				{  UInt64 }
	kICAPropertyCameraFreeSpaceInImages = 'frei';				{  UInt32 }
	kICAPropertyCameraStorageDescription = 'stod';				{  null terminated string }
	kICAPropertyCameraVolumeLabel = 'voll';						{  null terminated string }
	kICAPropertyCameraIcon		= 'icon';						{  ICAThumbnail }

																{  Values for kICAPropertyCameraStorageType }
	kICAStorageFixedROM			= $0001;
	kICAStorageRemovableROM		= $0002;
	kICAStorageFixedRAM			= $0003;
	kICAStorageRemovableRAM		= $0004;

																{  Values for kICAPropertyCameraFilesystemType }
	kICAFileystemGenericFlat	= $0001;
	kICAFileystemGenericHierarchical = $0002;
	kICAFileystemDCF			= $0003;

																{  Values for kICAPropertyCameraAccessCapability }
	kICAAccessReadWrite			= $0000;
	kICAAccessReadOnly			= $0001;
	kICAAccessReadOnlyWithObjectDeletion = $0002;

																{  Camera messages }
	kICAMessageCameraCaptureNewImage = 'ccni';
	kICAMessageCameraDeleteOne	= 'del1';
	kICAMessageCameraDeleteAll	= 'dela';
	kICAMessageCameraSyncClock	= 'sclk';

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ICACameraIncludes}

{$ENDC} {__ICACAMERA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

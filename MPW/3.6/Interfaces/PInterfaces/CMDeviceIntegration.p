{
     File:       CMDeviceIntegration.p
 
     Contains:   Color Management Device Interfaces - for MacOSX
 
     Version:    Technology: ColorSync 3.1
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
 UNIT CMDeviceIntegration;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMDEVICEINTEGRATION__}
{$SETC __CMDEVICEINTEGRATION__ := 1}

{$I+}
{$SETC CMDeviceIntegrationIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}
{$IFC UNDEFINED __CMICCPROFILE__}
{$I CMICCProfile.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC TARGET_API_MAC_OSX }
{
    The current versions of the data structure
    containing information on registered devices.
}

CONST
	cmDeviceInfoVersion1		= $00010000;
	cmDeviceProfileInfoVersion1	= $00010000;

	cmCurrentDeviceInfoVersion	= $00010000;
	cmCurrentProfileInfoVersion	= $00010000;

	{	
	    Certain APIs require a device ID or profile ID.  
	    In some cases, a "default ID" can be used.
		}
	cmDefaultDeviceID			= 0;
	cmDefaultProfileID			= 0;

	{	
	    Possible values for device states accessible by the
	    CMGetDeviceState() and CMSetDeviceState() APIs.
		}
	cmDeviceStateDefault		= $00000000;
	cmDeviceStateOffline		= $00000001;
	cmDeviceStateBusy			= $00000002;
	cmDeviceStateForceNotify	= $80000000;
	cmDeviceStateDeviceRsvdBits	= $00FF0000;
	cmDeviceStateAppleRsvdBits	= $FF00FFFF;

	{	
	    Possible values for flags passed to the
	    CMIterateDeviceProfiles() API.
	    
	    "Factory" profiles are registered via the
	    CMSetDeviceFactoryProfiles() API.
	    
	    "Custom" profiles are those which are meant to take
	    the place of the factory profiles, as a result of
	    customization or calibration.  These profiles are
	    registered via the CMSetDeviceProfiles() API.
	    
	    To retrieve all of the the former for all devices,
	    use cmIterateFactoryDeviceProfiles as the flags
	    value when calling CMIterateDeviceProfiles().
	    
	    To retrieve only the latter for all devices, use
	    the cmIterateCustomDeviceProfiles, as the flags
	    value when calling CMIterateDeviceProfiles().
	    
	    To get the profiles in use for all devices, use
	    cmIterateCurrentDeviceProfiles as the flags value.
	    This will replace the factory profiles with any
	    overrides, yielding the currently used set.
		}
	cmIterateFactoryDeviceProfiles = $00000001;
	cmIterateCustomDeviceProfiles = $00000002;
	cmIterateCurrentDeviceProfiles = $00000003;
	cmIterateDeviceProfilesMask	= $00000003;

	kMaxDeviceNameLength		= 256;
	kMaxProfileNameLength		= 256;

	{	
	    Errors returned by CMDeviceIntegration APIs
		}
	cmDeviceDBNotFoundErr		= -4227;						{  Prefs not found/loaded  }
	cmDeviceAlreadyRegistered	= -4228;						{  Re-registration of device  }
	cmDeviceNotRegistered		= -4229;						{  Device not found  }
	cmDeviceProfilesNotFound	= -4230;						{  Profiles not found  }
	cmInternalCFErr				= -4231;						{  CoreFoundation failure  }

	{	
	    Device state data.
		}

TYPE
	CMDeviceState						= UInt32;
	{	
	    A CMDeviceID must be unique within a device's class.
		}
	CMDeviceID							= UInt32;
	{	
	    A CMDeviceProfileID must only be unique per device.
		}
	CMDeviceProfileID					= UInt32;
	{	
	    DeviceClass type.
		}

CONST
	cmScannerDeviceClass		= 'scnr';
	cmCameraDeviceClass			= 'cmra';
	cmDisplayDeviceClass		= 'mntr';
	cmPrinterDeviceClass		= 'prtr';
	cmProofDeviceClass			= 'pruf';


TYPE
	CMDeviceClass						= OSType;
	{	
	    CMDeviceScope
	    Structure specifying a device's or a device setting's scope.
		}
	CMDeviceScopePtr = ^CMDeviceScope;
	CMDeviceScope = RECORD
		deviceUser:				CFStringRef;							{  kCFPreferencesCurrentUser | _AnyUser  }
		deviceHost:				CFStringRef;							{  kCFPreferencesCurrentHost | _AnyHost  }
	END;

	{	
	    CMDeviceInfo
	    Structure containing information on a given device.
		}
	CMDeviceInfoPtr = ^CMDeviceInfo;
	CMDeviceInfo = RECORD
		dataVersion:			UInt32;									{  cmDeviceInfoVersion1  }
		deviceClass:			CMDeviceClass;							{  device class  }
		deviceID:				CMDeviceID;								{  device ID  }
		deviceScope:			CMDeviceScope;							{  device's scope  }
		deviceState:			CMDeviceState;							{  Device State flags  }
		defaultProfileID:		CMDeviceProfileID;						{  Can change  }
		deviceName:				^CFDictionaryRef;						{  Ptr to storage for CFDictionary of  }
																		{  localized device names (could be nil)  }
		profileCount:			UInt32;									{  Count of registered profiles  }
		reserved:				UInt32;									{  Reserved for use by ColorSync  }
	END;

	{	
	    CMDeviceProfileInfo
	    Structure containing information on a device profile.
		}
	CMDeviceProfileInfoPtr = ^CMDeviceProfileInfo;
	CMDeviceProfileInfo = RECORD
		dataVersion:			UInt32;									{  cmProfileInfoVersion1  }
		profileID:				CMDeviceProfileID;						{  The identifier for this profile  }
		profileLoc:				CMProfileLocation;						{  The profile's location  }
		profileName:			CFDictionaryRef;						{  CFDictionary of localized device names  }
		reserved:				UInt32;									{  Reserved for use by ColorSync  }
	END;

	{	
	    CMDeviceProfileArray
	    Structure containing the profiles for a device.
		}
	CMDeviceProfileArrayPtr = ^CMDeviceProfileArray;
	CMDeviceProfileArray = RECORD
		profileCount:			UInt32;									{  Count of profiles in array  }
		profiles:				ARRAY [0..0] OF CMDeviceProfileInfo;	{  The profile info records  }
	END;

	{	
	    Caller-supplied iterator functions
		}
{$IFC TYPED_FUNCTION_POINTERS}
	CMIterateDeviceInfoProcPtr = FUNCTION({CONST}VAR deviceInfo: CMDeviceInfo; refCon: UNIV Ptr): OSErr; C;
{$ELSEC}
	CMIterateDeviceInfoProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CMIterateDeviceProfileProcPtr = FUNCTION({CONST}VAR deviceInfo: CMDeviceInfo; {CONST}VAR profileData: CMDeviceProfileInfo; refCon: UNIV Ptr): OSErr; C;
{$ELSEC}
	CMIterateDeviceProfileProcPtr = ProcPtr;
{$ENDC}

	{	
	    Device Registration
		}
	{
	 *  CMRegisterColorDevice()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in 3.1 and later
	 	}
FUNCTION CMRegisterColorDevice(deviceClass: CMDeviceClass; deviceID: CMDeviceID; deviceName: CFDictionaryRef; {CONST}VAR deviceScope: CMDeviceScope): CMError;

{
 *  CMUnregisterColorDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMUnregisterColorDevice(deviceClass: CMDeviceClass; deviceID: CMDeviceID): CMError;

{
    Default Device accessors
}
{
 *  CMSetDefaultDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDefaultDevice(deviceClass: CMDeviceClass; deviceID: CMDeviceID): CMError;

{
 *  CMGetDefaultDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDefaultDevice(deviceClass: CMDeviceClass; VAR deviceID: CMDeviceID): CMError;

{
    Device Profile Registration & Access
}
{
 *  CMSetDeviceFactoryProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDeviceFactoryProfiles(deviceClass: CMDeviceClass; deviceID: CMDeviceID; defaultProfID: CMDeviceProfileID; {CONST}VAR deviceProfiles: CMDeviceProfileArray): CMError;

{
 *  CMGetDeviceFactoryProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceFactoryProfiles(deviceClass: CMDeviceClass; deviceID: CMDeviceID; VAR defaultProfID: CMDeviceProfileID; VAR arraySize: UInt32; VAR deviceProfiles: CMDeviceProfileArray): CMError;

{
 *  CMSetDeviceProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDeviceProfiles(deviceClass: CMDeviceClass; deviceID: CMDeviceID; {CONST}VAR profileScope: CMDeviceScope; {CONST}VAR deviceProfiles: CMDeviceProfileArray): CMError;

{
 *  CMGetDeviceProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceProfiles(deviceClass: CMDeviceClass; deviceID: CMDeviceID; VAR arraySize: UInt32; VAR deviceProfiles: CMDeviceProfileArray): CMError;

{
 *  CMSetDeviceDefaultProfileID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDeviceDefaultProfileID(deviceClass: CMDeviceClass; deviceID: CMDeviceID; defaultProfID: CMDeviceProfileID): CMError;

{
 *  CMGetDeviceDefaultProfileID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceDefaultProfileID(deviceClass: CMDeviceClass; deviceID: CMDeviceID; VAR defaultProfID: CMDeviceProfileID): CMError;

{
 *  CMGetDeviceProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceProfile(deviceClass: CMDeviceClass; deviceID: CMDeviceID; profileID: CMDeviceProfileID; VAR deviceProfLoc: CMProfileLocation): CMError;

{
 *  CMSetDeviceProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDeviceProfile(deviceClass: CMDeviceClass; deviceID: CMDeviceID; {CONST}VAR profileScope: CMDeviceScope; profileID: CMDeviceProfileID; {CONST}VAR deviceProfLoc: CMProfileLocation): CMError;

{
    Other Device State/Info accessors
}
{
 *  CMSetDeviceState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMSetDeviceState(deviceClass: CMDeviceClass; deviceID: CMDeviceID; deviceState: CMDeviceState): CMError;

{
 *  CMGetDeviceState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceState(deviceClass: CMDeviceClass; deviceID: CMDeviceID; VAR deviceState: CMDeviceState): CMError;

{
 *  CMGetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMGetDeviceInfo(deviceClass: CMDeviceClass; deviceID: CMDeviceID; VAR deviceInfo: CMDeviceInfo): CMError;

{
    Device Data & Profile Iterators
}
{
 *  CMIterateColorDevices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMIterateColorDevices(proc: CMIterateDeviceInfoProcPtr; VAR seed: UInt32; VAR count: UInt32; refCon: UNIV Ptr): CMError;

{
 *  CMIterateDeviceProfiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in 3.1 and later
 }
FUNCTION CMIterateDeviceProfiles(proc: CMIterateDeviceProfileProcPtr; VAR seed: UInt32; VAR count: UInt32; flags: UInt32; refCon: UNIV Ptr): CMError;

{$ENDC}  {TARGET_API_MAC_OSX}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMDeviceIntegrationIncludes}

{$ENDC} {__CMDEVICEINTEGRATION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

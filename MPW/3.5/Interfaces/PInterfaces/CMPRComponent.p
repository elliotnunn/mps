{
     File:       CMPRComponent.p
 
     Contains:   ColorSync ProfileResponder Component API
 
     Version:    Technology: ColorSync 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc. All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMPRComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMPRCOMPONENT__}
{$SETC __CMPRCOMPONENT__ := 1}

{$I+}
{$SETC CMPRComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __CMAPPLICATION__}
{$I CMApplication.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	CMPRInterfaceVersion		= 0;

	{	 Component function selectors 	}
	kCMPRGetProfile				= 0;
	kCMPRSetProfile				= 1;
	kCMPRSetProfileDescription	= 2;
	kCMPRGetIndexedProfile		= 3;
	kCMPRDeleteDeviceProfile	= 4;


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CMGetProfile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CMGetProfile(pr: ComponentInstance; aProfile: CMProfileHandle; VAR returnedProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0000, $7000, $A82A;
	{$ENDC}

{
 *  CMSetProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMSetProfile(pr: ComponentInstance; newProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  CMSetProfileDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMSetProfileDescription(pr: ComponentInstance; DeviceData: LONGINT; hProfile: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  CMGetIndexedProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMGetIndexedProfile(pr: ComponentInstance; search: CMProfileSearchRecordHandle; VAR returnProfile: CMProfileHandle; VAR index: LONGINT): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}

{
 *  CMDeleteDeviceProfile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMDeleteDeviceProfile(pr: ComponentInstance; deleteMe: CMProfileHandle): CMError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMPRComponentIncludes}

{$ENDC} {__CMPRCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

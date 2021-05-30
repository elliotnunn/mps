{
     File:       CMConversions.p
 
     Contains:   ColorSync Conversion Component API
 
     Version:    Technology: ColorSync 2.0
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
 UNIT CMConversions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCONVERSIONS__}
{$SETC __CMCONVERSIONS__ := 1}

{$I+}
{$SETC CMConversionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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
	CMConversionInterfaceVersion = 1;

	{	 Component function selectors 	}
	kCMXYZToLab					= 0;
	kCMLabToXYZ					= 1;
	kCMXYZToLuv					= 2;
	kCMLuvToXYZ					= 3;
	kCMXYZToYxy					= 4;
	kCMYxyToXYZ					= 5;
	kCMRGBToHLS					= 6;
	kCMHLSToRGB					= 7;
	kCMRGBToHSV					= 8;
	kCMHSVToRGB					= 9;
	kCMRGBToGRAY				= 10;
	kCMXYZToFixedXYZ			= 11;
	kCMFixedXYZToXYZ			= 12;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CMXYZToLab()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CMXYZToLab(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0000, $7000, $A82A;
	{$ENDC}

{
 *  CMLabToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMLabToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}

{
 *  CMXYZToLuv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMXYZToLuv(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}

{
 *  CMLuvToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMLuvToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; {CONST}VAR white: CMXYZColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0003, $7000, $A82A;
	{$ENDC}

{
 *  CMXYZToYxy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMXYZToYxy(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0004, $7000, $A82A;
	{$ENDC}

{
 *  CMYxyToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMYxyToXYZ(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0005, $7000, $A82A;
	{$ENDC}

{
 *  CMRGBToHLS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMRGBToHLS(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}

{
 *  CMHLSToRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMHLSToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0007, $7000, $A82A;
	{$ENDC}

{
 *  CMRGBToHSV()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMRGBToHSV(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0008, $7000, $A82A;
	{$ENDC}

{
 *  CMHSVToRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMHSVToRGB(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}

{
 *  CMRGBToGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMRGBToGray(ci: ComponentInstance; {CONST}VAR src: CMColor; VAR dst: CMColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}

{
 *  CMXYZToFixedXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMXYZToFixedXYZ(ci: ComponentInstance; {CONST}VAR src: CMXYZColor; VAR dst: CMFixedXYZColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}

{
 *  CMFixedXYZToXYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ColorSyncLibPriv 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CMFixedXYZToXYZ(ci: ComponentInstance; {CONST}VAR src: CMFixedXYZColor; VAR dst: CMXYZColor; count: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000C, $7000, $A82A;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CMConversionsIncludes}

{$ENDC} {__CMCONVERSIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

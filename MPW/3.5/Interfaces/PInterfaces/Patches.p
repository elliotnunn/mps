{
     File:       Patches.p
 
     Contains:   Patch Manager Interfaces.
 
     Version:    Technology: System 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Patches;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PATCHES__}
{$SETC __PATCHES__ := 1}

{$I+}
{$SETC PatchesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
	kOSTrapType					= 0;
	kToolboxTrapType			= 1;


TYPE
	TrapType							= SignedByte;

CONST
	OSTrap						= 0;							{  old name  }
	ToolTrap					= 1;							{  old name  }

{$ENDC}  {CALL_NOT_IN_CARBON}

{
    GetTrapAddress and SetTrapAddress are obsolete and should not
    be used. Always use NGetTrapAddress and NSetTrapAddress instead.
    The old routines will not be supported for PowerPC apps.
}
{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GetTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A146, $2E88;
	{$ENDC}

{
 *  SetTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A047;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  NGetTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NGetTrapAddress(trapNum: UInt16; tTyp: TrapType): UniversalProcPtr;

{
 *  NSetTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NSetTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16; tTyp: TrapType);

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetOSTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetOSTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A346, $2E88;
	{$ENDC}

{
 *  SetOSTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetOSTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A247;
	{$ENDC}

{
 *  GetToolTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetToolTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}

{
 *  SetToolTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetToolTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}

{
 *  GetToolboxTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetToolboxTrapAddress(trapNum: UInt16): UniversalProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}

{
 *  SetToolboxTrapAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetToolboxTrapAddress(trapAddr: UniversalProcPtr; trapNum: UInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_CPU_PPC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GetTrapVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetTrapVector(trapNumber: UInt16): UniversalProcHandle;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_PPC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PatchesIncludes}

{$ENDC} {__PATCHES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

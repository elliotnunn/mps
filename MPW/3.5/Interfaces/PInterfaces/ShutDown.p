{
     File:       ShutDown.p
 
     Contains:   Shutdown Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ShutDown;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SHUTDOWN__}
{$SETC __SHUTDOWN__ := 1}

{$I+}
{$SETC ShutDownIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	sdOnPowerOff				= 1;							{ call procedure before power off. }
	sdOnRestart					= 2;							{ call procedure before restart. }
	sdOnUnmount					= 4;							{ call procedure before unmounting. }
	sdOnDrivers					= 8;							{ call procedure before closing drivers. }
	sdOnBootVolUnmount			= 16;							{ call procedure before unmounting boot volume and VM volume but after unmounting all other volumes }
	sdRestartOrPower			= 3;							{ call before either power off or restart. }


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ShutDwnProcPtr = PROCEDURE(shutDownStage: INTEGER);
{$ELSEC}
	ShutDwnProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ShutDwnUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ShutDwnUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppShutDwnProcInfo = $00001002;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewShutDwnUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewShutDwnUPP(userRoutine: ShutDwnProcPtr): ShutDwnUPP; { old name was NewShutDwnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeShutDwnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeShutDwnUPP(userUPP: ShutDwnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeShutDwnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeShutDwnUPP(shutDownStage: INTEGER; userRoutine: ShutDwnUPP); { old name was CallShutDwnProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  ShutDwnPower()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShutDwnPower;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0001, $A895;
	{$ENDC}

{
 *  ShutDwnStart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShutDwnStart;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A895;
	{$ENDC}

{
 *  ShutDwnInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShutDwnInstall(shutDownProc: ShutDwnUPP; flags: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0003, $A895;
	{$ENDC}

{
 *  ShutDwnRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShutDwnRemove(shutDownProc: ShutDwnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A895;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ShutDownIncludes}

{$ENDC} {__SHUTDOWN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

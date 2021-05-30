{
 	File:		ShutDown.p
 
 	Contains:	Shutdown Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	sdOnPowerOff				= 1;							{call procedure before power off.}
	sdOnRestart					= 2;							{call procedure before restart.}
	sdOnUnmount					= 4;							{call procedure before unmounting.}
	sdOnDrivers					= 8;							{call procedure before closing drivers.}
	sdRestartOrPower			= 3;							{call before either power off or restart.}

TYPE
	{
		ShutDwnProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => shutDownStage	D0.W
	}
	ShutDwnProcPtr = Register68kProcPtr;  { register PROCEDURE ShutDwn(shutDownStage: INTEGER); }
	ShutDwnUPP = UniversalProcPtr;

CONST
	uppShutDwnProcInfo = $00001002; { Register PROCEDURE (2 bytes in D0); }

FUNCTION NewShutDwnProc(userRoutine: ShutDwnProcPtr): ShutDwnUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallShutDwnProc(shutDownStage: INTEGER; userRoutine: ShutDwnUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE ShutDwnPower;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0001, $A895;
	{$ENDC}
PROCEDURE ShutDwnStart;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $A895;
	{$ENDC}
PROCEDURE ShutDwnInstall(shutDownProc: ShutDwnUPP; flags: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0003, $A895;
	{$ENDC}
PROCEDURE ShutDwnRemove(shutDownProc: ShutDwnUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A895;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ShutDownIncludes}

{$ENDC} {__SHUTDOWN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

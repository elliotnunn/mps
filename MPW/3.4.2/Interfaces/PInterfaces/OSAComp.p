{
 	File:		OSAComp.p
 
 	Contains:	AppleScript Component Implementor's Interfaces.
 
 	Version:	Technology:	AppleScript 1.1
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
 UNIT OSAComp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSACOMP__}
{$SETC __OSACOMP__ := 1}

{$I+}
{$SETC OSACompIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{	Errors.p													}
{		ConditionalMacros.p										}
{	Types.p														}
{	Memory.p													}
{		MixedMode.p												}
{	OSUtils.p													}
{	Events.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{	EPPC.p														}
{		AppleTalk.p												}
{		Files.p													}
{			Finder.p											}
{		PPCToolbox.p											}
{		Processes.p												}
{	Notification.p												}

{$IFC UNDEFINED __OSA__}
{$I OSA.p}
{$ENDC}
{	AEObjects.p													}
{	Components.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

FUNCTION OSAGetStorageType(scriptData: Handle; VAR dscType: DescType): OSErr;
FUNCTION OSAAddStorageType(scriptData: Handle; dscType: DescType): OSErr;
FUNCTION OSARemoveStorageType(scriptData: Handle): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSACompIncludes}

{$ENDC} {__OSACOMP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

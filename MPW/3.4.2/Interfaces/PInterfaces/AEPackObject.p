{
 	File:		AEPackObject.p
 
 	Contains:	AppleEvents object packing Interfaces.
 
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
 UNIT AEPackObject;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEPACKOBJECT__}
{$SETC __AEPACKOBJECT__ := 1}

{$I+}
{$SETC AEPackObjectIncludes := UsingIncludes}
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

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

FUNCTION CreateOffsetDescriptor(theOffset: LONGINT; VAR theDescriptor: AEDesc): OSErr;
FUNCTION CreateCompDescriptor(comparisonOperator: DescType; VAR operand1: AEDesc; VAR operand2: AEDesc; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;
FUNCTION CreateLogicalDescriptor(VAR theLogicalTerms: AEDescList; theLogicOperator: DescType; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;
FUNCTION CreateObjSpecifier(desiredClass: DescType; VAR theContainer: AEDesc; keyForm: DescType; VAR keyData: AEDesc; disposeInputs: BOOLEAN; VAR objSpecifier: AEDesc): OSErr;
FUNCTION CreateRangeDescriptor(VAR rangeStart: AEDesc; VAR rangeStop: AEDesc; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEPackObjectIncludes}

{$ENDC} {__AEPACKOBJECT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

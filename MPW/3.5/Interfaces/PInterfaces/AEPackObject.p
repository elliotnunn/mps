{
     File:       AEPackObject.p
 
     Contains:   AppleEvents object packing Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ These are the object packing routines.  }
{
 *  CreateOffsetDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateOffsetDescriptor(theOffset: LONGINT; VAR theDescriptor: AEDesc): OSErr;

{
 *  CreateCompDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCompDescriptor(comparisonOperator: DescType; VAR operand1: AEDesc; VAR operand2: AEDesc; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;

{
 *  CreateLogicalDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateLogicalDescriptor(VAR theLogicalTerms: AEDescList; theLogicOperator: DescType; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;


{
 *  CreateObjSpecifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateObjSpecifier(desiredClass: DescType; VAR theContainer: AEDesc; keyForm: DescType; VAR keyData: AEDesc; disposeInputs: BOOLEAN; VAR objSpecifier: AEDesc): OSErr;

{
 *  CreateRangeDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateRangeDescriptor(VAR rangeStart: AEDesc; VAR rangeStop: AEDesc; disposeInputs: BOOLEAN; VAR theDescriptor: AEDesc): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEPackObjectIncludes}

{$ENDC} {__AEPACKOBJECT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{———————————————————————————————————————————————————————————————————————————————————}
{											
	©Apple Computer, Inc.  11/2/90 			
	      All Rights Reserved.				

{[r+,l+,k+,v+,t=4,0=150] Pasmat options}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT AEPackObject;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingAEObjectPacking}
{$SETC UsingAEObjectPacking := 1}

{$I+}
{$SETC AEObjectIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingMemory}
{$I $$Shell(PInterfaces)Memory.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingEPPC}
{$I $$Shell(PInterfaces)EPPC.p}
{$ENDC}
{$IFC UNDEFINED UsingAppleEvents}
{$I $$Shell(PInterfaces)AppleEvents.p}
{$ENDC}

{$SETC UsingIncludes := AEObjectIncludes}


{ These are the object packing routines.  }

FUNCTION CreateOffsetDescriptor(	theOffset:			LONGINT;
								VAR theDescriptor:		AEDesc) : OSErr;

FUNCTION CreateCompDescriptor(	comparisonOperator: 	DescType;
								VAR operand1: 			AEDesc;
								VAR operand2: 			AEDesc;
								disposeInputs:			BOOLEAN;
								VAR theDescriptor:	 	AEDesc) : OSErr;
								
FUNCTION CreateLogicalDescriptor(
							VAR theLogicalTerms: 		AEDescList; 		{a list of comb and logi terms}
							theLogicOperator:			DescType; 			{the operator, e.g. AND}	
							disposeInputs:				BOOLEAN;
							VAR theDescriptor: 			AEDesc ) : OSErr; 


FUNCTION CreateObjSpecifier(	desiredClass: 			DescType;
								VAR theContainer: 		AEDesc; 
								keyForm: 				DescType;
								VAR keyData:			AEDesc; 
								disposeInputs:			BOOLEAN;
								VAR objSpecifier: 		AEDesc) : OSErr;
							
FUNCTION CreateRangeDescriptor(	VAR rangeStart: 		AEDesc;	
								VAR rangeStop:			AEDesc;
								disposeInputs:			BOOLEAN;
								VAR theDescriptor: 		AEDesc): OSErr;


{$ENDC}    { UsingAEObjects }

{$IFC NOT UsingIncludes}
END.
{$ENDC}

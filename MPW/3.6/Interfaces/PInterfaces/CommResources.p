{
     File:       CommResources.p
 
     Contains:   Communications Toolbox Resource Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CommResources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __COMMRESOURCES__}
{$SETC __COMMRESOURCES__ := 1}

{$I+}
{$SETC CommResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
																{     tool classes (also the tool file types)     }
	classCM						= 'cbnd';
	classFT						= 'fbnd';
	classTM						= 'tbnd';

																{     version of the Comm Resource Manager    }
	curCRMVersion				= 2;							{  constants general to the use of the Communications Resource Manager  }
	crmType						= 9;							{  queue type  }
	crmRecVersion				= 1;							{  version of queue structure  }
																{     error codes  }
	crmGenericError				= -1;
	crmNoErr					= 0;

	{	 data structures general to the use of the Communications Resource Manager 	}

TYPE
	CRMErr								= OSErr;
	CRMRecPtr = ^CRMRec;
	CRMRec = RECORD
		qLink:					QElemPtr;								{ reserved }
		qType:					INTEGER;								{ queue type -- ORD(crmType) = 9 }
		crmVersion:				INTEGER;								{ version of queue element data structure }
		crmPrivate:				LONGINT;								{ reserved }
		crmReserved:			INTEGER;								{ reserved }
		crmDeviceType:			LONGINT;								{ type of device, assigned by DTS }
		crmDeviceID:			LONGINT;								{ device ID; assigned when CRMInstall is called }
		crmAttributes:			LONGINT;								{ pointer to attribute block }
		crmStatus:				LONGINT;								{ status variable - device specific }
		crmRefCon:				LONGINT;								{ for device private use }
	END;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitCRM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitCRM: CRMErr;

{
 *  CRMGetHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetHeader: QHdrPtr;

{
 *  CRMInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CRMInstall(crmReqPtr: CRMRecPtr);

{
 *  CRMRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMRemove(crmReqPtr: CRMRecPtr): OSErr;

{
 *  CRMSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMSearch(crmReqPtr: CRMRecPtr): CRMRecPtr;

{
 *  CRMGetCRMVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetCRMVersion: INTEGER;

{
 *  CRMGetResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetResource(theType: ResType; theID: INTEGER): Handle;

{
 *  CRMGet1Resource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGet1Resource(theType: ResType; theID: INTEGER): Handle;

{
 *  CRMGetIndResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetIndResource(theType: ResType; index: INTEGER): Handle;

{
 *  CRMGet1IndResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGet1IndResource(theType: ResType; index: INTEGER): Handle;

{
 *  CRMGetNamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetNamedResource(theType: ResType; name: Str255): Handle;

{
 *  CRMGet1NamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGet1NamedResource(theType: ResType; name: Str255): Handle;

{
 *  CRMReleaseResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CRMReleaseResource(theHandle: Handle);

{
 *  CRMGetToolResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetToolResource(procID: INTEGER; theType: ResType; theID: INTEGER): Handle;

{
 *  CRMGetToolNamedResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetToolNamedResource(procID: INTEGER; theType: ResType; name: Str255): Handle;

{
 *  CRMReleaseToolResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CRMReleaseToolResource(procID: INTEGER; theHandle: Handle);

{
 *  CRMGetIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetIndex(theHandle: Handle): LONGINT;

{
 *  CRMLocalToRealID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMLocalToRealID(bundleType: ResType; toolID: INTEGER; theType: ResType; localID: INTEGER): INTEGER;

{
 *  CRMRealToLocalID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMRealToLocalID(bundleType: ResType; toolID: INTEGER; theType: ResType; realID: INTEGER): INTEGER;

{
 *  CRMGetIndToolName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMGetIndToolName(bundleType: OSType; index: INTEGER; VAR toolName: Str255): OSErr;

{
 *  CRMFindCommunications()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMFindCommunications(VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;

{
 *  CRMIsDriverOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMIsDriverOpen(driverName: Str255): BOOLEAN;

{
 *  CRMParseCAPSResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMParseCAPSResource(theHandle: Handle; selector: ResType; VAR value: UInt32): CRMErr;

{
 *  CRMReserveRF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMReserveRF(refNum: INTEGER): OSErr;

{
 *  CRMReleaseRF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CRMReleaseRF(refNum: INTEGER): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CommResourcesIncludes}

{$ENDC} {__COMMRESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

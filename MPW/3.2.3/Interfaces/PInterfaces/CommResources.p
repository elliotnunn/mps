
{
Created: Thursday, September 12, 1991 at 11:54 AM
 CommResources.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CommResources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingCommResources}
{$SETC UsingCommResources := 1}

{$I+}
{$SETC CommResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$SETC UsingIncludes := CommResourcesIncludes}

CONST

{    version of the Comm Resource Manager    }
curCRMVersion = 2;

{    tool classes (also the tool file types)    }
classCM = 'cbnd';
classFT = 'fbnd';
classTM = 'tbnd';

{ constants general to the use of the Communications Resource Manager }
crmType = 9;				{ queue type    }
crmRecVersion = 1;			{ version of queue structure }

{    error codes }
crmGenericError = -1;
crmNoErr = 0;

TYPE
{ data structures general to the use of the Communications Resource Manager }
CRMErr = OSErr;

CRMRecPtr = ^CRMRec;
CRMRec = RECORD
 qLink: QElemPtr;			{reserved}
 qType: INTEGER;			{queue type -- ORD(crmType) = 9}
 crmVersion: INTEGER;		{version of queue element data structure}
 crmPrivate: LONGINT;		{reserved}
 crmReserved: INTEGER;		{reserved}
 crmDeviceType: LONGINT;	{type of device, assigned by DTS}
 crmDeviceID: LONGINT;		{device ID; assigned when CRMInstall is called}
 crmAttributes: LONGINT;	{pointer to attribute block}
 crmStatus: LONGINT;		{status variable - device specific}
 crmRefCon: LONGINT;		{for device private use}
 END;


FUNCTION InitCRM: CRMErr;
FUNCTION CRMGetHeader: QHdrPtr;
PROCEDURE CRMInstall(crmReqPtr: QElemPtr);
FUNCTION CRMRemove(crmReqPtr: QElemPtr): OSErr;
FUNCTION CRMSearch(crmReqPtr: QElemPtr): QElemPtr;
FUNCTION CRMGetCRMVersion: INTEGER;

FUNCTION CRMGetResource(theType: ResType;theID: INTEGER): Handle;
FUNCTION CRMGet1Resource(theType: ResType;theID: INTEGER): Handle;
FUNCTION CRMGetIndResource(theType: ResType;index: INTEGER): Handle;
FUNCTION CRMGet1IndResource(theType: ResType;index: INTEGER): Handle;
FUNCTION CRMGetNamedResource(theType: ResType;name: Str255): Handle;
FUNCTION CRMGet1NamedResource(theType: ResType;name: Str255): Handle;
PROCEDURE CRMReleaseResource(theHandle: Handle);
FUNCTION CRMGetToolResource(procID: INTEGER;theType: ResType;theID: INTEGER): Handle;
FUNCTION CRMGetToolNamedResource(procID: INTEGER;theType: ResType;name: Str255): Handle;
PROCEDURE CRMReleaseToolResource(procID: INTEGER;theHandle: Handle);
FUNCTION CRMGetIndex(theHandle: Handle): LONGINT;

FUNCTION CRMLocalToRealID(bundleType: ResType;toolID: INTEGER;theType: ResType;
 localID: INTEGER): INTEGER;
FUNCTION CRMRealToLocalID(bundleType: ResType;toolID: INTEGER;theType: ResType;
 realID: INTEGER): INTEGER;

FUNCTION CRMGetIndToolName(bundleType: OSType;index: INTEGER;VAR toolName: Str255): OSErr;

FUNCTION CRMFindCommunications(VAR vRefNum: INTEGER;VAR dirID: LONGINT): OSErr;

FUNCTION CRMIsDriverOpen(driverName: Str255): BOOLEAN;

FUNCTION CRMParseCAPSResource(theHandle: Handle;selector: ResType;VAR value: LONGINT): CRMErr;

FUNCTION CRMReserveRF(refNum: INTEGER): OSErr;

{  decrements useCount by one  }
FUNCTION CRMReleaseRF(refNum: INTEGER): OSErr;



{$ENDC} { UsingCommResources }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


{
 	File:		CommResources.p
 
 	Contains:	Communications Toolbox Resource Manager Interfaces.
 
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
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{	tool classes (also the tool file types)	}
	classCM						= 'cbnd';
	classFT						= 'fbnd';
	classTM						= 'tbnd';

{	version of the Comm Resource Manager	}
	curCRMVersion				= 2;
{ constants general to the use of the Communications Resource Manager }
	crmType						= 9;							{ queue type	}
	crmRecVersion				= 1;							{ version of queue structure }
{	error codes }
	crmGenericError				= -1;
	crmNoErr					= 0;

{ data structures general to the use of the Communications Resource Manager }
	
TYPE
	CRMErr = OSErr;

	CRMRec = RECORD
		qLink:					QElemPtr;								{reserved}
		qType:					INTEGER;								{queue type -- ORD(crmType) = 9}
		crmVersion:				INTEGER;								{version of queue element data structure}
		crmPrivate:				LONGINT;								{reserved}
		crmReserved:			INTEGER;								{reserved}
		crmDeviceType:			LONGINT;								{type of device, assigned by DTS}
		crmDeviceID:			LONGINT;								{device ID; assigned when CRMInstall is called}
		crmAttributes:			LONGINT;								{pointer to attribute block}
		crmStatus:				LONGINT;								{status variable - device specific}
		crmRefCon:				LONGINT;								{for device private use}
	END;

	CRMRecPtr = ^CRMRec;


FUNCTION InitCRM: CRMErr;
FUNCTION CRMGetHeader: QHdrPtr;
PROCEDURE CRMInstall(crmReqPtr: CRMRecPtr);
FUNCTION CRMRemove(crmReqPtr: CRMRecPtr): OSErr;
FUNCTION CRMSearch(crmReqPtr: CRMRecPtr): CRMRecPtr;
FUNCTION CRMGetCRMVersion: INTEGER;
FUNCTION CRMGetResource(theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGet1Resource(theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGetIndResource(theType: ResType; index: INTEGER): Handle;
FUNCTION CRMGet1IndResource(theType: ResType; index: INTEGER): Handle;
FUNCTION CRMGetNamedResource(theType: ResType; name: ConstStr255Param): Handle;
FUNCTION CRMGet1NamedResource(theType: ResType; name: ConstStr255Param): Handle;
PROCEDURE CRMReleaseResource(theHandle: Handle);
FUNCTION CRMGetToolResource(procID: INTEGER; theType: ResType; theID: INTEGER): Handle;
FUNCTION CRMGetToolNamedResource(procID: INTEGER; theType: ResType; name: ConstStr255Param): Handle;
PROCEDURE CRMReleaseToolResource(procID: INTEGER; theHandle: Handle);
FUNCTION CRMGetIndex(theHandle: Handle): LONGINT;
FUNCTION CRMLocalToRealID(bundleType: ResType; toolID: INTEGER; theType: ResType; localID: INTEGER): INTEGER;
FUNCTION CRMRealToLocalID(bundleType: ResType; toolID: INTEGER; theType: ResType; realID: INTEGER): INTEGER;
FUNCTION CRMGetIndToolName(bundleType: OSType; index: INTEGER; VAR toolName: Str255): OSErr;
FUNCTION CRMFindCommunications(VAR vRefNum: INTEGER; VAR dirID: LONGINT): OSErr;
FUNCTION CRMIsDriverOpen(driverName: ConstStr255Param): BOOLEAN;
FUNCTION CRMParseCAPSResource(theHandle: Handle; selector: ResType; VAR value: LONGINT): CRMErr;
FUNCTION CRMReserveRF(refNum: INTEGER): OSErr;
FUNCTION CRMReleaseRF(refNum: INTEGER): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CommResourcesIncludes}

{$ENDC} {__COMMRESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

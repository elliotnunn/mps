{
	File:		CRMSerialDevices.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CRMSerialDevices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingCRMSerialDevices}
{$SETC UsingCRMSerialDevices := 1}

{$I+}
{$SETC CRMSerialDevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := CRMSerialDevicesIncludes}

CONST

{    for the crmDeviceType field of the CRMRec data structure }
crmSerialDevice = 1;


{  version of the CRMSerialRecord below }
curCRMSerRecVers = 1;

TYPE
{ Maintains compatibility w/ apps & tools that expect an old style icon    }
CRMIconPtr = ^CRMIconRecord;
CRMIconHandle = ^CRMIconPtr;
CRMIconRecord = RECORD
 oldIcon: ARRAY [0..31] OF LONGINT;		{ ICN#    }
 oldMask: ARRAY [0..31] OF LONGINT;
 theSuite: Handle;						{ Handle to an IconSuite    }
 reserved: LONGINT;
 END;

CRMSerialPtr = ^CRMSerialRecord;
CRMSerialRecord = RECORD
 version: INTEGER;
 inputDriverName: StringHandle;
 outputDriverName: StringHandle;
 name: StringHandle;
 deviceIcon: CRMIconHandle;
 ratedSpeed: LONGINT;
 maxSpeed: LONGINT;
 reserved: LONGINT;
 END;



{$ENDC} { UsingCRMSerialDevices }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


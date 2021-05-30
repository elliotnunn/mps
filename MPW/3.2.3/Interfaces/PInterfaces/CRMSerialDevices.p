
{
Created: Wednesday, September 11, 1991 at 2:05 PM
 CRMSerialDevices.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1988-1991
  All rights reserved
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


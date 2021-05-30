{
     File:       CRMSerialDevices.p
 
     Contains:   Communications Resource Manager Serial Device interfaces.
 
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
 UNIT CRMSerialDevices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CRMSERIALDEVICES__}
{$SETC __CRMSERIALDEVICES__ := 1}

{$I+}
{$SETC CRMSerialDevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }

CONST
																{     for the crmDeviceType field of the CRMRec data structure   }
	crmSerialDevice				= 1;							{     version of the CRMSerialRecord below    }
	curCRMSerRecVers			= 1;

	{	 Maintains compatibility w/ apps & tools that expect an old style icon    	}

TYPE
	CRMIconRecordPtr = ^CRMIconRecord;
	CRMIconRecord = RECORD
		oldIcon:				ARRAY [0..31] OF LONGINT;				{  ICN#    }
		oldMask:				ARRAY [0..31] OF LONGINT;
		theSuite:				Handle;									{  Handle to an IconSuite  }
		reserved:				LONGINT;
	END;

	CRMIconPtr							= ^CRMIconRecord;
	CRMIconHandle						= ^CRMIconPtr;
	CRMSerialRecordPtr = ^CRMSerialRecord;
	CRMSerialRecord = RECORD
		version:				INTEGER;
		inputDriverName:		StringHandle;
		outputDriverName:		StringHandle;
		name:					StringHandle;
		deviceIcon:				CRMIconHandle;
		ratedSpeed:				LONGINT;
		maxSpeed:				LONGINT;
		reserved:				LONGINT;
	END;

	CRMSerialPtr						= ^CRMSerialRecord;
{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CRMSerialDevicesIncludes}

{$ENDC} {__CRMSERIALDEVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
 	File:		CRMSerialDevices.p
 
 	Contains:	Communications Resource Manager Serial Device interfaces.
 
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
 UNIT CRMSerialDevices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CRMSERIALDEVICES__}
{$SETC __CRMSERIALDEVICES__ := 1}

{$I+}
{$SETC CRMSerialDevicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ 	for the crmDeviceType field of the CRMRec data structure	}
	crmSerialDevice				= 1;
{	version of the CRMSerialRecord below	}
	curCRMSerRecVers			= 1;

{ Maintains compatibility w/ apps & tools that expect an old style icon	}

TYPE
	CRMIconRecord = RECORD
		oldIcon:				ARRAY [0..31] OF LONGINT;				{ ICN#	}
		oldMask:				ARRAY [0..31] OF LONGINT;
		theSuite:				Handle;									{ Handle to an IconSuite	}
		reserved:				LONGINT;
	END;

	CRMIconPtr = ^CRMIconRecord;
	CRMIconHandle = ^CRMIconPtr;

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

	CRMSerialPtr = ^CRMSerialRecord;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CRMSerialDevicesIncludes}

{$ENDC} {__CRMSERIALDEVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
Created: Tuesday, August 2, 1988 at 10:56 AM
	Start.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1987-1988
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT Start;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingStart}
{$SETC UsingStart := 1}

{$I+}
{$SETC StartIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := StartIncludes}

TYPE

DefStartType = (slotDev,scsiDev);

DefStartPtr = ^DefStartRec;
DefStartRec = RECORD
	CASE DefStartType OF
	  slotDev:
		(sdExtDevID: SignedByte;
		sdPartition: SignedByte;
		sdSlotNum: SignedByte;
		sdSRsrcID: SignedByte);
	  scsiDev:
		(sdReserved1: SignedByte;
		sdReserved2: SignedByte;
		sdRefNum: INTEGER);
	END;

DefVideoPtr = ^DefVideoRec;
DefVideoRec = RECORD
	sdSlot: SignedByte;
	sdsResource: SignedByte;
	END;

DefOSPtr = ^DefOSRec;
DefOSRec = RECORD
	sdReserved: SignedByte;
	sdOSType: SignedByte;
	END;



PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
PROCEDURE SetTimeout(count: INTEGER);
PROCEDURE GetTimeout(VAR count: INTEGER);

{$ENDC}    { UsingStart }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


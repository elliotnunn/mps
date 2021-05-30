{
	File:		SCSIIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT SCSIIntf;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSCSIIntf}
{$SETC UsingSCSIIntf := 1}

{$I+}
{$SETC SCSIIntfIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingSCSI}
{$I $$Shell(PInterfaces)SCSI.p}
{$ENDC}
{$SETC UsingIncludes := SCSIIntfIncludes}

{$ENDC}    { UsingSCSIIntf }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


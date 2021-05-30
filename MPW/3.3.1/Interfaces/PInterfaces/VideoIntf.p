{
	File:		VideoIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT VideoIntf;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingVideoIntf}
{$SETC UsingVideoIntf := 1}

{$I+}
{$SETC VideoIntfIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingVideo}
{$I $$Shell(PInterfaces)Video.p}
{$ENDC}
{$SETC UsingIncludes := VideoIntfIncludes}

{$ENDC}    { UsingVideoIntf }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


{
	File:		PackIntf.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT PackIntf;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPackIntf}
{$SETC UsingPackIntf := 1}

{$I+}
{$SETC PackIntfIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingPackages}
{$I $$Shell(PInterfaces)Packages.p}
{$ENDC}
{$SETC UsingIncludes := PackIntfIncludes}

{$ENDC}    { UsingPackIntf }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


{
	File:		PaletteMgr.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT PaletteMgr;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPaletteMgr}
{$SETC UsingPaletteMgr := 1}

{$I+}
{$SETC PaletteMgrIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingPalettes}
{$I $$Shell(PInterfaces)Palettes.p}
{$ENDC}
{$SETC UsingIncludes := PaletteMgrIncludes}

{$ENDC}    { UsingPaletteMgr }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


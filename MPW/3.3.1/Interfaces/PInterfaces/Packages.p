{
	File:		Packages.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Packages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPackages}
{$SETC UsingPackages := 1}

{$I+}
{$SETC PackagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := PackagesIncludes}

CONST
listMgr = 0;							{list manager}
dskInit = 2;							{Disk Initializaton}
stdFile = 3;							{Standard File}
flPoint = 4;							{Floating-Point Arithmetic}
trFunc = 5;								{Transcendental Functions}
intUtil = 6;							{International Utilities}
bdConv = 7;								{Binary/Decimal Conversion}
editionMgr = 11;						{Edition Manager}


PROCEDURE InitPack(packID: INTEGER);
 INLINE $A9E5;
PROCEDURE InitAllPacks;
 INLINE $A9E6;


{$ENDC} { UsingPackages }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


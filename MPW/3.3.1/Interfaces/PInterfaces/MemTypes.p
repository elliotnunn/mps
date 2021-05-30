{
	File:		MemTypes.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT MemTypes;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMemTypes}
{$SETC UsingMemTypes := 1}

{$I+}
{$SETC MemTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := MemTypesIncludes}

{$ENDC}    { UsingMemTypes }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


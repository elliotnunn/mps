{
Created: Monday, Sempember 9, 1991 at 1:06 PM
	PrintTraps.p

	Copyright Apple Computer, Inc.	1985-1988
	All rights reserved
}

{This file is provided to support existing references to it. The up to date interface is
   defined in Printing.p
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT PrintTraps;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPrintTraps}
{$SETC UsingPrintTraps := 1}

{$I+}
{$SETC PrintTrapsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingPrinting}
{$I $$Shell(PInterfaces)Printing.p}
{$ENDC}
{$SETC UsingIncludes := PrintTrapsIncludes}


{$ENDC}    { UsingPrintTraps }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


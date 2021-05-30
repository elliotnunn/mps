{
	File:		PrintTraps.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

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


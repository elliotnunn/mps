{
	File:		MacPrint.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT MacPrint;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMacPrint}
{$SETC UsingMacPrint := 1}

{$I+}
{$SETC MacPrintIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingPrinting}
{$I $$Shell(PInterfaces)Printing.p}
{$ENDC}
{$SETC UsingIncludes := MacPrintIncludes}

{$ENDC}    { UsingMacPrint }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


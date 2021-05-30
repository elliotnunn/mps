{
     File:       OpenTptGlobalNew.p
 
     Contains:   Definition of "new" operator that uses Open Transport's
 
     Version:    Technology: Mac OS 8.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptGlobalNew;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTGLOBALNEW__}
{$SETC __OPENTPTGLOBALNEW__ := 1}

{$I+}
{$SETC OpenTptGlobalNewIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{
    This file previously contained C++ code to map the global operator new
    to the OTAllocMem() routines.  Since OTAllocMem() is not in Carbon, these
    file has been deprecated.  If you wish to use map C++ operator new
    to an OTAllocMem call, you will need to do in your own source code.

}
{$SETC UsingIncludes := OpenTptGlobalNewIncludes}

{$ENDC} {__OPENTPTGLOBALNEW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

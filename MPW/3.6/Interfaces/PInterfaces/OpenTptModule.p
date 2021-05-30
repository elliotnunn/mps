{
     File:       OpenTptModule.p
 
     Contains:   headers for STREAM modules developement
 
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
 UNIT OpenTptModule;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTMODULE__}
{$SETC __OPENTPTMODULE__ := 1}

{$I+}
{$SETC OpenTptModuleIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTKERNEL__}
{$I OpenTransportKernel.p}
{$ENDC}

{
    The contents of OpenTptModule.h has been merged into OpenTransportKernel.h
}
{$SETC UsingIncludes := OpenTptModuleIncludes}

{$ENDC} {__OPENTPTMODULE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

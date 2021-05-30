{
     File:       OpenTptPCISupport.p
 
     Contains:   File to include everything you need to declare a module
 
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
 UNIT OpenTptPCISupport;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTPCISUPPORT__}
{$SETC __OPENTPTPCISUPPORT__ := 1}

{$I+}
{$SETC OpenTptPCISupportIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTKERNEL__}
{$I OpenTransportKernel.p}
{$ENDC}

{
    The contents of OpenTptPCISupport.h has been merged into OpenTransportKernel.h
}
{$SETC UsingIncludes := OpenTptPCISupportIncludes}

{$ENDC} {__OPENTPTPCISUPPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       Kernel.p
 
     Contains:   Kernel Interfaces
 
     Version:    Technology: System 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Kernel;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __KERNEL__}
{$SETC __KERNEL__ := 1}

{$I+}
{$SETC KernelIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$I DriverServices.p}
{$ENDC}

{
    The contents of Kernel.h has been merged into DriverServices.h
}
{$SETC UsingIncludes := KernelIncludes}

{$ENDC} {__KERNEL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

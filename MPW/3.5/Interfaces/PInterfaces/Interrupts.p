{
     File:       Interrupts.p
 
     Contains:   Public Interface to the Interrupt Manager.
 
     Version:    Technology: PowerSurge 1.0.2
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
 UNIT Interrupts;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __INTERRUPTS__}
{$SETC __INTERRUPTS__ := 1}

{$I+}
{$SETC InterruptsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$I DriverServices.p}
{$ENDC}

{
    The contents of Interrupts.h has been merged into DriverServices.h
}
{$SETC UsingIncludes := InterruptsIncludes}

{$ENDC} {__INTERRUPTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

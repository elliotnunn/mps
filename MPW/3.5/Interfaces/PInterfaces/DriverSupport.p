{
     File:       DriverSupport.p
 
     Contains:   Driver Support Interfaces.
 
     Version:    Technology: Sustem 8
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
 UNIT DriverSupport;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERSUPPORT__}
{$SETC __DRIVERSUPPORT__ := 1}

{$I+}
{$SETC DriverSupportIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __DRIVERSERVICES__}
{$I DriverServices.p}
{$ENDC}

{
    The contents of DriverSupport.h has been merged into DriverServices.h
}
{$SETC UsingIncludes := DriverSupportIncludes}

{$ENDC} {__DRIVERSUPPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       OpenTptSerial.p
 
     Contains:   Definitions for Serial Port
 
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
 UNIT OpenTptSerial;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTSERIAL__}
{$SETC __OPENTPTSERIAL__ := 1}

{$I+}
{$SETC OpenTptSerialIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}

{
    The contents of OpenTptSerial.h has been merged into OpenTransportProviders.h
}
{$SETC UsingIncludes := OpenTptSerialIncludes}

{$ENDC} {__OPENTPTSERIAL__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

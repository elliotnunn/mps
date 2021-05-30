{
     File:       OpenTptConfig.p
 
     Contains:   Open Transport port information
 
     Version:    Technology: Open Transport 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptConfig;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTCONFIG__}
{$SETC __OPENTPTCONFIG__ := 1}

{$I+}
{$SETC OpenTptConfigIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}

{
    The contents of OpenTptConfig.h has been merged into OpenTransportProtocol.h
}
{$SETC UsingIncludes := OpenTptConfigIncludes}

{$ENDC} {__OPENTPTCONFIG__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

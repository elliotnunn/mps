{
     File:       OpenTptClient.p
 
     Contains:   headers for client development
 
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
 UNIT OpenTptClient;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTCLIENT__}
{$SETC __OPENTPTCLIENT__ := 1}

{$I+}
{$SETC OpenTptClientIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}

{
    The contents of OpenTptClient.h has been merged into OpenTransportProtocol.h
}
{$SETC UsingIncludes := OpenTptClientIncludes}

{$ENDC} {__OPENTPTCLIENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       OpenTptCommon.p
 
     Contains:   Equates for Open Transport development needed both by clients
 
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
 UNIT OpenTptCommon;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTCOMMON__}
{$SETC __OPENTPTCOMMON__ := 1}

{$I+}
{$SETC OpenTptCommonIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}

{
    The contents of OpenTptCommon.h has been merged into OpenTransportProtocol.h
}
{$SETC UsingIncludes := OpenTptCommonIncludes}

{$ENDC} {__OPENTPTCOMMON__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

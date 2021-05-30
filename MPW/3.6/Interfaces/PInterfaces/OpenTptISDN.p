{
     File:       OpenTptISDN.p
 
     Contains:   Definitions for ISDN.  This file is a first draft at definitions
 
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
 UNIT OpenTptISDN;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTISDN__}
{$SETC __OPENTPTISDN__ := 1}

{$I+}
{$SETC OpenTptISDNIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}

{
    The contents of OpenTptISDN.h has been merged into OpenTransportProviders.h
}
{$SETC UsingIncludes := OpenTptISDNIncludes}

{$ENDC} {__OPENTPTISDN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

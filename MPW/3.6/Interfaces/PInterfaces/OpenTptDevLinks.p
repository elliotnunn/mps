{
     File:       OpenTptDevLinks.p
 
     Contains:   Link related constants and structures
 
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
 UNIT OpenTptDevLinks;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTDEVLINKS__}
{$SETC __OPENTPTDEVLINKS__ := 1}

{$I+}
{$SETC OpenTptDevLinksIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}

{
    The contents of OpenTptDevLinks.h has been merged into OpenTransportProviders.h
}
{$SETC UsingIncludes := OpenTptDevLinksIncludes}

{$ENDC} {__OPENTPTDEVLINKS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

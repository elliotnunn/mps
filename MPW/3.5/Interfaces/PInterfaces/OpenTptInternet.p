{
     File:       OpenTptInternet.p
 
     Contains:   Client TCP/IP definitions
 
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
 UNIT OpenTptInternet;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTINTERNET__}
{$SETC __OPENTPTINTERNET__ := 1}

{$I+}
{$SETC OpenTptInternetIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$I OpenTransportProviders.p}
{$ENDC}

{
    The contents of OpenTptInternet.h has been merged into OpenTransportProviders.h
}
{$SETC UsingIncludes := OpenTptInternetIncludes}

{$ENDC} {__OPENTPTINTERNET__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

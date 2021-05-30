{
     File:       OpenTptXTI.p
 
     Contains:   Prototypes for XTI-compatible routines for Open Transport
 
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
 UNIT OpenTptXTI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTXTI__}
{$SETC __OPENTPTXTI__ := 1}

{$I+}
{$SETC OpenTptXTIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTUNIX__}
{$I OpenTransportUNIX.p}
{$ENDC}

{
    The contents of OpenTptXTI.h has been merged into OpenTransportUNIX.h
}
{$SETC UsingIncludes := OpenTptXTIIncludes}

{$ENDC} {__OPENTPTXTI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

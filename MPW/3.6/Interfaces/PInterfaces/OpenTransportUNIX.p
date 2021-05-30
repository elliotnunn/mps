{
     File:       OpenTransportUNIX.p
 
     Contains:   Open Transport client interface file for UNIX compatibility clients.
 
     Version:    Technology: 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransportUNIX;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORTUNIX__}
{$SETC __OPENTRANSPORTUNIX__ := 1}

{$I+}
{$SETC OpenTransportUNIXIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORTPROTOCOL__}
{$I OpenTransportProtocol.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   This file is empty for asm and pascal because
   they are case insensitive languages which 
   reports errors on the overloading done in original C XTI headers.
}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportUNIXIncludes}

{$ENDC} {__OPENTRANSPORTUNIX__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

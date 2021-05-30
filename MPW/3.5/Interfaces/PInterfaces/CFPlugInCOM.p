{
     File:       CFPlugInCOM.p
 
     Contains:   CoreFoundation plugins
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFPlugInCOM;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPLUGINCOM__}
{$SETC __CFPLUGINCOM__ := 1}

{$I+}
{$SETC CFPlugInCOMIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFPLUGIN__}
{$I CFPlugIn.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ================= IUnknown definition (C struct) ================= }
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPlugInCOMIncludes}

{$ENDC} {__CFPLUGINCOM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

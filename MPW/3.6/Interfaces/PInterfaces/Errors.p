{
     File:       Errors.p
 
     Contains:   OSErr codes.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{
    NOTE
    
    The file "Errors.h" has been renamed to "MacErrors.h" to prevent a collision
    with the "Errors.h" available on other platforms.  MacOS only developers may 
    continue to use #include <Errors.h>.  Developers doing cross-platform work where 
    Errors.h also exists should change their sources to use #include <MacErrors.h>
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Errors;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ERRORS__}
{$SETC __ERRORS__ := 1}

{$I+}
{$SETC ErrorsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$ELSEC}
{
    If you get here, your development environment is messed up.
    This file is for MacOS development only.
}
{$ENDC}  {TARGET_OS_MAC}

{$SETC UsingIncludes := ErrorsIncludes}

{$ENDC} {__ERRORS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

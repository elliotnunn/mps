{
     File:       Types.p
 
     Contains:   Basic Macintosh data types.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{
    NOTE
    
    The file "Types.h" has been renamed to "MacTypes.h" to prevent a collision
    with the "Types.h" available on other platforms.  MacOS only developers may 
    continue to use #include <Types.h>.  Developers doing cross-platform work where 
    Types.h also exists should change their sources to use #include <MacTypes.h>
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Types;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$SETC __TYPES__ := 1}

{$I+}
{$SETC TypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$ELSEC}
{
    If you get here, your development environment is messed up.
    This file is for MacOS development only.
}
{$ENDC}  {TARGET_OS_MAC}

{$SETC UsingIncludes := TypesIncludes}

{$ENDC} {__TYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

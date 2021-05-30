{
     File:       Windows.p
 
     Contains:   Window Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1984-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{
    NOTE
    
    The file Windows.h has been renamed to "MacWindows.h" to prevent a collision
    with the Microsoft Windows(tm) header file "Windows.h".  MacOS only developers may 
    continue to use #include <Windows.h>.  Developers doing cross-platform work where 
    Windows.h also exists should change their sources to use #include <MacWindows.h>
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Windows;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __WINDOWS__}
{$SETC __WINDOWS__ := 1}

{$I+}
{$SETC WindowsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$ELSEC}
{
    If you get here, your development environment is messed up.
    This file is for MacOS development only.
}
{$ENDC}  {TARGET_OS_MAC}

{$SETC UsingIncludes := WindowsIncludes}

{$ENDC} {__WINDOWS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

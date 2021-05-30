{
     File:       Strings.p
 
     Contains:   Pascal <-> C String Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{
    Note: All Pascal <-> C String routines have moved to TextUtils.h

}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Strings;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STRINGS__}
{$SETC __STRINGS__ := 1}

{$I+}
{$SETC StringsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}

{$SETC UsingIncludes := StringsIncludes}

{$ENDC} {__STRINGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

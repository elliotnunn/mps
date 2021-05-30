{
     File:       TargetConditionals.p
 
     Contains:   For compatibility with Mac OS X header
 
     Version:    Technology: Universal Interface Files 3.4
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TargetConditionals;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TARGETCONDITIONALS__}
{$SETC __TARGETCONDITIONALS__ := 1}

{$I+}
{$SETC TargetConditionalsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{
    This header is for compatiblity with TargetConditionals.h on Mac OS X
}
{$SETC UsingIncludes := TargetConditionalsIncludes}

{$ENDC} {__TARGETCONDITIONALS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

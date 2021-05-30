{
     File:       CMComponent.p
 
     Contains:   ColorSync CMM Component API
 
     Version:    Technology: ColorSync 2.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CMComponent;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CMCOMPONENT__}
{$SETC __CMCOMPONENT__ := 1}

{$I+}
{$SETC CMComponentIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{ 
    This file has been included to allow older source code 
    to #include <CMComponent.h>.  Please update your source
    code to directly #include <CMMComponent.h>
      and            #include <CMPRComponent.h>

}
{ #include the two ColorSync 2.0 files equivalent to the v. 1.0 file }
{$IFC UNDEFINED __CMMCOMPONENT__}
{$I CMMComponent.p}
{$ENDC}
{$IFC UNDEFINED __CMPRCOMPONENT__}
{$I CMPRComponent.p}
{$ENDC}

{$SETC UsingIncludes := CMComponentIncludes}

{$ENDC} {__CMCOMPONENT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

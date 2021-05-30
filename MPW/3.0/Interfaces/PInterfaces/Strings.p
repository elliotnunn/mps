{
Created: Tuesday, October 25, 1988 at 4:30 PM
    Strings.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Strings;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingStrings}
{$SETC UsingStrings := 1}

{$I+}
{$SETC StringsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := StringsIncludes}


FUNCTION C2PStr(cString: UNIV Ptr): Str255;
PROCEDURE C2PStrProc(cString: UNIV Ptr);
FUNCTION P2CStr(pString: UNIV Ptr): StringPtr;
PROCEDURE P2CStrProc(pString: UNIV Ptr);

{$ENDC}    { UsingStrings }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


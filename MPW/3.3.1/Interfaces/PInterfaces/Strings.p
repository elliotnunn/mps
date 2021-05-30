{
	File:		Strings.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

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


FUNCTION C2PStr(cString: UNIV Ptr): StringPtr;
PROCEDURE C2PStrProc(cString: UNIV Ptr);
FUNCTION P2CStr(pString: StringPtr): Ptr;
PROCEDURE P2CStrProc(pString: StringPtr);

{$ENDC}    { UsingStrings }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


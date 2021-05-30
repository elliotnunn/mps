{
 	File:		Strings.p
 
 	Contains:	Pascal <-> C String Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{$IFC OLDROUTINELOCATIONS }

PROCEDURE C2PStrProc(aStr: UNIV Ptr);
FUNCTION C2PStr(cString: UNIV Ptr): StringPtr;
PROCEDURE P2CStrProc(aStr: StringPtr);
FUNCTION P2CStr(pString: StringPtr): Ptr;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StringsIncludes}

{$ENDC} {__STRINGS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

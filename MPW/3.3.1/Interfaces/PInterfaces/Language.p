{
	File:		Language.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{All of the Language Codes Have been moved into Script.p }

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Language;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingLanguage}
{$SETC UsingLanguage := 1}


{$ENDC} { UsingLanguage }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


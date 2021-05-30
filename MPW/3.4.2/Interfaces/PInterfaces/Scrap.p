{
 	File:		Scrap.p
 
 	Contains:	Scrap Manager Interfaces.
 
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
 UNIT Scrap;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCRAP__}
{$SETC __SCRAP__ := 1}

{$I+}
{$SETC ScrapIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	ScrapStuff = RECORD
		scrapSize:				LONGINT;
		scrapHandle:			Handle;
		scrapCount:				INTEGER;
		scrapState:				INTEGER;
		scrapName:				StringPtr;
	END;

	PScrapStuff = ^ScrapStuff;
	ScrapStuffPtr = ^ScrapStuff;


FUNCTION InfoScrap: ScrapStuffPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F9;
	{$ENDC}
FUNCTION UnloadScrap: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FA;
	{$ENDC}
FUNCTION LoadScrap: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FB;
	{$ENDC}
FUNCTION GetScrap(hDest: Handle; theType: ResType; VAR offset: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FD;
	{$ENDC}
FUNCTION ZeroScrap: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FC;
	{$ENDC}
FUNCTION PutScrap(length: LONGINT; theType: ResType; source: UNIV Ptr): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FE;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScrapIncludes}

{$ENDC} {__SCRAP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

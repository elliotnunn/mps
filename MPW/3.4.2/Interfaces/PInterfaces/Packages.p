{
 	File:		Packages.p
 
 	Contains:	Package Manager Interfaces.
 
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
 UNIT Packages;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PACKAGES__}
{$SETC __PACKAGES__ := 1}

{$I+}
{$SETC PackagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	listMgr						= 0;							{ list manager }
	dskInit						= 2;							{ Disk Initializaton }
	stdFile						= 3;							{ Standard File }
	flPoint						= 4;							{ Floating-Point Arithmetic }
	trFunc						= 5;							{ Transcendental Functions }
	intUtil						= 6;							{ International Utilities }
	bdConv						= 7;							{ Binary/Decimal Conversion }
	editionMgr					= 11;							{ Edition Manager }


PROCEDURE InitPack(packID: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9E5;
	{$ENDC}
PROCEDURE InitAllPacks;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9E6;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PackagesIncludes}

{$ENDC} {__PACKAGES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

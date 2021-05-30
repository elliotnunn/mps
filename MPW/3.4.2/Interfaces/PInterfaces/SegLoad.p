{
 	File:		SegLoad.p
 
 	Contains:	Segment Loader Interfaces.
 
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
 UNIT SegLoad;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SEGLOAD__}
{$SETC __SEGLOAD__ := 1}

{$I+}
{$SETC SegLoadIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	appOpen						= 0;							{Open the Document (s)}
	appPrint					= 1;							{Print the Document (s)}


TYPE
	AppFile = RECORD
		vRefNum:				INTEGER;
		fType:					OSType;
		versNum:				INTEGER;								{versNum in high byte}
		fName:					Str255;
	END;

{
	Because PowerPC applications don’t have segments,
	UnloadSeg is unsupported for PowerPC.
}
{$IFC GENERATING68K }

PROCEDURE UnloadSeg(routineAddr: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F1;
	{$ENDC}
{$ELSEC}
{$ENDC}
{$IFC NOT GENERATINGCFM }

PROCEDURE CountAppFiles(VAR message: INTEGER; VAR count: INTEGER);
PROCEDURE GetAppFiles(index: INTEGER; VAR theFile: AppFile);
PROCEDURE ClrAppFiles(index: INTEGER);
PROCEDURE GetAppParms(VAR apName: Str255; VAR apRefNum: INTEGER; VAR apParam: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F5;
	{$ENDC}
{$ENDC}
{$IFC OLDROUTINELOCATIONS }

PROCEDURE ExitToShell;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9F4;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SegLoadIncludes}

{$ENDC} {__SEGLOAD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

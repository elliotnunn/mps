{
 	File:		Start.p
 
 	Contains:	Start Manager Interfaces.
 
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
 UNIT Start;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __START__}
{$SETC __START__ := 1}

{$I+}
{$SETC StartIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	DefStartRec = RECORD
		CASE INTEGER OF
		0: (
			sdExtDevID:					SignedByte;
			sdPartition:				SignedByte;
			sdSlotNum:					SignedByte;
			sdSRsrcID:					SignedByte;
		   );
		1: (
			sdReserved1:				SignedByte;
			sdReserved2:				SignedByte;
			sdRefNum:					INTEGER;
		   );
	END;

	DefStartPtr = ^DefStartRec;

	DefVideoRec = RECORD
		sdSlot:					SignedByte;
		sdsResource:			SignedByte;
	END;

	DefVideoPtr = ^DefVideoRec;

	DefOSRec = RECORD
		sdReserved:				SignedByte;
		sdOSType:				SignedByte;
	END;

	DefOSPtr = ^DefOSRec;


PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A07D;
	{$ENDC}
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A07E;
	{$ENDC}
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A080;
	{$ENDC}
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A081;
	{$ENDC}
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A084;
	{$ENDC}
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A083;
	{$ENDC}
PROCEDURE SetTimeout(count: INTEGER);
PROCEDURE GetTimeout(VAR count: INTEGER);

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StartIncludes}

{$ENDC} {__START__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

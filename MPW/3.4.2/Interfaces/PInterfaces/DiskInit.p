{
 	File:		DiskInit.p
 
 	Contains:	Disk Initialization Package ('PACK' 2) Interfaces.
 
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
 UNIT DiskInit;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DISKINIT__}
{$SETC __DISKINIT__ := 1}

{$I+}
{$SETC DiskInitIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	HFSDefaults = RECORD
		sigWord:				PACKED ARRAY [0..1] OF CHAR;			{ signature word }
		abSize:					LONGINT;								{ allocation block size in bytes }
		clpSize:				LONGINT;								{ clump size in bytes }
		nxFreeFN:				LONGINT;								{ next free file number }
		btClpSize:				LONGINT;								{ B-Tree clump size in bytes }
		rsrv1:					INTEGER;								{ reserved }
		rsrv2:					INTEGER;								{ reserved }
		rsrv3:					INTEGER;								{ reserved }
	END;

{$IFC SystemSevenOrLater }

PROCEDURE DILoad;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $3F00, $A9E9;
	{$ENDC}
PROCEDURE DIUnload;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIBadMount(where: Point; evtMessage: LONGINT): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIFormat(drvNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIVerify(drvNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIZero(drvNum: INTEGER; volName: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIXFormat(drvNum: INTEGER; fmtFlag: BOOLEAN; fmtArg: LONGINT; VAR actSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIXZero(drvNum: INTEGER; volName: ConstStr255Param; fsid: INTEGER; mediaStatus: INTEGER; volTypeSelector: INTEGER; volSize: LONGINT; extendedInfoPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $3F00, $A9E9;
	{$ENDC}
FUNCTION DIReformat(drvNum: INTEGER; fsid: INTEGER; volName: ConstStr255Param; msgText: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $3F00, $A9E9;
	{$ENDC}
{$ELSEC}

PROCEDURE DILoad;
PROCEDURE DIUnload;
FUNCTION DIBadMount(where: Point; evtMessage: LONGINT): INTEGER;
FUNCTION DIFormat(drvNum: INTEGER): OSErr;
FUNCTION DIVerify(drvNum: INTEGER): OSErr;
FUNCTION DIZero(drvNum: INTEGER; volName: ConstStr255Param): OSErr;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DiskInitIncludes}

{$ENDC} {__DISKINIT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

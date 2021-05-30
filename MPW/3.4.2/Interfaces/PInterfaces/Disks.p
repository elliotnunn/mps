{
 	File:		Disks.p
 
 	Contains:	Disk Driver Interfaces.
 
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
 UNIT Disks;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DISKS__}
{$SETC __DISKS__ := 1}

{$I+}
{$SETC DisksIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	sony						= 0;
	hard20						= 1;


TYPE
	DrvSts = RECORD
		track:					INTEGER;								{ current track }
		writeProt:				SignedByte;								{ bit 7 = 1 if volume is locked }
		diskInPlace:			SignedByte;								{ disk in drive }
		installed:				SignedByte;								{ drive installed }
		sides:					SignedByte;								{ -1 for 2-sided, 0 for 1-sided }
		qLink:					QElemPtr;								{ next queue entry }
		qType:					INTEGER;								{ 1 for HD20 }
		dQDrive:				INTEGER;								{ drive number }
		dQRefNum:				INTEGER;								{ driver reference number }
		dQFSID:					INTEGER;								{ file system ID }
		CASE INTEGER OF
		0: (
			twoSideFmt:					SignedByte;							{ after 1st rd/wrt: 0=1 side, -1=2 side }
			needsFlush:					SignedByte;							{ -1 for MacPlus drive }
			diskErrs:					INTEGER;							{ soft error count }
		   );
		1: (
			driveSize:					INTEGER;
			driveS1:					INTEGER;
			driveType:					INTEGER;
			driveManf:					INTEGER;
			driveChar:					INTEGER;
			driveMisc:					SignedByte;
		   );
	END;


FUNCTION DiskEject(drvNum: INTEGER): OSErr;
FUNCTION SetTagBuffer(buffPtr: UNIV Ptr): OSErr;
FUNCTION DriveStatus(drvNum: INTEGER; VAR status: DrvSts): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DisksIncludes}

{$ENDC} {__DISKS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

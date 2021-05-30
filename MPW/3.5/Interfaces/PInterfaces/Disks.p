{
     File:       Disks.p
 
     Contains:   Disk Driver Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	sony						= 0;
	hard20						= 1;

	{	 Disk Driver Status csCodes 	}
	kReturnFormatList			= 6;							{  .Sony  }
	kDriveStatus				= 8;
	kMFMStatus					= 10;

	{	 Disk Driver Control csCodes 	}
	kVerify						= 5;
	kFormat						= 6;
	kEject						= 7;
	kSetTagBuffer				= 8;							{  .Sony  }
	kTrackCache					= 9;							{  .Sony  }
	kDriveIcon					= 21;
	kMediaIcon					= 22;
	kDriveInfo					= 23;
	kRawTrack					= 18244;						{  .Sony: “diagnostic” raw track dump  }

	{	
	    Note:
	
	    qLink is usually the first field in queues, but back in the MacPlus
	    days, the DrvSts record needed to be expanded.  In order to do this without
	    breaking disk drivers that already added stuff to the end, the fields
	    where added to the beginning.  This was originally done in assembly language
	    and the record was defined to start at a negative offset, so that the qLink
	    field would end up at offset zero.  When the C and pascal interfaces where
	    made, they could not support negative record offsets, so qLink was no longer
	    the first field.  Universal Interfaces are auto generated and don't support
	    negative offsets for any language, so DrvSts in Disks.a has qLinks at a
	    none zero offset.  Assembly code which switches to Universal Interfaces will
	    need to compensate for that.
	
		}

TYPE
	DrvStsPtr = ^DrvSts;
	DrvSts = RECORD
		track:					INTEGER;								{  current track  }
		writeProt:				SignedByte;								{  bit 7 = 1 if volume is locked  }
		diskInPlace:			SignedByte;								{  disk in drive  }
		installed:				SignedByte;								{  drive installed  }
		sides:					SignedByte;								{  -1 for 2-sided, 0 for 1-sided  }
		qLink:					QElemPtr;								{  next queue entry  }
		qType:					INTEGER;								{  1 for HD20  }
		dQDrive:				INTEGER;								{  drive number  }
		dQRefNum:				INTEGER;								{  driver reference number  }
		dQFSID:					INTEGER;								{  file system ID  }
		CASE INTEGER OF
		0: (
			twoSideFmt:			SignedByte;								{  after 1st rd/wrt: 0=1 side, -1=2 side  }
			needsFlush:			SignedByte;								{  -1 for MacPlus drive  }
			diskErrs:			INTEGER;								{  soft error count  }
		   );
		1: (
			driveSize:			INTEGER;
			driveS1:			INTEGER;
			driveType:			INTEGER;
			driveManf:			INTEGER;
			driveChar:			INTEGER;
			driveMisc:			SignedByte;
		   );
	END;

	DrvSts2								= DrvSts;
	DrvSts2Ptr 							= ^DrvSts2;

CONST
	kdqManualEjectBit			= 5;

{$IFC CALL_NOT_IN_CARBON }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  DiskEject()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION DiskEject(drvNum: INTEGER): OSErr;

{
 *  SetTagBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetTagBuffer(buffPtr: UNIV Ptr): OSErr;

{
 *  DriveStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DriveStatus(drvNum: INTEGER; VAR status: DrvSts): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  AddDrive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE AddDrive(drvrRefNum: INTEGER; drvNum: INTEGER; qEl: DrvQElPtr);

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GetDrvQHdr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetDrvQHdr: QHdrPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EBC, $0000, $0308;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete definitions                                                                             }
{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Status csCode previously defined in Devices.h/p/a.
 * This is obsolete and the new name should be used instead.
 }

CONST
	drvStsCode					= 8;							{  status call code for drive status  }

	{	 Control csCodes previously defined in Devices.h/p/a.
	 * These are obsolete and the new names should be used instead.
	 	}
	ejectCode					= 7;							{  control call eject code  }
	tgBuffCode					= 8;							{  set tag buffer code  }

	{	 Control csCodes previously defined in DriverGestalt.h/p/a.
	 * These are obsolete and the new names should be used instead.
	 	}
	VerifyCmd					= 5;
	FormatCmd					= 6;
	EjectCmd					= 7;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DisksIncludes}

{$ENDC} {__DISKS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

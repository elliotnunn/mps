{
     File:       AppleDiskPartitions.p
 
     Contains:   The Apple disk partition scheme as defined in Inside Macintosh: Volume V.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleDiskPartitions;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEDISKPARTITIONS__}
{$SETC __APPLEDISKPARTITIONS__ := 1}

{$I+}
{$SETC AppleDiskPartitionsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Block 0 Definitions }

CONST
	sbSIGWord					= $4552;						{  signature word for Block 0 ('ER')  }
	sbMac						= 1;							{  system type for Mac  }

	{	 Partition Map Signatures 	}
	pMapSIG						= $504D;						{  partition map signature ('PM')  }
	pdSigWord					= $5453;						{  partition map signature ('TS')  }
	oldPMSigWord				= $5453;
	newPMSigWord				= $504D;


	{	 Driver Descriptor Map 	}

TYPE
	Block0Ptr = ^Block0;
	Block0 = PACKED RECORD
		sbSig:					UInt16;									{  unique value for SCSI block 0  }
		sbBlkSize:				UInt16;									{  block size of device  }
		sbBlkCount:				UInt32;									{  number of blocks on device  }
		sbDevType:				UInt16;									{  device type  }
		sbDevId:				UInt16;									{  device id  }
		sbData:					UInt32;									{  not used  }
		sbDrvrCount:			UInt16;									{  driver descriptor count  }
		ddBlock:				UInt32;									{  1st driver's starting block  }
		ddSize:					UInt16;									{  size of 1st driver (512-byte blks)  }
		ddType:					UInt16;									{  system type (1 for Mac+)  }
		ddPad:					ARRAY [0..242] OF UInt16;				{  ARRAY[0..242] OF INTEGER; not used  }
	END;

	{	 Driver descriptor 	}
	DDMapPtr = ^DDMap;
	DDMap = RECORD
		ddBlock:				UInt32;									{  1st driver's starting block  }
		ddSize:					UInt16;									{  size of 1st driver (512-byte blks)  }
		ddType:					UInt16;									{  system type (1 for Mac+)  }
	END;

	{	 Constants for the ddType field of the DDMap structure. 	}

CONST
	kDriverTypeMacSCSI			= $0001;
	kDriverTypeMacATA			= $0701;
	kDriverTypeMacSCSIChained	= $FFFF;
	kDriverTypeMacATAChained	= $F8FF;

	{	 Partition Map Entry 	}

TYPE
	PartitionPtr = ^Partition;
	Partition = PACKED RECORD
		pmSig:					UInt16;									{  unique value for map entry blk  }
		pmSigPad:				UInt16;									{  currently unused  }
		pmMapBlkCnt:			UInt32;									{  # of blks in partition map  }
		pmPyPartStart:			UInt32;									{  physical start blk of partition  }
		pmPartBlkCnt:			UInt32;									{  # of blks in this partition  }
		pmPartName:				PACKED ARRAY [0..31] OF UInt8;			{  ASCII partition name  }
		pmParType:				PACKED ARRAY [0..31] OF UInt8;			{  ASCII partition type  }
		pmLgDataStart:			UInt32;									{  log. # of partition's 1st data blk  }
		pmDataCnt:				UInt32;									{  # of blks in partition's data area  }
		pmPartStatus:			UInt32;									{  bit field for partition status  }
		pmLgBootStart:			UInt32;									{  log. blk of partition's boot code  }
		pmBootSize:				UInt32;									{  number of bytes in boot code  }
		pmBootAddr:				UInt32;									{  memory load address of boot code  }
		pmBootAddr2:			UInt32;									{  currently unused  }
		pmBootEntry:			UInt32;									{  entry point of boot code  }
		pmBootEntry2:			UInt32;									{  currently unused  }
		pmBootCksum:			UInt32;									{  checksum of boot code  }
		pmProcessor:			PACKED ARRAY [0..15] OF UInt8;			{  ASCII for the processor type  }
		pmPad:					ARRAY [0..187] OF UInt16;				{  ARRAY[0..187] OF INTEGER; not used  }
	END;


	{	 Flags for the pmPartStatus field of the Partition data structure. 	}

CONST
	kPartitionAUXIsValid		= $00000001;
	kPartitionAUXIsAllocated	= $00000002;
	kPartitionAUXIsInUse		= $00000004;
	kPartitionAUXIsBootValid	= $00000008;
	kPartitionAUXIsReadable		= $00000010;
	kPartitionAUXIsWriteable	= $00000020;
	kPartitionAUXIsBootCodePositionIndependent = $00000040;
	kPartitionIsWriteable		= $00000020;
	kPartitionIsMountedAtStartup = $40000000;
	kPartitionIsStartup			= $80000000;
	kPartitionIsChainCompatible	= $00000100;
	kPartitionIsRealDeviceDriver = $00000200;
	kPartitionCanChainToNext	= $00000400;




	{	 Well known driver signatures, stored in the first four byte of pmPad. 	}
	kPatchDriverSignature		= 'ptDR';						{  SCSI and ATA[PI] patch driver     }
	kSCSIDriverSignature		= $00010600;					{  SCSI  hard disk driver            }
	kATADriverSignature			= 'wiki';						{  ATA   hard disk driver            }
	kSCSICDDriverSignature		= 'CDvr';						{  SCSI  CD-ROM    driver            }
	kATAPIDriverSignature		= 'ATPI';						{  ATAPI CD-ROM    driver            }
	kDriveSetupHFSSignature		= 'DSU1';						{  Drive Setup HFS partition         }



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleDiskPartitionsIncludes}

{$ENDC} {__APPLEDISKPARTITIONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

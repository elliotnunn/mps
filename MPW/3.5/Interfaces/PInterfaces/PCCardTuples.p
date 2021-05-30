{
     File:       PCCardTuples.p
 
     Contains:   List of PCMCIA tuple types and definitions of tuple contents.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc.  All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCardTuples;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARDTUPLES__}
{$SETC __PCCARDTUPLES__ := 1}

{$I+}
{$SETC PCCardTuplesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	MAX_TUPLE_SIZE				= 256;

	{	————————————————————————————————————————————————————————————————————————
	    Defines for Tuple codes
	————————————————————————————————————————————————————————————————————————	}
	CISTPL_NULL					= $00;
	CISTPL_DEVICE				= $01;
	CISTPL_LONGLINK_CB			= $02;
	CISTPL_INDIRECT				= $03;
	CISTPL_CONFIG_CB			= $04;
	CISTPL_CFTABLE_ENTRY_CB		= $05;
	CISTPL_LONGLINK_MFC			= $06;
	CISTPL_BAR					= $07;
	CISTPL_CHECKSUM				= $10;
	CISTPL_LONGLINK_A			= $11;
	CISTPL_LONGLINK_C			= $12;
	CISTPL_LINKTARGET			= $13;
	CISTPL_NO_LINK				= $14;
	CISTPL_VERS_1				= $15;
	CISTPL_ALTSTR				= $16;
	CISTPL_DEVICE_A				= $17;
	CISTPL_JEDEC_C				= $18;
	CISTPL_JEDEC_A				= $19;
	CISTPL_CONFIG				= $1A;
	CISTPL_CFTABLE_ENTRY		= $1B;
	CISTPL_DEVICE_OC			= $1C;
	CISTPL_DEVICE_OA			= $1D;
	CISTPL_DEVICE_GEO			= $1E;
	CISTPL_DEVICE_GEO_A			= $1F;
	CISTPL_MANFID				= $20;
	CISTPL_FUNCID				= $21;
	CISTPL_FUNCE				= $22;
	CISTPL_SWIL					= $23;
	CISTPL_VERS_2				= $40;
	CISTPL_FORMAT				= $41;
	CISTPL_GEOMETRY				= $42;
	CISTPL_BYTEORDER			= $43;
	CISTPL_DATE					= $44;
	CISTPL_BATTERY				= $45;
	CISTPL_ORG					= $46;
	CISTPL_VENDOR				= $FE;
	CISTPL_END					= $FF;


	{	————————————————————————————————————————————————————————————————————————
	    Tuple Data Block Definitions
	————————————————————————————————————————————————————————————————————————	}

	{ ------------    Device Information Tuple (01H, 17H)    -----------                             }


TYPE
	DeviceIDTuplePtr = ^DeviceIDTuple;
	DeviceIDTuple = RECORD
		TPLDEV_TYPE_WPS_SPEED:	SInt8;									{  Device Type Code: 7-4, WPS: 3,  Device Speed: 2-0 }
		deviceData:				PACKED ARRAY [0..252] OF Byte;
	END;


CONST
	TPLDEV_TYPE_MASK			= $F0;							{  device type mask for TPLDEV_TYPE_WPS_SPEED }
	TPLDEV_TYPE_EXTENDED		= $E0;							{  device type value for extended type }
	TPLDEV_WPS_MASK				= $08;							{  write-protect switch mask for TPLDEV_TYPE_WPS_SPEED }
	TPLDEV_SPEED_MASK			= $07;							{  device speed mask for TPLDEV_TYPE_WPS_SPEED }
	TPLDEV_DSPEED_NULL			= $00;							{  speed for null device type }
	TPLDEV_DSPEED_250NS			= $01;							{  250ns card access time }
	TPLDEV_DSPEED_200NS			= $02;							{  200ns card access time }
	TPLDEV_DSPEED_150NS			= $03;							{  150ns card access time }
	TPLDEV_DSPEED_100NS			= $04;							{  100ns card access time }
	TPLDEV_EXTENDED_SPEED		= $07;							{  device speed value for extended speed }
	TPLDEV_SPEED_EXPONENT		= $07;							{  extended byte exponent mask }
	TPLDEV_SPEED_MANTISSA		= $78;							{  extended byte mantissa mask }
	TPLDEV_SPEED_EXTENDED_MASK	= $80;							{  bit set if more extended speed data follows }


	{   device ID types }

	DTYPE_NULL					= 0;
	DTYPE_ROM					= 1;
	DTYPE_OTPROM				= 2;
	DTYPE_EPROM					= 3;
	DTYPE_EEPROM				= 4;
	DTYPE_FLASH					= 5;
	DTYPE_SRAM					= 6;
	DTYPE_DRAM					= 7;
	DTYPE_FUNCSPEC				= $0D;
	DTYPE_EXTEND				= $0E;


	{ ---------------    Checksum Control Tuple (10H)    ---------------                             }


TYPE
	ChecksumControlTuplePtr = ^ChecksumControlTuple;
	ChecksumControlTuple = RECORD
		TPLCKS_ADDR:			INTEGER;								{  offset to region to be checksummed, LSB first }
		TPLCKS_LEN:				INTEGER;								{  length of region to be checksummed, LSB first }
		TPLCKS_CS:				SInt8;									{  checksum of the region }
		reserved:				SInt8;									{  padding }
	END;

	{ ----------------    Long Link Multi-Function Tuple (06H)    ------                     }

	LongLinkMFCTuplePtr = ^LongLinkMFCTuple;
	LongLinkMFCTuple = PACKED RECORD
		TPLMFC_NUM:				UInt8;									{  Number of sets of config registers for individual functions }
		TPLMFC_TAS1:			UInt8;									{  CIS target address space for first function (00 = Attr, 01 = Common) }
		TPLMFC_ADDR1:			UInt32;									{  Target address of first CIS, unsigned long, lsb first }
		TPLMFC_TAS2:			UInt8;									{  CIS target address space for second function (00 = Attr, 01 = Common) }
		TPLMFC_ADDR2:			PACKED ARRAY [0..3] OF UInt8;			{  [MISALIGNED!] Target address of second CIS, unsigned long, lsb first }
																		{  the following fields are of undetermined length and should be calculated at runtime }
																		{   }
																		{  UInt8   TPLMFC_TASn; }
																		{  UInt32     TPLMFC_ADDRn; }
	END;

	{ ----------------    Long Link Tuple (11H, 12H)    ----------------                             }

	LongLinkTuplePtr = ^LongLinkTuple;
	LongLinkTuple = RECORD
		TPLL_ADDR:				UInt32;									{  target address, LSB first }
	END;

	{ -----------------    Link Target Tuple (13H)    ------------------                             }

	LinkTargetTuplePtr = ^LinkTargetTuple;
	LinkTargetTuple = RECORD
		TPLL_TAG:				PACKED ARRAY [0..2] OF Byte;			{  tag: should be 'C', 'I', 'S' }
	END;

	{ ----------------    Level 1 Version Tuple (15H)    ---------------                             }

	Level1VersionTuplePtr = ^Level1VersionTuple;
	Level1VersionTuple = RECORD
		TPLLV1_MAJOR:			SInt8;									{  major version number (0x04) }
		TPLLV1_MINOR:			SInt8;									{  minor version number (0x01 for release 2.0 and 2.01) }
		TPLLV1_INFO:			SInt8;									{  product information string, zero-terminated }
	END;

	{ -------------    JEDEC Identifier Tuple (18H, 19H)    ------------                             }

	JEDECDeviceInfoPtr = ^JEDECDeviceInfo;
	JEDECDeviceInfo = RECORD
		manufacturerID:			SInt8;
		manufacturerInfo:		SInt8;
	END;

	JEDECIdentifierTuplePtr = ^JEDECIdentifierTuple;
	JEDECIdentifierTuple = RECORD
		device:					ARRAY [0..0] OF JEDECDeviceInfo;
	END;

	{ ---------    Configuration Tuple (1AH)    ----------                           }

	ConfigTuplePtr = ^ConfigTuple;
	ConfigTuple = RECORD
		TPCC_SZ:				SInt8;									{  size of fields byte }
		TPCC_LAST:				SInt8;									{  index number of last config entry }
		TPCC_RADR:				SInt8;									{  config reg's base addr in reg. space }
		reserved:				SInt8;									{  padding }
																		{  the following fields are of undetermined length and should be calculated at runtime }
																		{ UInt32       TPCC_RMSK; }
																		{ UInt32       TPCC_RSVD; }
																		{ UInt32       TPCC_SBTPL; }
	END;

	{   TPCC_RADR field definitions }

CONST
	TPCC_RASZ					= $03;							{  bits 1-0 }
	TPCC_RMSZ					= $3C;							{  bits 5-2 }
	TPCC_RFSZ					= $C0;							{  bits 7-6 }


	{ ---------    Device Geometry Tuple (1EH, 1FH)    ---------- }


TYPE
	DeviceGeometryPtr = ^DeviceGeometry;
	DeviceGeometry = RECORD
		DGTPL_BUS:				SInt8;									{  system bus width = 2^(n-1), n>0 }
		DGTPL_EBS:				SInt8;									{  erase block size = 2^(n-1), n>0 }
		DGTPL_RBS:				SInt8;									{  read block size = 2^(n-1), n>0 }
		DGTPL_WBS:				SInt8;									{  write block size = 2^(n-1), n>0 }
		DGTPL_PART:				SInt8;									{  partitioning size = 2^(n-1), n>0 }
		DGTPL_HWIL:				SInt8;									{  hardware interleave = 2^(n-1), n>0 }
	END;

	DeviceGeometryTuplePtr = ^DeviceGeometryTuple;
	DeviceGeometryTuple = RECORD
		device:					ARRAY [0..41] OF DeviceGeometry;
	END;

	{ ---------    Manufacturer Identification Tuple (20H)    ----------                             }

	ManufIDTuplePtr = ^ManufIDTuple;
	ManufIDTuple = RECORD
		TPLMID_MANF:			INTEGER;								{  PCMCIA PC Card manufacturer code }
		TPLMID_CARD:			INTEGER;								{  manufacturer information (part number and/or revision) }
	END;

	{ -----------    Function Identification Tuple (21H)    ------------                             }

	FunctionIDTuplePtr = ^FunctionIDTuple;
	FunctionIDTuple = RECORD
		TPLFID_FUNCTION:		SInt8;									{  PC card function code }
		TPLFID_SYSINIT:			SInt8;									{  system initialization bit mask }
	END;

	{   function codes }

CONST
	TPLFID_MultiFunction		= 0;
	TPLFID_Memory				= 1;
	TPLFID_SerialPort			= 2;
	TPLFID_ParallelPort			= 3;
	TPLFID_FixedDisk			= 4;
	TPLFID_VideoAdapter			= 5;
	TPLFID_NetworkLANAdapter	= 6;
	TPLFID_AIMS					= 7;
	TPLFID_SCSI					= 8;
	TPLFID_Security				= 9;


	{ ------------    Software Interleave Tuple (23H)    ---------------                             }


TYPE
	SoftwareInterleaveTuplePtr = ^SoftwareInterleaveTuple;
	SoftwareInterleaveTuple = RECORD
		TPLSWIL_INTRLV:			SInt8;									{  software interleave }
	END;

	{ -------    Level 2 Version and Information Tuple (40H)    --------                             }

	Level2VersionTuplePtr = ^Level2VersionTuple;
	Level2VersionTuple = RECORD
		TPLLV2_VERS:			SInt8;									{  structure version (0x00) }
		TPLLV2_COMPLY:			SInt8;									{  level of compliance with the standard (0x00) }
		TPLLV2_DINDEX:			UInt16;									{  byte address of first data byte in card, LSB first }
		TPLLV2_RSV6:			SInt8;									{  reserved, must be zero }
		TPLLV2_RSV7:			SInt8;									{  reserved, must be zero }
		TPLLV2_VSPEC8:			SInt8;									{  vendor specific byte }
		TPLLV2_VSPEC9:			SInt8;									{  vendor specific byte }
		TPLLV2_NHDR:			SInt8;									{  number of copies of CIS present on this device }
		TPLLV2_OEM:				SInt8;									{  vendor of software that formatted card, zero-terminated }
		TPLLV2_INFO:			SInt8;									{  informational message about the card, zero-terminated }
		reserved:				SInt8;									{  padding }
	END;

	{ --------------------    Format Tuple (41H)    --------------------                             }

	{  additional information for disk type: }

	FormatDiskTuplePtr = ^FormatDiskTuple;
	FormatDiskTuple = RECORD
		TPLFMT_BKSZ:			UInt16;									{     block size, or zero if unblocked format }
		TPLFMT_NBLOCKS:			UInt32;									{     number of data blocks in this partition }
		TPLFMT_EDCLOC:			UInt32;									{     location of error detection code, or zero if interleaved }
	END;

	{  additional information for disk type: }
	FormatMemTuplePtr = ^FormatMemTuple;
	FormatMemTuple = RECORD
		TPLFMT_FLAGS:			SInt8;									{     various flags }
		TPLFMT_RESERVED:		SInt8;									{     reserved, set to zero }
		TPLFMT_ADDRESS:			UInt32;									{     physical location at which this memory partion must be mapped }
		TPLFMT_EDCLOC:			UInt32;									{     location of error detection code, or zero if interleaved }
	END;

	FormatTuplePtr = ^FormatTuple;
	FormatTuple = RECORD
		TPLFMT_TYPE:			SInt8;									{  format type code }
		TPLFMT_EDC:				SInt8;									{  error detection method and length of error detection code }
		TPLFMT_OFFSET:			LONGINT;								{  offset to first data byte in this partition }
		TPLFMT_NBYTES:			LONGINT;								{  number of data bytes in this partition }
		CASE INTEGER OF
		0: (
			TPLFMT_DISK:		FormatDiskTuple;
			);
		1: (
			TPLFMT_MEM:			FormatMemTuple;
			);
	END;

	{   format types }

CONST
	TPLFMTTYPE_DISK				= 0;
	TPLFMTTYPE_MEM				= 1;
	TPLFMTTYPE_VS				= $80;

	{   error detection types }

	TPLFMTEDC_NONE				= 0;
	TPLFMTEDC_CKSUM				= 1;
	TPLFMTEDC_CRC				= 2;
	TPLFMTEDC_PCC				= 3;
	TPLFMTEDC_VS				= 8;

	{   bits in TPLFMT_FLAGS }

	TPLFMTFLAGS_ADDR			= 0;
	TPLFMTFLAGS_AUTO			= 1;


	{ ------------------    Geometry Tuple (42H)    --------------------                             }


TYPE
	GeometryTuplePtr = ^GeometryTuple;
	GeometryTuple = RECORD
		TPLGEO_SPT:				SInt8;									{  number of sectors per track }
		TPLGEO_TPC:				SInt8;									{  number of tracks per cylinder }
		TPLGEO_NCYL:			INTEGER;								{  number of cylinders, total }
	END;

	{ -----------------    Byte-Order Tuple (43H)    -------------------                             }

	ByteOrderTuplePtr = ^ByteOrderTuple;
	ByteOrderTuple = RECORD
		TPLBYTE_ORDER:			SInt8;									{  byte order code }
		TPLBYTE_MAP:			SInt8;									{  byte mapping code }
	END;

	{   byte order codes }

CONST
	TYPBYTEORD_LOW				= 0;
	TYPBYTEORD_HIGH				= 1;
	TYPBYTEORD_VS				= $80;

	{   byte mapping codes }

	TYPBYTEMAP_LOW				= 0;
	TYPBYTEMAP_HIGH				= 1;
	TYPBYTEMAP_VS				= $80;


	{ ----------    Card Initialization Date Tuple (44H)    ------------                             }


TYPE
	CardInitDateTuplePtr = ^CardInitDateTuple;
	CardInitDateTuple = RECORD
		TPLDATE_TIME:			UInt16;									{  hours, minutes, seconds }
		TPLDATE_DAY:			UInt16;									{  year, month, day }
	END;

	{ ----------    Battery-Replacement Date Tuple (45H)    ------------                             }

	BatteryReplaceDateTuplePtr = ^BatteryReplaceDateTuple;
	BatteryReplaceDateTuple = RECORD
		TPLBATT_RDAY:			UInt16;									{  last replacement date (year, month, day) }
		TPLBATT_XDAY:			UInt16;									{  battery expiration date (year, month, day) }
	END;


	{ ----------------------    General Tuple    -----------------------                             }

	TupleBodyPtr = ^TupleBody;
	TupleBody = RECORD
		CASE INTEGER OF
		0: (
			deviceID:			DeviceIDTuple;
			);
		1: (
			checksum:			ChecksumControlTuple;
			);
		2: (
			link:				LongLinkTuple;
			);
		3: (
			target:				LinkTargetTuple;
			);
		4: (
			level1:				Level1VersionTuple;
			);
		5: (
			jedecID:			JEDECIdentifierTuple;
			);
		6: (
			config:				ConfigTuple;
			);
		7: (
			devGeo:				DeviceGeometryTuple;
			);
		8: (
			manufID:			ManufIDTuple;
			);
		9: (
			funcID:				FunctionIDTuple;
			);
		10: (
			swil:				SoftwareInterleaveTuple;
			);
		11: (
			level2:				Level2VersionTuple;
			);
		12: (
			format:				FormatTuple;
			);
		13: (
			geometry:			GeometryTuple;
			);
		14: (
			order:				ByteOrderTuple;
			);
		15: (
			initDate:			CardInitDateTuple;
			);
		16: (
			battDate:			BatteryReplaceDateTuple;
			);
		17: (
			tupleData:			PACKED ARRAY [0..253] OF Byte;
			);
	END;

	TuplePtr = ^Tuple;
	Tuple = RECORD
		TPL_CODE:				SInt8;
		TPL_LINK:				SInt8;
		TPL_BODY:				TupleBody;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardTuplesIncludes}

{$ENDC} {__PCCARDTUPLES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

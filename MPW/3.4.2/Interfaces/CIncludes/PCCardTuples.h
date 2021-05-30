/*
 	File:		PCCardTuples.h
 
 	Contains:	List of PCMCIA tuple types and definitions of tuple contents.

 	Version:	Technology: PCMCIA Software 2.0
				Package:	Universal Interfaces 2.1.1 in “MPW Latest” on ETO #19
  
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
  
*/

#ifndef __PCCARDTUPLES__
#define __PCCARDTUPLES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	MAX_TUPLE_SIZE				= 256
};

/*————————————————————————————————————————————————————————————————————————
	Defines for Tuple codes
————————————————————————————————————————————————————————————————————————*/
enum {
	CISTPL_NULL					= 0x00,
	CISTPL_DEVICE				= 0x01,
	CISTPL_LONGLINK_MFC			= 0x06,
	CISTPL_CHECKSUM				= 0x10,
	CISTPL_LONGLINK_A			= 0x11,
	CISTPL_LONGLINK_C			= 0x12,
	CISTPL_LINKTARGET			= 0x13,
	CISTPL_NO_LINK				= 0x14,
	CISTPL_VERS_1				= 0x15,
	CISTPL_ALTSTR				= 0x16,
	CISTPL_DEVICE_A				= 0x17,
	CISTPL_JEDEC_C				= 0x18,
	CISTPL_JEDEC_A				= 0x19,
	CISTPL_CONFIG				= 0x1A,
	CISTPL_CFTABLE_ENTRY		= 0x1B,
	CISTPL_DEVICE_OC			= 0x1C,
	CISTPL_DEVICE_OA			= 0x1D,
	CISTPL_DEVICE_GEO			= 0x1E,
	CISTPL_DEVICE_GEO_A			= 0x1F,
	CISTPL_MANFID				= 0x20,
	CISTPL_FUNCID				= 0x21,
	CISTPL_FUNCE				= 0x22,
	CISTPL_SWIL					= 0x23,
	CISTPL_VERS_2				= 0x40,
	CISTPL_FORMAT				= 0x41,
	CISTPL_GEOMETRY				= 0x42,
	CISTPL_BYTEORDER			= 0x43,
	CISTPL_DATE					= 0x44,
	CISTPL_BATTERY				= 0x45,
	CISTPL_ORG					= 0x46,
	CISTPL_VENDOR				= 0xFE,
	CISTPL_END					= 0xFF
};

/*————————————————————————————————————————————————————————————————————————
	Tuple Data Block Definitions
————————————————————————————————————————————————————————————————————————*/
/*------------    Device Information Tuple (01H, 17H)    -----------							*/
typedef struct DeviceIDTuple DeviceIDTuple;

struct DeviceIDTuple {
	Byte							TPLDEV_TYPE_WPS_SPEED;		/* Device Type Code: 7-4, WPS: 3,  Device Speed: 2-0*/
	Byte							deviceData[MAX_TUPLE_SIZE - 3];
};

enum {
	TPLDEV_TYPE_MASK			= 0xF0,							/* device type mask for TPLDEV_TYPE_WPS_SPEED*/
	TPLDEV_TYPE_EXTENDED		= 0xE0,							/* device type value for extended type*/
	TPLDEV_WPS_MASK				= 0x08,							/* write-protect switch mask for TPLDEV_TYPE_WPS_SPEED*/
	TPLDEV_SPEED_MASK			= 0x07,							/* device speed mask for TPLDEV_TYPE_WPS_SPEED*/
	TPLDEV_DSPEED_NULL			= 0x00,							/* speed for null device type*/
	TPLDEV_DSPEED_250NS			= 0x01,							/* 250ns card access time*/
	TPLDEV_DSPEED_200NS			= 0x02,							/* 200ns card access time*/
	TPLDEV_DSPEED_150NS			= 0x03,							/* 150ns card access time*/
	TPLDEV_DSPEED_100NS			= 0x04,							/* 100ns card access time*/
	TPLDEV_EXTENDED_SPEED		= 0x07,							/* device speed value for extended speed*/
	TPLDEV_SPEED_EXPONENT		= 0x07,							/* extended byte exponent mask*/
	TPLDEV_SPEED_MANTISSA		= 0x78,							/* extended byte mantissa mask*/
	TPLDEV_SPEED_EXTENDED_MASK	= 0x80							/* bit set if more extended speed data follows*/
};

/*	device ID types*/
enum {
	DTYPE_NULL,
	DTYPE_ROM,
	DTYPE_OTPROM,
	DTYPE_EPROM,
	DTYPE_EEPROM,
	DTYPE_FLASH,
	DTYPE_SRAM,
	DTYPE_DRAM,
	DTYPE_FUNCSPEC				= 0x0D,
	DTYPE_EXTEND
};

/*---------------    Checksum Control Tuple (10H)    ---------------							*/
typedef struct ChecksumControlTuple ChecksumControlTuple;

struct ChecksumControlTuple {
	short							TPLCKS_ADDR;				/* offset to region to be checksummed, LSB first*/
	short							TPLCKS_LEN;					/* length of region to be checksummed, LSB first*/
	char							TPLCKS_CS;					/* checksum of the region*/
	Byte							reserved;					/* padding*/
};
/*----------------    Long Link Multi-Function Tuple (06H)    ------					*/
typedef struct LongLinkMFCTuple LongLinkMFCTuple;

struct LongLinkMFCTuple {
	UInt8							TPLMFC_NUM;					/* Number of sets of config registers for individual functions*/
	UInt8							TPLMFC_TAS1;				/* CIS target address space for first function (00 = Attr, 01 = Common)*/
	UInt32							TPLMFC_ADDR1;				/* Target address of first CIS, unsigned long, lsb first*/
	UInt8							TPLMFC_TAS2;				/* CIS target address space for second function (00 = Attr, 01 = Common)*/
	UInt32							TPLMFC_ADDR2;				/* Target address of second CIS, unsigned long, lsb first*/
/* the following fields are of undetermined length and should be calculated at runtime*/
/* */
/* UInt8		TPLMFC_TASn;*/
/* UInt32		TPLMFC_ADDRn;*/
};
/*----------------    Long Link Tuple (11H, 12H)    ----------------							*/
typedef struct LongLinkTuple LongLinkTuple;

struct LongLinkTuple {
	UInt32							TPLL_ADDR;					/* target address, LSB first*/
};
/*-----------------    Link Target Tuple (13H)    ------------------							*/
typedef struct LinkTargetTuple LinkTargetTuple;

struct LinkTargetTuple {
	Byte							TPLL_TAG[3];				/* tag: should be 'C', 'I', 'S'*/
};
/*----------------    Level 1 Version Tuple (15H)    ---------------							*/
typedef struct Level1VersionTuple Level1VersionTuple;

struct Level1VersionTuple {
	Byte							TPLLV1_MAJOR;				/* major version number (0x04)*/
	Byte							TPLLV1_MINOR;				/* minor version number (0x01 for release 2.0 and 2.01)*/
	Byte							TPLLV1_INFO[1];				/* product information string, zero-terminated*/
};
/*-------------    JEDEC Identifier Tuple (18H, 19H)    ------------							*/
typedef struct JEDECDeviceInfo JEDECDeviceInfo;

struct JEDECDeviceInfo {
	Byte							manufacturerID;
	Byte							manufacturerInfo;
};
typedef struct JEDECIdentifierTuple JEDECIdentifierTuple;

struct JEDECIdentifierTuple {
	JEDECDeviceInfo					device[1];
};
/*---------    Configuration Tuple (1AH)    ----------							*/
typedef struct ConfigTuple ConfigTuple;

struct ConfigTuple {
	Byte							TPCC_SZ;					/* size of fields byte*/
	Byte							TPCC_LAST;					/* index number of last config entry*/
	Byte							TPCC_RADR;					/* config reg's base addr in reg. space*/
	Byte							reserved;					/* padding*/
/* the following fields are of undetermined length and should be calculated at runtime*/
/*UInt32			TPCC_RMSK;*/
/*UInt32			TPCC_RSVD;*/
/*UInt32			TPCC_SBTPL;*/
};
/*	TPCC_RADR field definitions*/

enum {
	TPCC_RASZ					= 0x03,							/* bits 1-0*/
	TPCC_RMSZ					= 0x3C,							/* bits 5-2*/
	TPCC_RFSZ					= 0xC0							/* bits 7-6*/
};

/*---------    Device Geometry Tuple (1EH, 1FH)    ----------*/
typedef struct DeviceGeometry DeviceGeometry;

struct DeviceGeometry {
	UInt8							DGTPL_BUS;					/* system bus width = 2^(n-1), n>0*/
	UInt8							DGTPL_EBS;					/* erase block size = 2^(n-1), n>0*/
	UInt8							DGTPL_RBS;					/* read block size = 2^(n-1), n>0*/
	UInt8							DGTPL_WBS;					/* write block size = 2^(n-1), n>0*/
	UInt8							DGTPL_PART;					/* partitioning size = 2^(n-1), n>0*/
	UInt8							DGTPL_HWIL;					/* hardware interleave = 2^(n-1), n>0*/
};
typedef struct DeviceGeometryTuple DeviceGeometryTuple;

struct DeviceGeometryTuple {
	DeviceGeometry					device[42];
};
/*---------    Manufacturer Identification Tuple (20H)    ----------							*/
typedef struct ManufIDTuple ManufIDTuple;

struct ManufIDTuple {
	short							TPLMID_MANF;				/* PCMCIA PC Card manufacturer code*/
	short							TPLMID_CARD;				/* manufacturer information (part number and/or revision)*/
};
/*-----------    Function Identification Tuple (21H)    ------------							*/
typedef struct FunctionIDTuple FunctionIDTuple;

struct FunctionIDTuple {
	Byte							TPLFID_FUNCTION;			/* PC card function code*/
	Byte							TPLFID_SYSINIT;				/* system initialization bit mask*/
};
/*	function codes*/

enum {
	TPLFID_MultiFunction,
	TPLFID_Memory,
	TPLFID_SerialPort,
	TPLFID_ParallelPort,
	TPLFID_FixedDisk,
	TPLFID_VideoAdaptor,
	TPLFID_NetworkLANAdaptor,
	TPLFID_AIMS
};

/*------------    Software Interleave Tuple (23H)    ---------------							*/
typedef struct SoftwareInterleaveTuple SoftwareInterleaveTuple;

struct SoftwareInterleaveTuple {
	char							TPLSWIL_INTRLV;				/* software interleave*/
};
/*-------    Level 2 Version and Information Tuple (40H)    --------							*/
typedef struct Level2VersionTuple Level2VersionTuple;

struct Level2VersionTuple {
	Byte							TPLLV2_VERS;				/* structure version (0x00)*/
	Byte							TPLLV2_COMPLY;				/* level of compliance with the standard (0x00)*/
	UInt16							TPLLV2_DINDEX;				/* byte address of first data byte in card, LSB first*/
	Byte							TPLLV2_RSV6;				/* reserved, must be zero*/
	Byte							TPLLV2_RSV7;				/* reserved, must be zero*/
	Byte							TPLLV2_VSPEC8;				/* vendor specific byte*/
	Byte							TPLLV2_VSPEC9;				/* vendor specific byte*/
	char							TPLLV2_NHDR;				/* number of copies of CIS present on this device*/
	char							TPLLV2_OEM[1];				/* vendor of software that formatted card, zero-terminated*/
	char							TPLLV2_INFO[1];				/* informational message about the card, zero-terminated*/
	Byte							reserved;					/* padding*/
};
/*--------------------    Format Tuple (41H)    --------------------							*/
/* additional information for disk type:*/
typedef struct FormatDiskTuple FormatDiskTuple;

struct FormatDiskTuple {
	UInt16							TPLFMT_BKSZ;				/*	block size, or zero if unblocked format*/
	UInt32							TPLFMT_NBLOCKS;				/*	number of data blocks in this partition*/
	UInt32							TPLFMT_EDCLOC;				/*	location of error detection code, or zero if interleaved*/
};
/* additional information for disk type:*/
typedef struct FormatMemTuple FormatMemTuple;

struct FormatMemTuple {
	Byte							TPLFMT_FLAGS;				/*	various flags*/
	Byte							TPLFMT_RESERVED;			/*	reserved, set to zero*/
	UInt32							TPLFMT_ADDRESS;				/*	physical location at which this memory partion must be mapped*/
	UInt32							TPLFMT_EDCLOC;				/*	location of error detection code, or zero if interleaved*/
};
typedef struct FormatTuple FormatTuple;

struct FormatTuple {
	char							TPLFMT_TYPE;				/* format type code*/
	char							TPLFMT_EDC;					/* error detection method and length of error detection code*/
	long							TPLFMT_OFFSET;				/* offset to first data byte in this partition*/
	long							TPLFMT_NBYTES;				/* number of data bytes in this partition*/
	union {
		FormatDiskTuple					TPLFMT_DISK;
		FormatMemTuple					TPLFMT_MEM;
	}								u;
};
/*	format types*/

enum {
	TPLFMTTYPE_DISK,
	TPLFMTTYPE_MEM,
	TPLFMTTYPE_VS				= 0x80
};

/*	error detection types*/
enum {
	TPLFMTEDC_NONE,
	TPLFMTEDC_CKSUM,
	TPLFMTEDC_CRC,
	TPLFMTEDC_PCC,
	TPLFMTEDC_VS				= 8
};

/*	bits in TPLFMT_FLAGS*/
enum {
	TPLFMTFLAGS_ADDR,
	TPLFMTFLAGS_AUTO
};

/*------------------    Geometry Tuple (42H)    --------------------							*/
typedef struct GeometryTuple GeometryTuple;

struct GeometryTuple {
	char							TPLGEO_SPT;					/* number of sectors per track*/
	char							TPLGEO_TPC;					/* number of tracks per cylinder*/
	short							TPLGEO_NCYL;				/* number of cylinders, total*/
};
/*-----------------    Byte-Order Tuple (43H)    -------------------							*/
typedef struct ByteOrderTuple ByteOrderTuple;

struct ByteOrderTuple {
	char							TPLBYTE_ORDER;				/* byte order code*/
	char							TPLBYTE_MAP;				/* byte mapping code*/
};
/*	byte order codes*/

enum {
	TYPBYTEORD_LOW,
	TYPBYTEORD_HIGH,
	TYPBYTEORD_VS				= 0x80
};

/*	byte mapping codes*/
enum {
	TYPBYTEMAP_LOW,
	TYPBYTEMAP_HIGH,
	TYPBYTEMAP_VS				= 0x80
};

/*----------    Card Initialization Date Tuple (44H)    ------------							*/
typedef struct CardInitDateTuple CardInitDateTuple;

struct CardInitDateTuple {
	UInt16							TPLDATE_TIME;				/* hours, minutes, seconds*/
	UInt16							TPLDATE_DAY;				/* year, month, day*/
};
/*----------    Battery-Replacement Date Tuple (45H)    ------------							*/
typedef struct BatteryReplaceDateTuple BatteryReplaceDateTuple;

struct BatteryReplaceDateTuple {
	UInt16							TPLBATT_RDAY;				/* last replacement date (year, month, day)*/
	UInt16							TPLBATT_XDAY;				/* battery expiration date (year, month, day)*/
};
/*----------------------    General Tuple    -----------------------							*/
typedef union TupleBody TupleBody;

union TupleBody {
	DeviceIDTuple					deviceID;
	ChecksumControlTuple			checksum;
	LongLinkTuple					link;
	LinkTargetTuple					target;
	Level1VersionTuple				level1;
	JEDECIdentifierTuple			jedecID;
	ConfigTuple						config;
	DeviceGeometryTuple				devGeo;
	ManufIDTuple					manufID;
	FunctionIDTuple					funcID;
	SoftwareInterleaveTuple			swil;
	Level2VersionTuple				level2;
	FormatTuple						format;
	GeometryTuple					geometry;
	ByteOrderTuple					order;
	CardInitDateTuple				initDate;
	BatteryReplaceDateTuple			battDate;
	Byte							tupleData[MAX_TUPLE_SIZE - 2];
};
typedef struct Tuple Tuple;

struct Tuple {
	Byte							TPL_CODE;
	Byte							TPL_LINK;
	TupleBody						TPL_BODY;
};

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PCCARDTUPLES__ */

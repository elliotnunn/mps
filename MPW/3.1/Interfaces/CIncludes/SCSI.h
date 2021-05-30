/************************************************************

Created: Thursday, September 7, 1989 at 7:18 PM
	SCSI.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1986-1989
	All rights reserved

************************************************************/


#ifndef __SCSI__
#define __SCSI__

#ifndef __TYPES__
#include <Types.h>
#endif

#define scInc 1
#define scNoInc 2
#define scAdd 3
#define scMove 4
#define scLoop 5
#define scNop 6
#define scStop 7
#define scComp 8
#define scCommErr 2 				/*communications error, operation timeout*/
#define scArbNBErr 3				/*arbitration timeout waiting for not BSY*/
#define scBadParmsErr 4 			/*bad parameter or TIB opcode*/
#define scPhaseErr 5				/*SCSI bus not in correct phase for attempted operation*/
#define scCompareErr 6				/*data compare error*/
#define scMgrBusyErr 7				/*SCSI Manager busy */
#define scSequenceErr 8 			/*attempted operation is out of sequence*/
#define scBusTOErr 9				/*CPU bus timeout*/
#define scComplPhaseErr 10			/*SCSI bus wasn't in Status phase*/
#define sbSIGWord 0x4552
#define pMapSIG 0x504D

struct Block0 {
	unsigned short sbSig;			/*unique value for SCSI block 0*/
	unsigned short sbBlkSize;		/*block size of device*/
	unsigned long sbBlkCount;		/*number of blocks on device*/
	unsigned short sbDevType;		/*device type*/
	unsigned short sbDevId; 		/*device id*/
	unsigned long sbData;			/*not used*/
	unsigned short sbDrvrCount; 	/*driver descriptor count*/
	unsigned long ddBlock;			/*1st driver's starting block*/
	unsigned short ddSize;			/*size of 1st driver (512-byte blks)*/
	unsigned short ddType;			/*system type (1 for Mac+)*/
	unsigned short ddPad[243];		/*ARRAY[0..242] OF INTEGER; not used*/
};

typedef struct Block0 Block0;
struct Partition {
	unsigned short pmSig;			/*unique value for map entry blk*/
	unsigned short pmSigPad;		/*currently unused*/
	unsigned long pmMapBlkCnt;		/*# of blks in partition map*/
	unsigned long pmPyPartStart;	/*physical start blk of partition*/
	unsigned long pmPartBlkCnt; 	/*# of blks in this partition*/
	unsigned char pmPartName[32];	/*ASCII partition name*/
	unsigned char pmParType[32];	/*ASCII partition type*/
	unsigned long pmLgDataStart;	/*log. # of partition's 1st data blk*/
	unsigned long pmDataCnt;		/*# of blks in partition's data area*/
	unsigned long pmPartStatus; 	/*bit field for partition status*/
	unsigned long pmLgBootStart;	/*log. blk of partition's boot code*/
	unsigned long pmBootSize;		/*number of bytes in boot code*/
	unsigned long pmBootAddr;		/*memory load address of boot code*/
	unsigned long pmBootAddr2;		/*currently unused*/
	unsigned long pmBootEntry;		/*entry point of boot code*/
	unsigned long pmBootEntry2; 	/*currently unused*/
	unsigned long pmBootCksum;		/*checksum of boot code*/
	unsigned char pmProcessor[16];	/*ASCII for the processor type*/
	unsigned short pmPad[188];		/*512 bytes long currently unused*/
};

typedef struct Partition Partition;
struct SCSIInstr {
	unsigned short scOpcode;
	unsigned long scParam1;
	unsigned long scParam2;
};

typedef struct SCSIInstr SCSIInstr;
#ifdef __cplusplus
extern "C" {
#endif
pascal OSErr SCSIReset(void);
pascal OSErr SCSIGet(void); 
pascal OSErr SCSISelect(short targetID);
pascal OSErr SCSICmd(Ptr buffer,short count);
pascal OSErr SCSIRead(Ptr tibPtr);
pascal OSErr SCSIRBlind(Ptr tibPtr);
pascal OSErr SCSIWrite(Ptr tibPtr); 
pascal OSErr SCSIWBlind(Ptr tibPtr);
pascal OSErr SCSIComplete(short *stat,short *message,unsigned long wait);
pascal short SCSIStat(void);
pascal OSErr SCSISelAtn(short targetID);
pascal OSErr SCSIMsgIn(short *message); 
pascal OSErr SCSIMsgOut(short message); 
#ifdef __cplusplus
}
#endif

#endif

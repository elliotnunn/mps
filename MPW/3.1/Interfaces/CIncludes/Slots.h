/************************************************************

Created: Thursday, September 7, 1989 at 7:29 PM
	Slots.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1986-1989
	All rights reserved

************************************************************/


#ifndef __SLOTS__
#define __SLOTS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#define fCardIsChanged 1			/*Card is Changed field in StatusFlags field of sInfoArray*/
#define fCkForSame 0				/*For SearchSRT. Flag to check for SAME sResource in the table. */
#define fCkForNext 1				/*For SearchSRT. Flag to check for NEXT sResource in the table. */
#define fWarmStart 2				/*If this bit is set then warm start else cold start.*/
#define stateNil 0					/*State*/
#define stateSDMInit 1				/*:Slot declaration manager Init*/
#define statePRAMInit 2 			/*:sPRAM record init*/
#define statePInit 3				/*:Primary init*/
#define stateSInit 4				/*:Secondary init*/

struct SlotIntQElement {
	Ptr sqLink; 					/*ptr to next element*/
	short sqType;					/*queue type ID for validity*/
	short sqPrio;					/*priority*/
	ProcPtr sqAddr; 				/*interrupt service routine*/
	long sqParm;					/*optional A1 parameter*/
};

typedef struct SlotIntQElement SlotIntQElement;
typedef SlotIntQElement *SQElemPtr;

struct SpBlock {
	long spResult;					/*FUNCTION Result*/
	Ptr spsPointer; 				/*structure pointer*/
	long spSize;					/*size of structure*/
	long spOffsetData;				/*offset/data field used by sOffsetData*/
	Ptr spIOFileName;				/*ptr to IOFile name for sDisDrvrName*/
	Ptr spsExecPBlk;				/*pointer to sExec parameter block.*/
	Ptr spStackPtr; 				/*old Stack pointer.*/
	long spMisc;					/*misc field for SDM.*/
	long spReserved;				/*reserved for future expansion*/
	short spIOReserved; 			/*Reserved field of Slot Resource Table*/
	short spRefNum; 				/*RefNum*/
	short spCategory;				/*sType: Category*/
	short spCType;					/*Type*/
	short spDrvrSW; 				/*DrvrSW*/
	short spDrvrHW; 				/*DrvrHW*/
	char spTBMask;					/*type bit mask bits 0..3 mask words 0..3*/
	char spSlot;					/*slot number*/
	char spID;						/*structure ID*/
	char spExtDev;					/*ID of the external device*/
	char spHwDev;					/*Id of the hardware device.*/
	char spByteLanes;				/*bytelanes from card ROM format block*/
	char spFlags;					/*standard flags*/
	char spKey; 					/*Internal use only*/
};

typedef struct SpBlock SpBlock;
typedef SpBlock *SpBlockPtr;

struct SInfoRecord {
	Ptr siDirPtr;					/*Pointer to directory*/
	short siInitStatusA;			/*initialization E*/
	short siInitStatusV;			/*status returned by vendor init code*/
	char siState;					/*initialization state*/
	char siCPUByteLanes;			/*0=[d0..d7] 1=[d8..d15]*/
	char siTopOfROM;				/*Top of ROM= $FssFFFFx: x is TopOfROM*/
	char siStatusFlags; 			/*bit 0 - card is changed*/
	short siTOConst;				/*Time Out C for BusErr*/
	char siReserved[2]; 			/*reserved*/
};

typedef struct SInfoRecord SInfoRecord;
typedef SInfoRecord *SInfoRecPtr;

struct SDMRecord {
	ProcPtr sdBEVSave;				/*Save old BusErr vector*/
	ProcPtr sdBusErrProc;			/*Go here to determine if it is a BusErr*/
	ProcPtr sdErrorEntry;			/*Go here if BusErrProc finds real BusErr*/
	long sdReserved;				/*Reserved*/
};

typedef struct SDMRecord SDMRecord;
struct FHeaderRec {
	long fhDirOffset;				/*offset to directory*/
	long fhLength;					/*length of ROM*/
	long fhCRC; 					/*CRC*/
	char fhROMRev;					/*revision of ROM*/
	char fhFormat;					/*format - 2*/
	long fhTstPat;					/*test pattern*/
	char fhReserved;				/*reserved*/
	char fhByteLanes;				/*ByteLanes*/
};

typedef struct FHeaderRec FHeaderRec;
typedef FHeaderRec *FHeaderRecPtr;

struct SEBlock {
	unsigned char seSlot;			/*Slot number.*/
	unsigned char sesRsrcId;		/*sResource Id.*/
	short seStatus; 				/*Status of code executed by sExec.*/
	unsigned char seFlags;			/*Flags*/
	unsigned char seFiller0;		/*Filler, must be SignedByte to align on odd boundry*/
	unsigned char seFiller1;		/*Filler*/
	unsigned char seFiller2;		/*Filler*/
	long seResult;					/*Result of sLoad.*/
	long seIOFileName;				/*Pointer to IOFile name.*/
	unsigned char seDevice; 		/*Which device to read from.*/
	unsigned char sePartition;		/*The partition.*/
	unsigned char seOSType; 		/*Type of OS.*/
	unsigned char seReserved;		/*Reserved field.*/
	unsigned char seRefNum; 		/*RefNum of the driver.*/
	unsigned char seNumDevices; 	/* Number of devices to load.*/
	unsigned char seBootState;		/*State of StartBoot code.*/
};

typedef struct SEBlock SEBlock;
#ifdef __cplusplus
extern "C" {
#endif
pascal OSErr SIntInstall(SQElemPtr sIntQElemPtr,short theSlot); 
pascal OSErr SIntRemove(SQElemPtr sIntQElemPtr,short theSlot);
pascal OSErr SReadByte(SpBlockPtr spBlkPtr);
pascal OSErr SReadWord(SpBlockPtr spBlkPtr);
pascal OSErr SReadLong(SpBlockPtr spBlkPtr);
pascal OSErr SGetCString(SpBlockPtr spBlkPtr);
pascal OSErr SGetBlock(SpBlockPtr spBlkPtr);
pascal OSErr SFindStruct(SpBlockPtr spBlkPtr);
pascal OSErr SReadStruct(SpBlockPtr spBlkPtr);
pascal OSErr SReadInfo(SpBlockPtr spBlkPtr);
pascal OSErr SReadPRAMRec(SpBlockPtr spBlkPtr); 
pascal OSErr SPutPRAMRec(SpBlockPtr spBlkPtr);
pascal OSErr SReadFHeader(SpBlockPtr spBlkPtr); 
pascal OSErr SNextSRsrc(SpBlockPtr spBlkPtr);
pascal OSErr SNextTypeSRsrc(SpBlockPtr spBlkPtr);
pascal OSErr SRsrcInfo(SpBlockPtr spBlkPtr);
pascal OSErr SCkCardStat(SpBlockPtr spBlkPtr);
pascal OSErr SReadDrvrName(SpBlockPtr spBlkPtr);
pascal OSErr SFindDevBase(SpBlockPtr spBlkPtr); 
pascal OSErr SFindBigDevBase(SpBlockPtr spBlkPtr);
pascal OSErr InitSDeclMgr(SpBlockPtr spBlkPtr); 
pascal OSErr SPrimaryInit(SpBlockPtr spBlkPtr); 
pascal OSErr SCardChanged(SpBlockPtr spBlkPtr); 
pascal OSErr SExec(SpBlockPtr spBlkPtr);
pascal OSErr SOffsetData(SpBlockPtr spBlkPtr);
pascal OSErr SInitPRAMRecs(SpBlockPtr spBlkPtr);
pascal OSErr SReadPBSize(SpBlockPtr spBlkPtr);
pascal OSErr SCalcStep(SpBlockPtr spBlkPtr);
pascal OSErr SInitSRsrcTable(SpBlockPtr spBlkPtr);
pascal OSErr SSearchSRT(SpBlockPtr spBlkPtr);
pascal OSErr SUpdateSRT(SpBlockPtr spBlkPtr);
pascal OSErr SCalcSPointer(SpBlockPtr spBlkPtr);
pascal OSErr SGetDriver(SpBlockPtr spBlkPtr);
pascal OSErr SPtrToSlot(SpBlockPtr spBlkPtr);
pascal OSErr SFindSInfoRecPtr(SpBlockPtr spBlkPtr); 
pascal OSErr SFindSRsrcPtr(SpBlockPtr spBlkPtr);
pascal OSErr SDeleteSRTRec(SpBlockPtr spBlkPtr);
pascal OSErr OpenSlot(ParmBlkPtr paramBlock,Boolean aSync); 
#ifdef __cplusplus
}
#endif

#endif

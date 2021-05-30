/*
	ncOSIntf.h -- new Operating System Interfaces

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1986-1987
	All rights reserved.
*/


#ifndef __NOSINTF__
#define __NOSINTF__
#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif
#ifndef __OSUTILS__
#include <OSUtils.h>
#endif


				/* StatusFlags constants */
#define fCardIsChanged	1		/* Card is Changed field in StatusFlags field of sInfoArray */
#define fCkForSame		0		/* For SearchSRT. Flag to check for SAME sResource in the table.  */
#define fCkForNext		1		/* For SearchSRT. Flag to check for NEXT sResource in the table.  */
#define fWarmStart		2		/* If this bit is set then warm start, else cold start. */

				/* State constants */ 
#define stateNil		0			/* State	:Nil */
#define stateSDMInit	1			/* 		:Slot declaration manager Init */
#define statePRAMInit	2			/* 		:sPRAM record init */
#define statePInit		3			/* 		:Primary init */
#define stateSInit		4			/* 		:Secondary init */


				/* Device Manager Slot Support */

typedef struct SlotIntQElement{
	Ptr				sqLink;				/* ptr to next element */
	short			sqType;				/* queue type ID for validity */
	short			sqPrio;				/* priority */
	ProcPtr			sqAddr;				/* interrupt service routine */
	long			sqParm;				/* optional A1 parameter */
} SlotIntQElement, *SQElemPtr;
				  

				/* Slot Declaration Manager */

typedef struct SpBlock{						/* PACKED RECORD */
	long			spResult;			/* FUNCTION Result. [Used by: every function] */
	Ptr				spsPointer;			/* Structure pointer */
	long			spSize;				/* Size of structure */
	long			spOffsetData;		/* Offset/Data field.  [Used by:sOffsetData] */
	Ptr				spIOFileName;		/* Pointer to IOFile name. [Used by sDisDrvrName] */
	Ptr				spsExecPBlk;		/* Pointer to sExec parameter block. */
	Ptr				spStackPtr;			/* Old Stack pointer. */
	long			spMisc;				/* Misc field for SDM. */
	long			spReserved;			/* Reserved for future expansion */
	long			spIOReserved;		/* Reserved field of Slot Resource Table */
	short			spRefNum;			/* RefNum */
	short			spCategory;			/* sType: Category	 */
	short			spCType;			/* 		  Type		 */
	short			spDrvrSW;  			/* 		  DrvrSW	 */
	short			spDrvrHW;  			/* 		  DrvrHW	 */
	char			spTBMask;			/* Type bit mask (Bits 0..3 determine which words 0..3 to mask). */
	char	  		spSlot;				/* Slot number */
	char			spID;				/* Structure ID */
	char			spExtDev;			/* Id of the external device. */
	char			spHwDev;			/* Id of the hardware device. */
	char			spByteLanes;		/* Bytelanes value from FHeader in the declaration ROM. */	 
	char			spFlags;			/* Flags passed to routines (SSearchSRT,_InitSDeclMgr,... */
	char			spKey;				/* Internal use only. */
} SpBlock, *SpBlockPtr;

typedef struct SInfoRecord{					/* PACKED RECORD */
	Ptr				siDirPtr;			/* Pointer to directory */
	short			siInitStatusA;		/* initialization error */
	short			siInitStatusV;		/* status returned by vendor init code */
	char			siState;			/* initialization state */
	char			siCPUByteLanes;		/* 0=[d0..d7], 1=[d8..d15], ... */
	char			siTopOfROM;			/* Top of ROM = $FssFFFFx, where x is TopOfROM. */
	char			siStatusFlags;		/* bit 0 - card is changed */
	short			siTOConst;			/* Time Out Constant for BusErr */
	char			siReserved[2];		/* reserved */
} SInfoRecord, *SInfoRecPtr;


typedef struct SDMRecord{						/* PACKED RECORD */
	ProcPtr			sdBEVSave;			/* Save old BusErr vector. */
	ProcPtr			sdBusErrProc;		/* Go here to determine if it is a BusErr. */
	ProcPtr			sdErrorEntry;		/* Go here if BusErrProc determines it is really a BusErr. */
	long			sdReserved;			/* Reserved */
} SDMRecord;
			  

typedef struct FHeaderRec{						/* PACKED RECORD */
	long			fhDirOffset;		/* offset to directory */
	long			fhLength;			/* length of ROM */
	long			fhCRC;				/* CRC */
	char			fhROMRev;			/* revision of ROM */
	char			fhFormat;			/* format - 2 */
	long			fhTstPat;			/* test pattern */
	short			fhReserved;			/* reserved */
	char			fhByteLanes;		/* ByteLanes */
} FHeaderRec, *FHeaderRecPtr;


typedef struct SEBlock{							/* PACKED RECORD */
	unsigned char	seSlot;				/* Slot number. */
	unsigned char	sesRsrcId;			/* sResource Id. */
	short			seStatus;			/* Status of code executed by sExec. */
	unsigned char	seFlags;			/* Flags. */
	unsigned char	seFiller0;			/* Filler, must be SignedByte to align on odd boundry */
	unsigned char	seFiller1;			/* Filler */
	unsigned char	seFiller2;			/* Filler */
											/*  extensions for sLoad + sBoot  */
	long			seResult;			/* Result of sLoad. */
	long			seIOFileName;		/* Pointer to IOFile name. */
	unsigned char	seDevice;			/* Which device to read from. */
	unsigned char	sePartition;		/* The partition. */
	unsigned char	seOSType;			/* Type of OS. */
	unsigned char	seReserved;			/* Reserved field. */
	unsigned char	seRefNum;			/*  RefNum of the driver. */
											/*  extensions for sBoot  */
	unsigned char	seNumDevices;		/* Number of devices to load. */
	unsigned char	seBootState;		/* State of StartBoot code. */
} SEBlock;

typedef struct SEHeader1{						/* PACKED RECORD */
	unsigned char	seRevision;			/* Revision of seBlock. Must be same as SEHeader2 */
	unsigned char	seCPUId;			/* Id of CPU */
	short			seTimeOut;			/* Time Out */
	unsigned char	seCode;				/* Beginning of code. */
} SEHeader1;
				
typedef struct SEHeader2{						/* PACKED RECORD */
	unsigned char	seRevision;			/* Revision of seBlock. Must be same as SEHeader1 */
	unsigned char	seCPUId;			/* Id of CPU */
	short			seTimeOut;			/* Time Out */
	long			seCodeOffset;		/* Offset to code. */
} SEHeader2;

typedef struct SRRBlock{							/*  PACKED RECORD */
	char			srrHWDev;			/* Hardware device id. */
	char			srrSlot;			/* Slot */
	char			srrId;				/* Id */
	char			srrExtDev;			/* External Device */
	short			srrRefNum;			/* RefNum of driver */
	short			srrIOReserved;		/* Reserved */
	short			srrCategory;		/* sType:	Category */
	short			srrCType;			/* 		Type	 */
	short			srrDrvrSW; 			/* 		DrvrSW	 */
	short			srrDrvrHW;  		/* 		DrvrHW	 */
	Ptr				srrsRsrcPtr;		/* Pointer to sResource */
} SRRBlock;


				/* Apple Desktop Bus */

typedef struct ADBOpBlock{
	Ptr				dataBuffPtrr;      	/* address of data buffer */
	Ptr				opServiceRtPtr;		/* service routine pointer */
	Ptr				opDataAreaPtr;		/* optional data area address */
} ADBOpBlock, *ADBOpBPtr;

typedef struct ADBDataBlock{						/* PACKED RECORD */
	char			devType;			/* device type */
	char			origADBAddr;		/* original ADB Address */
	Ptr				dbServiceRtPtr;		/* service routine pointer */
	Ptr				dbDataAreaAddr;		/* data area address */
} ADBDataBlock, *ADBDBlkPtr;

typedef struct ADBSetInfoBlock{
	Ptr				siServiceRtPtr;     /* service routine pointer */
	Ptr				siDataAreaAddr;		/* data area address */
} ADBSetInfoBlock, *ADBSInfoPtr;

typedef char ADBAddress;


				/* Memory Manager */

typedef long AnAddress;		/* pointers, handles, etc. need to be coerced
					 		to this type to be passed to StripAddress */
							
				/* Start Manager */

typedef struct DefaultRec{
	short			drDriveNum;
	short			drRefNum;
} DefaultRec, *DefRecPtr;

typedef struct DefaultVidRec{
	char			sdSlot;
	char			sdsResID;
} DefaultVidRec, *DefVidPtr;

typedef struct DefaultOSRec{
	char			sdOSType;
	char			sdReserved;
} DefaultOSRec, *DefOSPtr;


				/* Device Manager Slot Support */
				
pascal OSErr SIntInstall(sIntQElemPtr, theSlot)
	SQElemPtr sIntQElemPtr;
	short theSlot;
	extern;
pascal OSErr SIntRemove(sIntQElemPtr, theSlot)
	SQElemPtr sIntQElemPtr;
	short theSlot;
	extern;


				/* Slot Declaration Manager */
				
		/* Principle */
pascal OSErr SReadByte(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadWord(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadLong(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SGetcString(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SGetColorIcon(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SGetBlock(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SFindStruct(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadStruct(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
	
		/* Special */
pascal OSErr SReadInfo(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadPRAMRec(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SPutPRAMRec(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadFHeader(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SNextsRsrc(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SNextTypesRsrc(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SRsrcInfo(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SDisposePtr(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SCkCardStat(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadDrvrName(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SMacBoot(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SDetDevBase(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;

		/* Advanced */
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr InitSDeclMgr(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SPrimaryInit(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SCardChanged(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SExec(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SOffsetData(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SInitPRAMRecs(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SReadPBSize(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SNewPtr(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SCalcStep(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SInitsRsrcTable(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SSearchSRT(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SUpdateSRT(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SCalcsPointer(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SGetDriver(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SPtrToSlot(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SFindsInfoRecPtr(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SFindsRsrcPtr(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;
pascal OSErr SDeleteSRTRec(spBlkPtr)
	SpBlockPtr spBlkPtr;
	extern;

				/* Vertical Retrace Manager */
				
pascal OSErr SlotVInstall(VBLBlockPtr, theSlot)
	QElemPtr VBLBlockPtr;
	short theSlot;
	extern;
pascal OSErr SlotVRemove(VBLBlockPtr, theSlot)
	QElemPtr VBLBlockPtr;
	short theSlot;
	extern;
pascal OSErr AttachVBL(theSlot)
	short theSlot;
	extern;
pascal OSErr DoVBLTask(theSlot)
	short theSlot;
	extern;

				/* Apple Desktop Bus */
				
pascal void ADBReInit()
	extern 0xA07B;
pascal OSErr ADBOp(data, compRout, buffer, commandNum)
	Ptr data;
	ProcPtr compRout;
	Ptr buffer;
	short commandNum;
	extern;
pascal short CountADBs()
	extern;
pascal ADBAddress GetIndADB(info, devTableIndex)
	ADBDataBlock *info;
	short devTableIndex;
	extern;
pascal OSErr GetADBInfo(info, ADBAddr)
	ADBDataBlock *info;
	ADBAddress ADBAddr;
	extern;
pascal OSErr SetADBInfo(info, ADBAddr)
	ADBSetInfoBlock *info;
	ADBAddress ADBAddr;
	extern;

				/* Memory Manager */
				
pascal AnAddress StripAddress(theAddress)
	AnAddress theAddress;
	extern;

				/* Start Manager */
				
pascal void GetDefaultStartup(defaultRecPtr)
	DefRecPtr defaultRecPtr;
	extern;
pascal void SetDefaultStartup(defaultRecPtr)
	DefRecPtr defaultRecPtr;
	extern;
pascal void GetVideoDefault(defaultVidPtr)
	DefVidPtr defaultVidPtr;
	extern;
pascal void SetVideoDefault(defaultVidPtr)
	DefVidPtr defaultVidPtr;
	extern;
pascal void SetOSDefault(defaultOSPtr)
	DefOSPtr defaultOSPtr;
	extern;
pascal void GetOSDefault(defaultOSPtr)
	DefOSPtr defaultOSPtr;
	extern;


#endif


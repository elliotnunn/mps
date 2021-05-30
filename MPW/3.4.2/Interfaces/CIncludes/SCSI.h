/*
 	File:		SCSI.h
 
 	Contains:	SCSI Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __SCSI__
#define __SCSI__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

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
	scInc						= 1,
	scNoInc						= 2,
	scAdd						= 3,
	scMove						= 4,
	scLoop						= 5,
	scNop						= 6,
	scStop						= 7,
	scComp						= 8
};

/* SCSI Manager errors */
enum {
	scCommErr					= 2,							/* communications error, operation timeout */
	scArbNBErr					= 3,							/* arbitration timeout waiting for not BSY */
	scBadParmsErr				= 4,							/* bad parameter or TIB opcode */
	scPhaseErr					= 5,							/* SCSI bus not in correct phase for attempted operation */
	scCompareErr				= 6,							/* data compare error */
	scMgrBusyErr				= 7,							/* SCSI Manager busy  */
	scSequenceErr				= 8,							/* attempted operation is out of sequence */
	scBusTOErr					= 9,							/* CPU bus timeout */
	scComplPhaseErr				= 10							/* SCSI bus wasn't in Status phase */
};

/* Signatures */
enum {
	sbSIGWord					= 0x4552,						/* signature word for Block 0 ('ER') */
	sbMac						= 1,							/* system type for Mac */
	pMapSIG						= 0x504D,						/* partition map signature ('PM') */
	pdSigWord					= 0x5453
};

enum {
	oldPMSigWord				= pdSigWord,
	newPMSigWord				= pMapSIG
};

/* Driver Descriptor Map */
struct Block0 {
	unsigned short					sbSig;						/* unique value for SCSI block 0 */
	unsigned short					sbBlkSize;					/* block size of device */
	unsigned long					sbBlkCount;					/* number of blocks on device */
	unsigned short					sbDevType;					/* device type */
	unsigned short					sbDevId;					/* device id */
	unsigned long					sbData;						/* not used */
	unsigned short					sbDrvrCount;				/* driver descriptor count */
	unsigned long					ddBlock;					/* 1st driver's starting block */
	unsigned short					ddSize;						/* size of 1st driver (512-byte blks) */
	unsigned short					ddType;						/* system type (1 for Mac+) */
	unsigned short					ddPad[243];					/* ARRAY[0..242] OF INTEGER; not used */
};
typedef struct Block0 Block0;

/*Driver descriptor*/
struct DDMap {
	unsigned long					ddBlock;					/* 1st driver's starting block */
	unsigned short					ddSize;						/* size of 1st driver (512-byte blks) */
	unsigned short					ddType;						/* system type (1 for Mac+) */
};
typedef struct DDMap DDMap;

/* Partition Map Entry */
struct Partition {
	unsigned short					pmSig;						/* unique value for map entry blk */
	unsigned short					pmSigPad;					/* currently unused */
	unsigned long					pmMapBlkCnt;				/* # of blks in partition map */
	unsigned long					pmPyPartStart;				/* physical start blk of partition */
	unsigned long					pmPartBlkCnt;				/* # of blks in this partition */
	unsigned char					pmPartName[32];				/* ASCII partition name */
	unsigned char					pmParType[32];				/* ASCII partition type */
	unsigned long					pmLgDataStart;				/* log. # of partition's 1st data blk */
	unsigned long					pmDataCnt;					/* # of blks in partition's data area */
	unsigned long					pmPartStatus;				/* bit field for partition status */
	unsigned long					pmLgBootStart;				/* log. blk of partition's boot code */
	unsigned long					pmBootSize;					/* number of bytes in boot code */
	unsigned long					pmBootAddr;					/* memory load address of boot code */
	unsigned long					pmBootAddr2;				/* currently unused */
	unsigned long					pmBootEntry;				/* entry point of boot code */
	unsigned long					pmBootEntry2;				/* currently unused */
	unsigned long					pmBootCksum;				/* checksum of boot code */
	unsigned char					pmProcessor[16];			/* ASCII for the processor type */
	unsigned short					pmPad[188];					/* ARRAY[0..187] OF INTEGER; not used */
};
typedef struct Partition Partition;

/* TIB instruction */
struct SCSIInstr {
	unsigned short					scOpcode;
	long							scParam1;
	long							scParam2;
};
typedef struct SCSIInstr SCSIInstr;

extern pascal OSErr SCSIReset(void)
 TWOWORDINLINE(0x4267, 0xA815);
extern pascal OSErr SCSIGet(void)
 THREEWORDINLINE(0x3F3C, 0x0001, 0xA815);
extern pascal OSErr SCSISelect(short targetID)
 THREEWORDINLINE(0x3F3C, 0x0002, 0xA815);
extern pascal OSErr SCSICmd(Ptr buffer, short count)
 THREEWORDINLINE(0x3F3C, 0x0003, 0xA815);
extern pascal OSErr SCSIRead(Ptr tibPtr)
 THREEWORDINLINE(0x3F3C, 0x0005, 0xA815);
extern pascal OSErr SCSIRBlind(Ptr tibPtr)
 THREEWORDINLINE(0x3F3C, 0x0008, 0xA815);
extern pascal OSErr SCSIWrite(Ptr tibPtr)
 THREEWORDINLINE(0x3F3C, 0x0006, 0xA815);
extern pascal OSErr SCSIWBlind(Ptr tibPtr)
 THREEWORDINLINE(0x3F3C, 0x0009, 0xA815);
extern pascal OSErr SCSIComplete(short *stat, short *message, unsigned long wait)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xA815);
extern pascal short SCSIStat(void)
 THREEWORDINLINE(0x3F3C, 0x000A, 0xA815);
extern pascal OSErr SCSISelAtn(short targetID)
 THREEWORDINLINE(0x3F3C, 0x000B, 0xA815);
extern pascal OSErr SCSIMsgIn(short *message)
 THREEWORDINLINE(0x3F3C, 0x000C, 0xA815);
extern pascal OSErr SCSIMsgOut(short message)
 THREEWORDINLINE(0x3F3C, 0x000D, 0xA815);
/*——————————————————————— New SCSI Manager Interface ———————————————————————*/

enum {
	scsiVERSION					= 43
};

/* SCSI Manager function codes */
enum {
	SCSINop						= 0x00,							/* Execute nothing 										*/
	SCSIExecIO					= 0x01,							/* Execute the specified IO 							*/
	SCSIBusInquiry				= 0x03,							/* Get parameters for entire path of HBAs 				*/
	SCSIReleaseQ				= 0x04,							/* Release the frozen SIM queue for particular LUN 		*/
	SCSIAbortCommand			= 0x10,							/* Abort the selected Control Block  					*/
	SCSIResetBus				= 0x11,							/* Reset the SCSI bus  									*/
	SCSIResetDevice				= 0x12,							/* Reset the SCSI device  								*/
	SCSITerminateIO				= 0x13,							/* Terminate any pending IO  							*/
	SCSIGetVirtualIDInfo		= 0x80,							/* Find out which bus old ID is on 						*/
	SCSILoadDriver				= 0x82,							/* Load a driver for a device ident 					*/
	SCSIOldCall					= 0x84,							/* XPT->SIM private call for old-API 					*/
	SCSICreateRefNumXref		= 0x85,							/* Register a DeviceIdent to drvr RefNum xref 			*/
	SCSILookupRefNumXref		= 0x86,							/* Get DeviceIdent to drvr RefNum xref 					*/
	SCSIRemoveRefNumXref		= 0x87,							/* Remove a DeviceIdent to drvr RefNum xref 			*/
	SCSIRegisterWithNewXPT		= 0x88,							/* XPT has changed - SIM needs to re-register itself 	*/
	vendorUnique				= 0xC0							/* 0xC0 thru 0xFF */
};

/* SCSI Callback Procedure Prototypes */
/* SCSIInterruptPollProcPtr is obsolete (use SCSIInterruptProcPtr) but still here for compatibility */
typedef pascal void (*SCSICallbackProcPtr)(void *scsiPB);
typedef void (*AENCallbackProcPtr)(void);
typedef OSErr (*SIMInitProcPtr)(Ptr SIMinfoPtr);
typedef void (*SIMActionProcPtr)(void *scsiPB, Ptr SIMGlobals);
typedef void (*SCSIProcPtr)(void);
typedef void (*SCSIMakeCallbackProcPtr)(void *scsiPB);
typedef long (*SCSIInterruptPollProcPtr)(Ptr SIMGlobals);
typedef long (*SCSIInterruptProcPtr)(Ptr SIMGlobals);

#if GENERATINGCFM
typedef UniversalProcPtr SCSICallbackUPP;
typedef UniversalProcPtr AENCallbackUPP;
typedef UniversalProcPtr SIMInitUPP;
typedef UniversalProcPtr SIMActionUPP;
typedef UniversalProcPtr SCSIUPP;
typedef UniversalProcPtr SCSIMakeCallbackUPP;
typedef UniversalProcPtr SCSIInterruptPollUPP;
typedef UniversalProcPtr SCSIInterruptUPP;
#else
typedef SCSICallbackProcPtr SCSICallbackUPP;
typedef AENCallbackProcPtr AENCallbackUPP;
typedef SIMInitProcPtr SIMInitUPP;
typedef SIMActionProcPtr SIMActionUPP;
typedef SCSIProcPtr SCSIUPP;
typedef SCSIMakeCallbackProcPtr SCSIMakeCallbackUPP;
typedef SCSIInterruptPollProcPtr SCSIInterruptPollUPP;
typedef SCSIInterruptProcPtr SCSIInterruptUPP;
#endif

enum {
	uppSCSICallbackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*))),
	uppAENCallbackProcInfo = kCStackBased,
	uppSIMInitProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr))),
	uppSIMActionProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr))),
	uppSCSIProcInfo = kCStackBased,
	uppSCSIMakeCallbackProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*))),
	uppSCSIInterruptPollProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr))),
	uppSCSIInterruptProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
};

#if GENERATINGCFM
#define NewSCSICallbackProc(userRoutine)		\
		(SCSICallbackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCSICallbackProcInfo, GetCurrentArchitecture())
#define NewAENCallbackProc(userRoutine)		\
		(AENCallbackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppAENCallbackProcInfo, GetCurrentArchitecture())
#define NewSIMInitProc(userRoutine)		\
		(SIMInitUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSIMInitProcInfo, GetCurrentArchitecture())
#define NewSIMActionProc(userRoutine)		\
		(SIMActionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSIMActionProcInfo, GetCurrentArchitecture())
#define NewSCSIProc(userRoutine)		\
		(SCSIUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCSIProcInfo, GetCurrentArchitecture())
#define NewSCSIMakeCallbackProc(userRoutine)		\
		(SCSIMakeCallbackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCSIMakeCallbackProcInfo, GetCurrentArchitecture())
#define NewSCSIInterruptPollProc(userRoutine)		\
		(SCSIInterruptPollUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCSIInterruptPollProcInfo, GetCurrentArchitecture())
#define NewSCSIInterruptProc(userRoutine)		\
		(SCSIInterruptUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCSIInterruptProcInfo, GetCurrentArchitecture())
#else
#define NewSCSICallbackProc(userRoutine)		\
		((SCSICallbackUPP) (userRoutine))
#define NewAENCallbackProc(userRoutine)		\
		((AENCallbackUPP) (userRoutine))
#define NewSIMInitProc(userRoutine)		\
		((SIMInitUPP) (userRoutine))
#define NewSIMActionProc(userRoutine)		\
		((SIMActionUPP) (userRoutine))
#define NewSCSIProc(userRoutine)		\
		((SCSIUPP) (userRoutine))
#define NewSCSIMakeCallbackProc(userRoutine)		\
		((SCSIMakeCallbackUPP) (userRoutine))
#define NewSCSIInterruptPollProc(userRoutine)		\
		((SCSIInterruptPollUPP) (userRoutine))
#define NewSCSIInterruptProc(userRoutine)		\
		((SCSIInterruptUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSCSICallbackProc(userRoutine, scsiPB)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCSICallbackProcInfo, (scsiPB))
#define CallAENCallbackProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppAENCallbackProcInfo)
#define CallSIMInitProc(userRoutine, SIMinfoPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSIMInitProcInfo, (SIMinfoPtr))
#define CallSIMActionProc(userRoutine, scsiPB, SIMGlobals)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSIMActionProcInfo, (scsiPB), (SIMGlobals))
#define CallSCSIProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCSIProcInfo)
#define CallSCSIMakeCallbackProc(userRoutine, scsiPB)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCSIMakeCallbackProcInfo, (scsiPB))
#define CallSCSIInterruptPollProc(userRoutine, SIMGlobals)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCSIInterruptPollProcInfo, (SIMGlobals))
#define CallSCSIInterruptProc(userRoutine, SIMGlobals)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCSIInterruptProcInfo, (SIMGlobals))
#else
#define CallSCSICallbackProc(userRoutine, scsiPB)		\
		(*(userRoutine))((scsiPB))
#define CallAENCallbackProc(userRoutine)		\
		(*(userRoutine))()
#define CallSIMInitProc(userRoutine, SIMinfoPtr)		\
		(*(userRoutine))((SIMinfoPtr))
#define CallSIMActionProc(userRoutine, scsiPB, SIMGlobals)		\
		(*(userRoutine))((scsiPB), (SIMGlobals))
#define CallSCSIProc(userRoutine)		\
		(*(userRoutine))()
#define CallSCSIMakeCallbackProc(userRoutine, scsiPB)		\
		(*(userRoutine))((scsiPB))
#define CallSCSIInterruptPollProc(userRoutine, SIMGlobals)		\
		(*(userRoutine))((SIMGlobals))
#define CallSCSIInterruptProc(userRoutine, SIMGlobals)		\
		(*(userRoutine))((SIMGlobals))
#endif

enum {
	handshakeDataLength			= 8,							/* Handshake data length */
	maxCDBLength				= 16,							/* Space for the CDB bytes/pointer */
	vendorIDLength				= 16							/* ASCII string len for Vendor ID  */
};

/* Define DeviceIdent structure */
struct DeviceIdent {
	UInt8							diReserved;					/* reserved 				*/
	UInt8							bus;						/* SCSI - Bus Number		*/
	UInt8							targetID;					/* SCSI - Target SCSI ID	*/
	UInt8							LUN;						/* SCSI - LUN  				*/
};
typedef struct DeviceIdent DeviceIdent;

/* Command Descriptor Block structure */
union CDB {
	UInt8							*cdbPtr;					/* pointer to the CDB, or */
	UInt8							cdbBytes[maxCDBLength];		/* the actual CDB to send */
};
typedef union CDB CDB, *CDBPtr;

/* Scatter/gather list element */
struct SGRecord {
	Ptr								SGAddr;
	UInt32							SGCount;
};
typedef struct SGRecord SGRecord;

/* SCSI Phases (used by SIMs to support the Original SCSI Manager */

enum {
	kDataOutPhase,												/* Encoded MSG, C/D, I/O bits */
	kDataInPhase,
	kCommandPhase,
	kStatusPhase,
	kPhaseIllegal0,
	kPhaseIllegal1,
	kMessageOutPhase,
	kMessageInPhase,
	kBusFreePhase,												/* Additional Phases */
	kArbitratePhase,
	kSelectPhase,
	kMessageInPhaseNACK											/* Message In Phase with ACK hanging on the bus */
};

#define SCSIPBHdr 				\
	struct SCSIHdr * qLink;		\
	short	scsiReserved1;			\
	UInt16	scsiPBLength;			\
	UInt8	scsiFunctionCode;		\
	UInt8	scsiReserved2;			\
	OSErr	scsiResult;				\
	DeviceIdent	scsiDevice;		\
	SCSICallbackUPP	scsiCompletion;	 \
	UInt32	scsiFlags;				\
	UInt8 *	scsiDriverStorage;		\
	Ptr	scsiXPTprivate;			\
	long	scsiReserved3;
struct SCSIHdr {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
};
typedef struct SCSIHdr SCSIHdr;

struct SCSI_PB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
};
typedef struct SCSI_PB SCSI_PB;

#define SCSI_IO_Macro 			\
	SCSIPBHdr						\
	UInt16	scsiResultFlags;		\
	UInt16	scsiReserved3pt5;		\
	UInt8 *	scsiDataPtr;			\
	UInt32	scsiDataLength;			\
	UInt8 *	scsiSensePtr;			\
	UInt8	scsiSenseLength;			\
	UInt8	scsiCDBLength;			\
	UInt16	scsiSGListCount;		\
	UInt32	scsiReserved4;			\
	UInt8	scsiSCSIstatus;			\
	SInt8	scsiSenseResidual;		\
	UInt16	scsiReserved5;			\
	long	scsiDataResidual;			\
	CDB	scsiCDB;					\
	long	scsiTimeout;				\
	UInt8 *	scsiReserved5pt5;		\
	UInt16	scsiReserved5pt6;		\
	UInt16	scsiIOFlags;			\
	UInt8	scsiTagAction;			\
	UInt8	scsiReserved6;			\
	UInt16	scsiReserved7;			\
	UInt16	scsiSelectTimeout;		\
	UInt8	scsiDataType;			\
	UInt8	scsiTransferType;		\
	UInt32	scsiReserved8;			\
	UInt32	scsiReserved9;			\
	UInt16	scsiHandshake[handshakeDataLength];	 \
	UInt32	scsiReserved10;			\
	UInt32	scsiReserved11;			\
	struct SCSI_IO *scsiCommandLink;	 \
								\
	UInt8	scsiSIMpublics[8];		\
	UInt8	scsiAppleReserved6[8];	 \
								\
								\
								\
	UInt16	scsiCurrentPhase;		\
	short	scsiSelector;			\
	OSErr	scsiOldCallResult;		\
	UInt8	scsiSCSImessage;			\
	UInt8	XPTprivateFlags;			\
	UInt8	XPTextras[12];
struct SCSI_IO {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	UInt16							scsiResultFlags;
	UInt16							scsiReserved3pt5;
	UInt8							*scsiDataPtr;
	UInt32							scsiDataLength;
	UInt8							*scsiSensePtr;
	UInt8							scsiSenseLength;
	UInt8							scsiCDBLength;
	UInt16							scsiSGListCount;
	UInt32							scsiReserved4;
	UInt8							scsiSCSIstatus;
	SInt8							scsiSenseResidual;
	UInt16							scsiReserved5;
	long							scsiDataResidual;
	CDB								scsiCDB;
	long							scsiTimeout;
	UInt8							*scsiReserved5pt5;
	UInt16							scsiReserved5pt6;
	UInt16							scsiIOFlags;
	UInt8							scsiTagAction;
	UInt8							scsiReserved6;
	UInt16							scsiReserved7;
	UInt16							scsiSelectTimeout;
	UInt8							scsiDataType;
	UInt8							scsiTransferType;
	UInt32							scsiReserved8;
	UInt32							scsiReserved9;
	UInt16							scsiHandshake[handshakeDataLength];
	UInt32							scsiReserved10;
	UInt32							scsiReserved11;
	struct SCSI_IO					*scsiCommandLink;
	UInt8							scsiSIMpublics[8];
	UInt8							scsiAppleReserved6[8];
	UInt16							scsiCurrentPhase;
	short							scsiSelector;
	OSErr							scsiOldCallResult;
	UInt8							scsiSCSImessage;
	UInt8							XPTprivateFlags;
	UInt8							XPTextras[12];
};
typedef struct SCSI_IO SCSI_IO;

typedef SCSI_IO SCSIExecIOPB;

/* Bus inquiry PB */
struct SCSIBusInquiryPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	UInt16							scsiEngineCount;			/* <- Number of engines on HBA 						*/
	UInt16							scsiMaxTransferType;		/* <- Number of transfer types for this HBA			*/
	UInt32							scsiDataTypes;				/* <- which data types are supported by this SIM 	*/
	UInt16							scsiIOpbSize;				/* <- Size of SCSI_IO PB for this SIM/HBA 			*/
	UInt16							scsiMaxIOpbSize;			/* <- Size of max SCSI_IO PB for all SIM/HBAs 		*/
	UInt32							scsiFeatureFlags;			/* <- Supported features flags field 				*/
	UInt8							scsiVersionNumber;			/* <- Version number for the SIM/HBA 				*/
	UInt8							scsiHBAInquiry;				/* <- Mimic of INQ byte 7 for the HBA 				*/
	UInt8							scsiTargetModeFlags;		/* <- Flags for target mode support 				*/
	UInt8							scsiScanFlags;				/* <- Scan related feature flags 					*/
	UInt32							scsiSIMPrivatesPtr;			/* <- Ptr to SIM private data area 					*/
	UInt32							scsiSIMPrivatesSize;		/* <- Size of SIM private data area 				*/
	UInt32							scsiAsyncFlags;				/* <- Event cap. for Async Callback 				*/
	UInt8							scsiHiBusID;				/* <- Highest path ID in the subsystem  			*/
	UInt8							scsiInitiatorID;			/* <- ID of the HBA on the SCSI bus 				*/
	UInt16							scsiBIReserved0;			/*													*/
	UInt32							scsiBIReserved1;			/* <-  												*/
	UInt32							scsiFlagsSupported;			/* <- which scsiFlags are supported 				*/
	UInt16							scsiIOFlagsSupported;		/* <- which scsiIOFlags are supported 				*/
	UInt16							scsiWeirdStuff;				/* <- 												*/
	UInt16							scsiMaxTarget;				/* <- maximum Target number supported 				*/
	UInt16							scsiMaxLUN;					/* <- maximum Logical Unit number supported 		*/
	char							scsiSIMVendor[vendorIDLength]; /* <- Vendor ID of SIM (or XPT if bus<FF) 		*/
	char							scsiHBAVendor[vendorIDLength]; /* <- Vendor ID of the HBA 						*/
	char							scsiControllerFamily[vendorIDLength]; /* <- Family of SCSI Controller 				*/
	char							scsiControllerType[vendorIDLength]; /* <- Specific Model of SCSI Controller used 	*/
	char							scsiXPTversion[4];			/* <- version number of XPT 						*/
	char							scsiSIMversion[4];			/* <- version number of SIM 						*/
	char							scsiHBAversion[4];			/* <- version number of HBA 						*/
	UInt8							scsiHBAslotType;			/* <- type of "slot" that this HBA is in			*/
	UInt8							scsiHBAslotNumber;			/* <- slot number of this HBA 						*/
	UInt16							scsiSIMsRsrcID;				/* <- resource ID of this SIM 						*/
	UInt16							scsiBIReserved3;			/* <- 												*/
	UInt16							scsiAdditionalLength;		/* <- additional BusInquiry PB len					*/
};
typedef struct SCSIBusInquiryPB SCSIBusInquiryPB;

/* Abort SIM Request PB */
struct SCSIAbortCommandPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	SCSI_IO							*scsiIOptr;					/* Pointer to the PB to abort						*/
};
typedef struct SCSIAbortCommandPB SCSIAbortCommandPB;

/* Terminate I/O Process Request PB */
struct SCSITerminateIOPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	SCSI_IO							*scsiIOptr;					/* Pointer to the PB to terminate 					*/
};
typedef struct SCSITerminateIOPB SCSITerminateIOPB;

/* Reset SCSI Bus PB */
struct SCSIResetBusPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
};
typedef struct SCSIResetBusPB SCSIResetBusPB;

/* Reset SCSI Device PB */
struct SCSIResetDevicePB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
};
typedef struct SCSIResetDevicePB SCSIResetDevicePB;

/* Release SIM Queue PB */
struct SCSIReleaseQPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
};
typedef struct SCSIReleaseQPB SCSIReleaseQPB;

/* SCSI Get Virtual ID Info PB */
struct SCSIGetVirtualIDInfoPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	UInt16							scsiOldCallID;				/* -> SCSI ID of device in question 			*/
	Boolean							scsiExists;					/* <- true if device exists 					*/
	SInt8							filler;
};
typedef struct SCSIGetVirtualIDInfoPB SCSIGetVirtualIDInfoPB;

/* Create/Lookup/Remove RefNum for Device PB */
struct SCSIDriverPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	short							scsiDriver;					/* -> DriverRefNum, For SetDriver, <- For GetNextDriver */
	UInt16							scsiDriverFlags;			/* <> Details of driver/device 					*/
	DeviceIdent						scsiNextDevice;				/* <- DeviceIdent of the NEXT Item in the list  */
};
typedef struct SCSIDriverPB SCSIDriverPB;

/* Load Driver PB */
struct SCSILoadDriverPB {
	struct SCSIHdr					*qLink;
	short							scsiReserved1;
	UInt16							scsiPBLength;
	UInt8							scsiFunctionCode;
	UInt8							scsiReserved2;
	OSErr							scsiResult;
	DeviceIdent						scsiDevice;
	SCSICallbackUPP					scsiCompletion;
	UInt32							scsiFlags;
	UInt8							*scsiDriverStorage;
	Ptr								scsiXPTprivate;
	long							scsiReserved3;
	short							scsiLoadedRefNum;			/* <- SIM returns refnum of driver 					*/
	Boolean							scsiDiskLoadFailed;			/* -> if true, indicates call after failure to load */
	SInt8							filler;
};
typedef struct SCSILoadDriverPB SCSILoadDriverPB;

/* Defines for the scsiTransferType field */

enum {
	scsiTransferBlind			= 0,
	scsiTransferPolled
};

/* Defines for the scsiDataType field */
enum {
	scsiDataBuffer				= 0,							/* single contiguous buffer supplied  				*/
	scsiDataTIB					= 1,							/* TIB supplied (ptr in scsiDataPtr) 				*/
	scsiDataSG					= 2								/* scatter/gather list supplied  					*/
};

/* Defines for the SCSIMgr scsiResult field in the PB header. */
/*  $E100 thru  E1FF */
/* -$1EFF thru -1E00 */
/* -#7935 thru -7681  */
/* = 0xE100 */
enum {
	scsiErrorBase				= -7936
};

enum {
	scsiRequestInProgress		= 1,							/* 1	 = PB request is in progress 			*/
/* Execution failed  00-2F */
	scsiRequestAborted			= scsiErrorBase + 2,			/* -7934 = PB request aborted by the host 		*/
	scsiUnableToAbort			= scsiErrorBase + 3,			/* -7933 = Unable to Abort PB request 			*/
	scsiNonZeroStatus			= scsiErrorBase + 4,			/* -7932 = PB request completed with an err 	*/
	scsiUnused05				= scsiErrorBase + 5,			/* -7931 =  									*/
	scsiUnused06				= scsiErrorBase + 6,			/* -7930 =  									*/
	scsiUnused07				= scsiErrorBase + 7,			/* -7929 =  									*/
	scsiUnused08				= scsiErrorBase + 8,			/* -7928 =  									*/
	scsiUnableToTerminate		= scsiErrorBase + 9,			/* -7927 = Unable to Terminate I/O PB req 		*/
	scsiSelectTimeout			= scsiErrorBase + 10,			/* -7926 = Target selection timeout 			*/
	scsiCommandTimeout			= scsiErrorBase + 11,			/* -7925 = Command timeout  					*/
	scsiIdentifyMessageRejected	= scsiErrorBase + 12,			/* -7924 =  									*/
	scsiMessageRejectReceived	= scsiErrorBase + 13,			/* -7923 = Message reject received 				*/
	scsiSCSIBusReset			= scsiErrorBase + 14,			/* -7922 = SCSI bus reset sent/received 		*/
	scsiParityError				= scsiErrorBase + 15,			/* -7921 = Uncorrectable parity error occured 	*/
	scsiAutosenseFailed			= scsiErrorBase + 16,			/* -7920 = Autosense: Request sense cmd fail 	*/
	scsiUnused11				= scsiErrorBase + 17,			/* -7919 =  									*/
	scsiDataRunError			= scsiErrorBase + 18,			/* -7918 = Data overrun/underrun error  		*/
	scsiUnexpectedBusFree		= scsiErrorBase + 19,			/* -7917 = Unexpected BUS free 					*/
	scsiSequenceFailed			= scsiErrorBase + 20,			/* -7916 = Target bus phase sequence failure 	*/
	scsiWrongDirection			= scsiErrorBase + 21,			/* -7915 = Data phase was in wrong direction 	*/
	scsiUnused16				= scsiErrorBase + 22,			/* -7914 =  									*/
	scsiBDRsent					= scsiErrorBase + 23,			/* -7913 = A SCSI BDR msg was sent to target 	*/
	scsiTerminated				= scsiErrorBase + 24,			/* -7912 = PB request terminated by the host 	*/
	scsiNoNexus					= scsiErrorBase + 25,			/* -7911 = Nexus is not established 			*/
	scsiCDBReceived				= scsiErrorBase + 26,			/* -7910 = The SCSI CDB has been received 		*/
/* Couldn't begin execution  30-3F */
	scsiTooManyBuses			= scsiErrorBase + 48,			/* -7888 = Register failed because we're full	*/
	scsiBusy					= scsiErrorBase + 49,			/* -7887 = SCSI subsystem is busy 				*/
	scsiProvideFail				= scsiErrorBase + 50,			/* -7886 = Unable to provide requ. capability	*/
	scsiDeviceNotThere			= scsiErrorBase + 51,			/* -7885 = SCSI device not installed/there  	*/
	scsiNoHBA					= scsiErrorBase + 52,			/* -7884 = No HBA detected Error 				*/
	scsiDeviceConflict			= scsiErrorBase + 53,			/* -7883 = sorry, max 1 refNum per DeviceIdent 	*/
	scsiNoSuchXref				= scsiErrorBase + 54,			/* -7882 = no such RefNum xref 					*/
	scsiQLinkInvalid			= scsiErrorBase + 55,			/* -7881 = pre-linked PBs not supported			
																   (The QLink field was nonzero)		*/
/* Parameter errors  40-7F */
	scsiPBLengthError			= scsiErrorBase + 64,			/* -7872 = (scsiPBLength is insuf'ct/invalid 	*/
	scsiFunctionNotAvailable	= scsiErrorBase + 65,			/* -7871 = The requ. func is not available  	*/
	scsiRequestInvalid			= scsiErrorBase + 66,			/* -7870 = PB request is invalid 				*/
	scsiBusInvalid				= scsiErrorBase + 67,			/* -7869 = Bus ID supplied is invalid  			*/
	scsiTIDInvalid				= scsiErrorBase + 68,			/* -7868 = Target ID supplied is invalid 		*/
	scsiLUNInvalid				= scsiErrorBase + 69,			/* -7867 = LUN supplied is invalid  			*/
	scsiIDInvalid				= scsiErrorBase + 70,			/* -7866 = The initiator ID is invalid  		*/
	scsiDataTypeInvalid			= scsiErrorBase + 71,			/* -7865 = scsiDataType requested not supported */
	scsiTransferTypeInvalid		= scsiErrorBase + 72,			/* -7864 = scsiTransferType field is too high 	*/
	scsiCDBLengthInvalid		= scsiErrorBase + 73			/* -7863 = scsiCDBLength field is too big 		*/
};

enum {
	scsiExecutionErrors			= scsiErrorBase,
	scsiNotExecutedErrors		= scsiTooManyBuses,
	scsiParameterErrors			= scsiPBLengthError
};

/* Defines for the scsiResultFlags field */
enum {
	scsiSIMQFrozen				= 0x0001,						/* The SIM queue is frozen w/this err			*/
	scsiAutosenseValid			= 0x0002,						/* Autosense data valid for target  			*/
	scsiBusNotFree				= 0x0004						/* At time of callback, SCSI bus is not free	*/
};

/* Defines for the bit numbers of the scsiFlags field in the PB header for the SCSIExecIO function */
enum {
	kbSCSIDisableAutosense		= 29,							/* Disable auto sense feature 					*/
	kbSCSIFlagReservedA			= 28,							/*  											*/
	kbSCSIFlagReserved0			= 27,							/*  											*/
	kbSCSICDBLinked				= 26,							/* The PB contains a linked CDB					*/
	kbSCSIQEnable				= 25,							/* Target queue actions are enabled				*/
	kbSCSICDBIsPointer			= 24,							/* The CDB field contains a pointer				*/
	kbSCSIFlagReserved1			= 23,							/* 												*/
	kbSCSIInitiateSyncData		= 22,							/* Attempt Sync data xfer and SDTR				*/
	kbSCSIDisableSyncData		= 21,							/* Disable sync, go to async					*/
	kbSCSISIMQHead				= 20,							/* Place PB at the head of SIM Q				*/
	kbSCSISIMQFreeze			= 19,							/* Return the SIM Q to frozen state				*/
	kbSCSISIMQNoFreeze			= 18,							/* Disallow SIM Q freezing						*/
	kbSCSIDoDisconnect			= 17,							/* Definitely do disconnect						*/
	kbSCSIDontDisconnect		= 16,							/* Definitely don't disconnect					*/
	kbSCSIDataReadyForDMA		= 15,							/* Data buffer(s) are ready for DMA				*/
	kbSCSIFlagReserved3			= 14,							/* 												*/
	kbSCSIDataPhysical			= 13,							/* SG/Buffer data ptrs are physical				*/
	kbSCSISensePhysical			= 12,							/* Autosense buffer ptr is physical				*/
	kbSCSIFlagReserved5			= 11,							/* 												*/
	kbSCSIFlagReserved6			= 10,							/* 												*/
	kbSCSIFlagReserved7			= 9,							/* 												*/
	kbSCSIFlagReserved8			= 8,							/* 												*/
	kbSCSIDataBufferValid		= 7,							/* Data buffer valid							*/
	kbSCSIStatusBufferValid		= 6,							/* Status buffer valid 							*/
	kbSCSIMessageBufferValid	= 5,							/* Message buffer valid							*/
	kbSCSIFlagReserved9			= 4								/*  											*/
};

/* Defines for the bit masks of the scsiFlags field */
enum {
	scsiDirectionMask			= 0xC0000000,					/* Data direction mask						*/
	scsiDirectionNone			= 0xC0000000,					/* Data direction (11: no data)				*/
	scsiDirectionReserved		= 0x00000000,					/* Data direction (00: reserved)			*/
	scsiDirectionOut			= 0x80000000,					/* Data direction (10: DATA OUT)			*/
	scsiDirectionIn				= 0x40000000,					/* Data direction (01: DATA IN)				*/
	scsiDisableAutosense		= 0x20000000,					/* Disable auto sense feature				*/
	scsiFlagReservedA			= 0x10000000,					/* 											*/
	scsiFlagReserved0			= 0x08000000,					/* 											*/
	scsiCDBLinked				= 0x04000000,					/* The PB contains a linked CDB				*/
	scsiQEnable					= 0x02000000,					/* Target queue actions are enabled			*/
	scsiCDBIsPointer			= 0x01000000,					/* The CDB field contains a pointer			*/
	scsiFlagReserved1			= 0x00800000,					/* 											*/
	scsiInitiateSyncData		= 0x00400000,					/* Attempt Sync data xfer and SDTR			*/
	scsiDisableSyncData			= 0x00200000,					/* Disable sync, go to async				*/
	scsiSIMQHead				= 0x00100000,					/* Place PB at the head of SIM Q			*/
	scsiSIMQFreeze				= 0x00080000,					/* Return the SIM Q to frozen state			*/
	scsiSIMQNoFreeze			= 0x00040000,					/* Disallow SIM Q freezing					*/
	scsiDoDisconnect			= 0x00020000,					/* Definitely do disconnect					*/
	scsiDontDisconnect			= 0x00010000,					/* Definitely don't disconnect				*/
	scsiDataReadyForDMA			= 0x00008000,					/* Data buffer(s) are ready for DMA			*/
	scsiFlagReserved3			= 0x00004000,					/*  */
	scsiDataPhysical			= 0x00002000,					/* SG/Buffer data ptrs are physical			*/
	scsiSensePhysical			= 0x00001000,					/* Autosense buffer ptr is physical			*/
	scsiFlagReserved5			= 0x00000800,					/*  										*/
	scsiFlagReserved6			= 0x00000400,					/* 											*/
	scsiFlagReserved7			= 0x00000200,					/* 											*/
	scsiFlagReserved8			= 0x00000100					/* 											*/
};

/* bit masks for the scsiIOFlags field in SCSIExecIOPB */
enum {
	scsiNoParityCheck			= 0x0002,						/* disable parity checking 							*/
	scsiDisableSelectWAtn		= 0x0004,						/* disable select w/Atn  							*/
	scsiSavePtrOnDisconnect		= 0x0008,						/* do SaveDataPointer upon Disconnect msg 			*/
	scsiNoBucketIn				= 0x0010,						/* don’t bit bucket in during this I/O 				*/
	scsiNoBucketOut				= 0x0020,						/* don’t bit bucket out during this I/O 			*/
	scsiDisableWide				= 0x0040,						/* disable wide transfer negotiation 				*/
	scsiInitiateWide			= 0x0080,						/* initiate wide transfer negotiation 				*/
	scsiRenegotiateSense		= 0x0100,						/* renegotiate sync/wide before issuing autosense 	*/
	scsiDisableDiscipline		= 0x0200,						/* disable parameter checking on SCSIExecIO calls	*/
	scsiIOFlagReserved0080		= 0x0080,						/*  												*/
	scsiIOFlagReserved8000		= 0x8000						/* 													*/
};

/* Defines for the SIM/HBA queue actions.  These values are used in the */
/* SCSIExecIOPB, for the queue action field. [These values should match the */
/* defines from some other include file for the SCSI message phases.  We may */
/* not need these definitions here. ] */
enum {
	scsiSimpleQTag				= 0x20,							/* Tag for a simple queue 								*/
	scsiHeadQTag				= 0x21,							/* Tag for head of queue  								*/
	scsiOrderedQTag				= 0x22							/* Tag for ordered queue 								*/
};

/* Defines for the Bus Inquiry PB fields. */
/* scsiHBAInquiry field bits */
enum {
	scsiBusMDP					= 0x80,							/* Supports Modify Data Pointer message						*/
	scsiBusWide32				= 0x40,							/* Supports 32 bit wide SCSI								*/
	scsiBusWide16				= 0x20,							/* Supports 16 bit wide SCSI								*/
	scsiBusSDTR					= 0x10,							/* Supports Sync Data Transfer Req message					*/
	scsiBusLinkedCDB			= 0x08,							/* Supports linked CDBs										*/
	scsiBusTagQ					= 0x02,							/* Supports tag queue message								*/
	scsiBusSoftReset			= 0x01							/* Supports soft reset										*/
};

/* scsiDataTypes field bits  */
/*	bits 0->15 Apple-defined, 16->30 3rd-party unique, 31 = reserved */
enum {
	scsiBusDataTIB				= (1 << scsiDataTIB),			/* TIB supplied (ptr in scsiDataPtr)		*/
	scsiBusDataBuffer			= (1 << scsiDataBuffer),		/* single contiguous buffer supplied 		*/
	scsiBusDataSG				= (1 << scsiDataSG),			/* scatter/gather list supplied 			*/
	scsiBusDataReserved			= 0x80000000					/*   										*/
};

/* scsiScanFlags field bits */
enum {
	scsiBusScansDevices			= 0x80,							/* Bus scans for and maintains device list			*/
	scsiBusScansOnInit			= 0x40,							/* Bus scans performed at power-up/reboot			*/
	scsiBusLoadsROMDrivers		= 0x20							/* may load ROM drivers to support targets 			*/
};

/* scsiFeatureFlags field bits */
enum {
	scsiBusInternalExternalMask	= 0x000000C0,					/* bus internal/external mask					*/
	scsiBusInternalExternalUnknown = 0x00000000,				/* not known whether bus is inside or outside 	*/
	scsiBusInternalExternal		= 0x000000C0,					/* bus goes inside and outside the box 			*/
	scsiBusInternal				= 0x00000080,					/* bus goes inside the box 						*/
	scsiBusExternal				= 0x00000040,					/* bus goes outside the box 					*/
	scsiBusCacheCoherentDMA		= 0x00000020,					/* DMA is cache coherent 						*/
	scsiBusOldCallCapable		= 0x00000010,					/* SIM is old call capable 						*/
	scsiBusDifferential			= 0x00000004,					/* Single Ended (0) or Differential (1) 		*/
	scsiBusFastSCSI				= 0x00000002,					/* HBA supports fast SCSI 						*/
	scsiBusDMAavailable			= 0x00000001					/* DMA is available 							*/
};

/* scsiWeirdStuff field bits */
enum {
	scsiOddDisconnectUnsafeRead1 = 0x0001,						/* Disconnects on odd byte boundries are unsafe with DMA and/or blind reads */
	scsiOddDisconnectUnsafeWrite1 = 0x0002,						/* Disconnects on odd byte boundries are unsafe with DMA and/or blind writes */
	scsiBusErrorsUnsafe			= 0x0004,						/* Non-handshaked delays or disconnects during blind transfers may cause a crash */
	scsiRequiresHandshake		= 0x0008,						/* Non-handshaked delays or disconnects during blind transfers may cause data corruption */
	scsiTargetDrivenSDTRSafe	= 0x0010,						/* Targets which initiate synchronous negotiations are supported */
	scsiOddCountForPhysicalUnsafe = 0x0020						/* If using physical addrs all counts must be even, and disconnects must be on even boundries */
};

/* scsiHBAslotType values */
enum {
	scsiMotherboardBus			= 0x00,							/* A built in Apple supplied bus 					*/
	scsiNuBus					= 0x01,							/* A SIM on a NuBus card 							*/
	scsiPDSBus					= 0x03,							/*    "  on a PDS card								*/
	scsiPCIBus					= 0x04,							/*    "  on a PCI bus card							*/
	scsiPCMCIABus				= 0x05,							/*    "  on a PCMCIA card							*/
	scsiFireWireBridgeBus		= 0x06							/*    "  connected through a FireWire bridge		*/
};

/* Defines for the scsiDriverFlags field (in SCSIDriverPB) */
enum {
	scsiDeviceSensitive			= 0x0001,						/* Only driver should access this device				*/
	scsiDeviceNoOldCallAccess	= 0x0002						/* no old call access to this device 					*/
};

/*  SIMInitInfo PB */
/* directions are for SCSIRegisterBus call ( -> parm, <- result) 			*/
struct SIMInitInfo {
	UInt8							*SIMstaticPtr;				/* <- alloc. ptr to the SIM's static vars 				*/
	long							staticSize;					/* -> num bytes SIM needs for static vars 				*/
	SIMInitUPP						SIMInit;					/* -> pointer to the SIM init routine 					*/
	SIMActionUPP					SIMAction;					/* -> pointer to the SIM action routine 				*/
	SCSIInterruptUPP				SIM_ISR;					/* 	  reserved 											*/
	SCSIInterruptUPP				SIMInterruptPoll;			/* -> pointer to the SIM interrupt poll routine			*/
	SIMActionUPP					NewOldCall;					/* -> pointer to the SIM NewOldCall routine				*/
	UInt16							ioPBSize;					/* -> size of SCSI_IO_PBs required for this SIM			*/
	Boolean							oldCallCapable;				/* -> true if this SIM can handle old-API calls			*/
	UInt8							simInfoUnused1;				/* 	  reserved											*/
	long							simInternalUse;				/* xx not affected or viewed by XPT						*/
	SCSIUPP							XPT_ISR;					/*    reserved											*/
	SCSIUPP							EnteringSIM;				/* <- ptr to the EnteringSIM routine					*/
	SCSIUPP							ExitingSIM;					/* <- ptr to the ExitingSIM routine						*/
	SCSIMakeCallbackUPP				MakeCallback;				/* <- the XPT layer’s SCSIMakeCallback routine	        */
	UInt16							busID;						/* <- bus number for the registered bus					*/
	UInt8							simSlotNumber;				/* <- Magic cookie to place in scsiHBASlotNumber (PCI)	*/
	UInt8							simSRsrcID;					/* <- Magic cookie to place in scsiSIMsRsrcID	 (PCI)	*/
	Ptr								simRegEntry;				/* -> The SIM's RegEntryIDPtr					 (PCI)	*/
};
typedef struct SIMInitInfo SIMInitInfo;

/* Glue between SCSI calls and SCSITrap format */

enum {
	xptSCSIAction				= 0x0001,
	xptSCSIRegisterBus			= 0x0002,
	xptSCSIDeregisterBus		= 0x0003,
	xptSCSIReregisterBus		= 0x0004,
	xptSCSIKillXPT				= 0x0005,						/* kills Mini-XPT after transition */
	xptSCSIInitialize			= 0x000A						/* Initialize the SCSI manager */
};

/* SCSI status*/
enum {
	scsiStatGood				= 0x00,							/* Good Status*/
	scsiStatCheckCondition		= 0x02,							/* Check Condition*/
	scsiStatConditionMet		= 0x04,							/* Condition Met*/
	scsiStatBusy				= 0x08,							/* Busy*/
	scsiStatIntermediate		= 0x10,							/* Intermediate*/
	scsiStatIntermedMet			= 0x14,							/* Intermediate - Condition Met*/
	scsiStatResvConflict		= 0x18,							/* Reservation conflict*/
	scsiStatTerminated			= 0x22,							/* Command terminated*/
	scsiStatQFull				= 0x28							/* Queue full*/
};

/* SCSI messages*/
enum {
	kCmdCompleteMsg				= 0,
	kExtendedMsg,												/* 0x01*/
	kSaveDataPointerMsg,										/* 0x02*/
	kRestorePointersMsg,										/* 0x03*/
	kDisconnectMsg,												/* 0x04*/
	kInitiatorDetectedErrorMsg,									/* 0x05*/
	kAbortMsg,													/* 0x06*/
	kMsgRejectMsg,												/* 0x07*/
	kNoOperationMsg,											/* 0x08*/
	kMsgParityErrorMsg,											/* 0x09*/
	kLinkedCmdCompleteMsg,										/* 0x0a*/
	kLinkedCmdCompleteWithFlagMsg,								/* 0x0b*/
	kBusDeviceResetMsg,											/* 0x0c*/
	kAbortTagMsg,												/* 0x0d*/
	kClearQueueMsg,												/* 0x0e*/
	kInitiateRecoveryMsg,										/* 0x0f*/
	kReleaseRecoveryMsg,										/* 0x10*/
	kTerminateIOProcessMsg,										/* 0x11*/
	kSimpleQueueTag				= 0x20,							/* 0x20*/
	kHeadOfQueueTagMsg,											/* 0x21*/
	kOrderedQueueTagMsg,										/* 0x22*/
	kIgnoreWideResidueMsg										/* 0x23*/
};

/* moveq #kSCSIx, D0;  _SCSIAtomic */

#if !GENERATINGCFM
#pragma parameter __D0 SCSIAction(__A0)
#endif
extern pascal OSErr SCSIAction(SCSI_PB *parameterBlock)
 TWOWORDINLINE(0x7001, 0xA089);

#if !GENERATINGCFM
#pragma parameter __D0 SCSIRegisterBus(__A0)
#endif
extern pascal OSErr SCSIRegisterBus(SIMInitInfo *parameterBlock)
 TWOWORDINLINE(0x7002, 0xA089);

#if !GENERATINGCFM
#pragma parameter __D0 SCSIDeregisterBus(__A0)
#endif
extern pascal OSErr SCSIDeregisterBus(SCSI_PB *parameterBlock)
 TWOWORDINLINE(0x7003, 0xA089);

#if !GENERATINGCFM
#pragma parameter __D0 SCSIReregisterBus(__A0)
#endif
extern pascal OSErr SCSIReregisterBus(SIMInitInfo *parameterBlock)
 TWOWORDINLINE(0x7004, 0xA089);

#if !GENERATINGCFM
#pragma parameter __D0 SCSIKillXPT(__A0)
#endif
extern pascal OSErr SCSIKillXPT(SIMInitInfo *parameterBlock)
 TWOWORDINLINE(0x7005, 0xA089);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SCSI__ */

/*
 	File:		FSM.h
 
 	Contains:	HFS External File System Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __FSM__
#define __FSM__


#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/
/*	#include <Finder.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if OLDROUTINELOCATIONS

enum {
	volMountInteractBit			= 15,							/* Input to VolumeMount: If set, it's OK for the file system */
	volMountInteractMask		= 0x8000,						/* to perform user interaction to mount the volume */
	volMountChangedBit			= 14,							/* Output from VoumeMount: If set, the volume was mounted, but */
	volMountChangedMask			= 0x4000,						/* the volume mounting information record needs to be updated. */
	volMountFSReservedMask		= 0x00ff,						/* bits 0-7 are defined by each file system for its own use */
	volMountSysReservedMask		= 0xff00						/* bits 8-15 are reserved for Apple system use */
};

/*
 * additional volume mount info record
 */
struct VolumeMountInfoHeader {
	short							length;						/* length of location data (including self) */
	VolumeType						media;						/* type of media (must be registered with Apple) */
	short							flags;						/* volume mount flags. Variable length data follows */
};
typedef struct VolumeMountInfoHeader VolumeMountInfoHeader;

typedef VolumeMountInfoHeader *VolumeMountInfoHeaderPtr;


enum {
	gestaltFSMVersion			= 'fsm '
};

typedef VCB *VCBPtr;

#endif

enum {
	fsUsrCNID					= 16,							/* First assignable directory or file number */
/*	File system trap word attribute bits */
	kHFSBit						= 9,							/* HFS call: bit 9 */
	kHFSMask					= 0x0200,
	kAsyncBit					= 10,							/* Asynchronous call: bit 10 */
	kAsyncMask					= 0x0400
};

/*
 * HFSCIProc selectCode values
 * Note: The trap attribute bits (the HFS bit and the asynchronous bit)
 * may be set in these selectCode values.
 */
enum {
	kFSMOpen					= 0xA000,
	kFSMClose					= 0xA001,
	kFSMRead					= 0xA002,
	kFSMWrite					= 0xA003,
	kFSMGetVolInfo				= 0xA007,
	kFSMCreate					= 0xA008,
	kFSMDelete					= 0xA009,
	kFSMOpenRF					= 0xA00A,
	kFSMRename					= 0xA00B,
	kFSMGetFileInfo				= 0xA00C,
	kFSMSetFileInfo				= 0xA00D,
	kFSMUnmountVol				= 0xA00E,
	kFSMMountVol				= 0xA00F,
	kFSMAllocate				= 0xA010,
	kFSMGetEOF					= 0xA011,
	kFSMSetEOF					= 0xA012,
	kFSMFlushVol				= 0xA013,
	kFSMGetVol					= 0xA014,
	kFSMSetVol					= 0xA015,
	kFSMEject					= 0xA017,
	kFSMGetFPos					= 0xA018,
	kFSMOffline					= 0xA035,
	kFSMSetFilLock				= 0xA041,
	kFSMRstFilLock				= 0xA042,
	kFSMSetFilType				= 0xA043,
	kFSMSetFPos					= 0xA044,
	kFSMFlushFile				= 0xA045,
/*	The File System HFSDispatch selectCodes */
	kFSMOpenWD					= 0x0001,
	kFSMCloseWD					= 0x0002,
	kFSMCatMove					= 0x0005,
	kFSMDirCreate				= 0x0006,
	kFSMGetWDInfo				= 0x0007,
	kFSMGetFCBInfo				= 0x0008,
	kFSMGetCatInfo				= 0x0009,
	kFSMSetCatInfo				= 0x000A,
	kFSMSetVolInfo				= 0x000B,
	kFSMLockRng					= 0x0010,
	kFSMUnlockRng				= 0x0011,
	kFSMCreateFileIDRef			= 0x0014,
	kFSMDeleteFileIDRef			= 0x0015,
	kFSMResolveFileIDRef		= 0x0016,
	kFSMExchangeFiles			= 0x0017,
	kFSMCatSearch				= 0x0018,
	kFSMOpenDF					= 0x001A,
	kFSMMakeFSSpec				= 0x001B,
/*	The Desktop Manager HFSDispatch selectCodes */
	kFSMDTGetPath				= 0x0020,
	kFSMDTCloseDown				= 0x0021,
	kFSMDTAddIcon				= 0x0022,
	kFSMDTGetIcon				= 0x0023,
	kFSMDTGetIconInfo			= 0x0024,
	kFSMDTAddAPPL				= 0x0025,
	kFSMDTRemoveAPPL			= 0x0026,
	kFSMDTGetAPPL				= 0x0027,
	kFSMDTSetComment			= 0x0028,
	kFSMDTRemoveComment			= 0x0029,
	kFSMDTGetComment			= 0x002A,
	kFSMDTFlush					= 0x002B,
	kFSMDTReset					= 0x002C,
	kFSMDTGetInfo				= 0x002D,
	kFSMDTOpenInform			= 0x002E,
	kFSMDTDelete				= 0x002F,
/*	The AppleShare HFSDispatch selectCodes */
	kFSMGetVolParms				= 0x0030,
	kFSMGetLogInInfo			= 0x0031,
	kFSMGetDirAccess			= 0x0032,
	kFSMSetDirAccess			= 0x0033,
	kFSMMapID					= 0x0034,
	kFSMMapName					= 0x0035,
	kFSMCopyFile				= 0x0036,
	kFSMMoveRename				= 0x0037,
	kFSMOpenDeny				= 0x0038,
	kFSMOpenRFDeny				= 0x0039,
	kFSMGetXCatInfo				= 0x003A,
	kFSMGetVolMountInfoSize		= 0x003F,
	kFSMGetVolMountInfo			= 0x0040,
	kFSMVolumeMount				= 0x0041,
	kFSMShare					= 0x0042,
	kFSMUnShare					= 0x0043,
	kFSMGetUGEntry				= 0x0044,
	kFSMGetForeignPrivs			= 0x0060,
	kFSMSetForeignPrivs			= 0x0061
};

/*
 * UTDetermineVol status values
 */
enum {
	dtmvError					= 0,							/* param error */
	dtmvFullPathame				= 1,							/* determined by full pathname */
	dtmvVRefNum					= 2,							/* determined by volume refNum */
	dtmvWDRefNum				= 3,							/* determined by working directory refNum */
	dtmvDriveNum				= 4,							/* determined by drive number */
	dtmvDefault					= 5								/* determined by default volume */
};

/*
 * UTGetBlock options
 */
enum {
	gbDefault					= 0,							/* default value - read if not found */
/*	bits and masks */
	gbReadBit					= 0,							/* read block from disk (forced read) */
	gbReadMask					= 0x0001,
	gbExistBit					= 1,							/* get existing cache block */
	gbExistMask					= 0x0002,
	gbNoReadBit					= 2,							/* don't read block from disk if not found in cache */
	gbNoReadMask				= 0x0004,
	gbReleaseBit				= 3,							/* release block immediately after GetBlock */
	gbReleaseMask				= 0x0008
};

/*
 * UTReleaseBlock options
 */
enum {
	rbDefault					= 0,							/* default value - just mark the buffer not in-use */
/*	bits and masks */
	rbWriteBit					= 0,							/* force write buffer to disk */
	rbWriteMask					= 0x0001,
	rbTrashBit					= 1,							/* trash buffer contents after release */
	rbTrashMask					= 0x0002,
	rbDirtyBit					= 2,							/* mark buffer dirty */
	rbDirtyMask					= 0x0004,
	rbFreeBit					= 3,							/* free the buffer (save in the hash) */
/*
 *	rbFreeMask (rbFreeBit + rbTrashBit) works as rbTrash on < System 7.0 RamCache;
 *	on >= System 7.0, rbfreeMask overrides rbTrash
 */
	rbFreeMask					= 0x000A
};

/*
 * UTFlushCache options
 */
enum {
	fcDefault					= 0,							/* default value - just flush any dirty buffers */
/*	bits and masks */
	fcTrashBit					= 1,							/* trash buffers after flushing */
	fcTrashMask					= 0x0002,
	fcFreeBit					= 3,							/* free buffers after flushing */
	fcFreeMask					= 0x0008						/* fcFreeMask works as fcTrash on < System 7.0 RamCache */
};

/*
 * UTCacheReadIP and UTCacheWriteIP cacheOption
 */
enum {
	noCacheBit					= 5,							/* don't cache this please */
	noCacheMask					= 0x0020,
	rdVerifyBit					= 6,							/* read verify */
	rdVerifyMask				= 0x0040
};

/*
 * Cache routine internal error codes
 */
enum {
	chNoBuf						= 1,							/* no free cache buffers (all in use) */
	chInUse						= 2,							/* requested block in use */
	chnotfound					= 3,							/* requested block not found */
	chNotInUse					= 4								/* block being released was not in use */
};

/*
 * FCBRec.fcbFlags bits
 */
enum {
	fcbWriteBit					= 0,							/* Data can be written to this file */
	fcbWriteMask				= 0x01,
	fcbResourceBit				= 1,							/* This file is a resource fork */
	fcbResourceMask				= 0x02,
	fcbWriteLockedBit			= 2,							/* File has a locked byte range */
	fcbWriteLockedMask			= 0x04,
	fcbSharedWriteBit			= 4,							/* File is open for shared write access */
	fcbSharedWriteMask			= 0x10,
	fcbFileLockedBit			= 5,							/* File is locked (write-protected) */
	fcbFileLockedMask			= 0x20,
	fcbOwnClumpBit				= 6,							/* File has clump size specified in FCB */
	fcbOwnClumpMask				= 0x40,
	fcbModifiedBit				= 7,							/* File has changed since it was last flushed */
	fcbModifiedMask				= 0x80
};

/*
 * ExtFileProc options
 */
enum {
	extendFileAllBit			= 0,							/* allocate all requested bytes or none */
	extendFileAllMask			= 0x0001,
	extendFileContigBit			= 1,							/* force contiguous allocation */
	extendFileContigMask		= 0x0002
};

/*
 *	HFS Component Interface constants
 */
/*
 * compInterfMask bits specific to HFS component
 */
enum {
	hfsCIDoesHFSBit				= 23,							/* set if file system supports HFS calls */
	hfsCIDoesHFSMask			= 0x00800000,
	hfsCIDoesAppleShareBit		= 22,							/* set if AppleShare calls supported */
	hfsCIDoesAppleShareMask		= 0x00400000,
	hfsCIDoesDeskTopBit			= 21,							/* set if Desktop Database calls supported */
	hfsCIDoesDeskTopMask		= 0x00200000,
	hfsCIDoesDynamicLoadBit		= 20,							/* set if dynamically loading code resource */
	hfsCIDoesDynamicLoadMask	= 0x00100000,					/*		supported */
	hfsCIResourceLoadedBit		= 19,							/* set if code resource already loaded */
	hfsCIResourceLoadedMask		= 0x00080000,
	hfsCIHasHLL2PProcBit		= 18,							/* set if FFS' log2PhyProc and Extendfile proc */
	hfsCIHasHLL2PProcMask		= 0x00040000					/* is written in a high level language. (i.e., uses Pascal calling convention) */
};

/*
 *	Disk Initialization Component Interface constants
 */
/*
 * compInterfMask bits specific to Disk Initialization component
 */
enum {
	diCIHasExtFormatParamsBit	= 18,							/* set if file system needs extended format */
	diCIHasExtFormatParamsMask	= 0x00040000,					/*		parameters */
	diCIHasMultiVolTypesBit		= 17,							/* set if file system supports more than one */
	diCIHasMultiVolTypesMask	= 0x00020000,					/*		volume type */
	diCIDoesSparingBit			= 16,							/* set if file system supports disk sparing */
	diCIDoesSparingMask			= 0x00010000,
	diCILiveBit					= 0,							/* set if file system is candidate for current */
	diCILiveMask				= 0x00000001					/*		formatting operation (set by PACK2) */
};

/*
 * Disk Initialization Component Function selectors
 */
enum {
	diCILoad					= 1,							/* Make initialization code memory resident */
	diCIUnload					= 2,							/* Make initialization code purgeable */
	diCIEvaluateSizeChoices		= 3,							/* Evaluate size choices */
	diCIExtendedZero			= 4,							/* Write an empty volume directory */
	diCIValidateVolName			= 5,							/* Validate volume name */
	diCIGetVolTypeInfo			= 6,							/* get volume type info */
	diCIGetFormatString			= 7,							/* get dialog format string */
	diCIGetExtFormatParams		= 8,							/* get extended format parameters */
	diCIGetDefectList			= 9								/* return the defect list for the indicated disk - reserved for future use */
};

/*
 * Constants used in the DICIEvaluateSizeRec and FormatListRec
 */
enum {
	diCIFmtListMax				= 8,							/* maximum number of format list entries in DICIEvaluateSizeRec.numSizeEntries */
/*	bits in FormatListRec.formatFlags: */
	diCIFmtFlagsValidBit		= 7,							/* set if sec, side, tracks valid */
	diCIFmtFlagsValidMask		= 0x80,
	diCIFmtFlagsCurrentBit		= 6,							/* set if current disk has this fmt */
	diCIFmtFlagsCurrentMask		= 0x40,
/*	bits in FormatListRec.sizeListFlags: */
	diCISizeListOKBit			= 15,							/* set if this disk size usable */
	diCISizeListOKMask			= 0x8000
};

/*
 * DICIGetFormatStringRec.stringKind format strings
 */
enum {
	diCIAlternateFormatStr		= 1,							/* get alternate format  string (Balloon Help) */
	diCISizePresentationStr		= 2								/* get size presentation string (for dialog) */
};

/*
 * Error codes returned by Disk Sparing
 */
enum {
	diCIUserCancelErr			= 1,							/* user cancelled the disk init */
	diCICriticalSectorBadErr	= 20,							/* critical sectors are bad (hopeless)	*/
	diCISparingFailedErr		= 21,							/* disk cannot be spared */
	diCITooManyBadSectorsErr	= 22,							/* too many bad sectors */
	diCIUnknownVolTypeErr		= 23,							/* the volume type passed in diCIExtendedZero paramBlock is not supported */
	diCIVolSizeMismatchErr		= 24,							/* specified volume size doesn’t match with formatted disk size */
	diCIUnknownDICallErr		= 25,							/* bogus DI function call selector */
	diCINoSparingErr			= 26,							/* disk is bad but the target FS doesn't do disk sparing */
	diCINoExtendInfoErr			= 27,							/* missing file system specific extra parameter in diCIExtendedZero call */
	diCINoMessageTextErr		= 28							/* missing message text in DIReformat call */
};

/*
 *	File System Manager constants
 */
/*
 * Miscellaneous constants used by FSM
 */
enum {
	fsdVersion1					= 1,							/* current version of FSD record */
	fsmIgnoreFSID				= 0xfffe,						/* this FSID should be ignored by the driver */
	fsmGenericFSID				= 0xffff						/* unknown foreign file system ID */
};

/*
 * compInterfMask bits common to all FSM components
 */
enum {
	fsmComponentEnableBit		= 31,							/* set if FSM component interface is enabled */
	fsmComponentEnableMask		= 0x80000000,
	fsmComponentBusyBit			= 30,							/* set if FSM component interface is busy */
	fsmComponentBusyMask		= 0x40000000
};

/*
 * Selectors for GetFSInfo
 */
enum {
	fsmGetFSInfoByIndex			= -1,							/* get fs info by index */
	fsmGetFSInfoByFSID			= 0,							/* get fs info by FSID */
	fsmGetFSInfoByRefNum		= 1								/* get fs info by file/vol refnum */
};

/*
 * InformFSM messages
 */
enum {
	fsmNopMessage				= 0,							/* nop */
	fsmDrvQElChangedMessage		= 1,							/* DQE has changed */
	fsmGetFSIconMessage			= 2								/* Get FFS's disk icon */
};

/*
 * Messages passed to the fileSystemCommProc
 */
enum {
	ffsNopMessage				= 0,							/* nop, should always return noErr */
	ffsGetIconMessage			= 1,							/* return disk icon and mask */
	ffsIDDiskMessage			= 2,							/* identify the about-to-be-mounted volume */
	ffsLoadMessage				= 3,							/* load in the FFS */
	ffsUnloadMessage			= 4,							/* unload the FFS */
	ffsIDVolMountMessage		= 5,							/* identify a VolMountInfo record */
	ffsInformMessage			= 6,							/* FFS defined message */
	ffsGetIconInfoMessage		= 7
};

/*
 * Error codes from FSM functions
 */
enum {
	fsmFFSNotFoundErr			= -431,							/* Foreign File system does not exist - new Pack2 could return this error too */
	fsmBusyFFSErr				= -432,							/* File system is busy, cannot be removed */
	fsmBadFFSNameErr			= -433,							/* Name length not 1 <= length <= 31 */
	fsmBadFSDLenErr				= -434,							/* FSD size incompatible with current FSM vers */
	fsmDuplicateFSIDErr			= -435,							/* FSID already exists on InstallFS */
	fsmBadFSDVersionErr			= -436,							/* FSM version incompatible with FSD */
	fsmNoAlternateStackErr		= -437,							/* no alternate stack for HFS CI */
	fsmUnknownFSMMessageErr		= -438							/* unknown message passed to FSM */
};

/*
 *	HFS Utility routine records
 */
/*
 * record used by UTGetPathComponentName
 */
struct ParsePathRec {
	StringPtr						namePtr;					/* pathname to parse */
	short							startOffset;				/* where to start parsing */
	short							componentLength;			/* the length of the pathname component parsed */
	SignedByte						moreName;					/* non-zero if there are more components after this one */
	SignedByte						foundDelimiter;				/* non-zero if parsing stopped because a colon (:) delimiter was found */
};
typedef struct ParsePathRec ParsePathRec;

typedef ParsePathRec *ParsePathRecPtr;

struct WDCBRec {
	VCBPtr							wdVCBPtr;					/* Pointer to VCB of this working directory */
	long							wdDirID;					/* Directory ID number of this working directory */
	long							wdCatHint;					/* Hint for finding this working directory */
	long							wdProcID;					/* Process that created this working directory */
};
typedef struct WDCBRec WDCBRec;

typedef WDCBRec *WDCBRecPtr;

struct FCBRec {
	unsigned long					fcbFlNm;					/* FCB file number. Non-zero marks FCB used */
	SignedByte						fcbFlags;					/* FCB flags */
	SignedByte						fcbTypByt;					/* File type byte */
	unsigned short					fcbSBlk;					/* File start block (in alloc size blks) */
	unsigned long					fcbEOF;						/* Logical length or EOF in bytes */
	unsigned long					fcbPLen;					/* Physical file length in bytes */
	unsigned long					fcbCrPs;					/* Current position within file */
	VCBPtr							fcbVPtr;					/* Pointer to the corresponding VCB */
	Ptr								fcbBfAdr;					/* File's buffer address */
	unsigned short					fcbFlPos;					/* Directory block this file is in */
/* FCB Extensions for HFS */
	unsigned long					fcbClmpSize;				/* Number of bytes per clump */
	Ptr								fcbBTCBPtr;					/* Pointer to B*-Tree control block for file */
	unsigned long					fcbExtRec[3];				/* First 3 file extents */
	OSType							fcbFType;					/* File's 4 Finder Type bytes */
	unsigned long					fcbCatPos;					/* Catalog hint for use on Close */
	unsigned long					fcbDirID;					/* Parent Directory ID */
	Str31							fcbCName;					/* CName of open file */
};
typedef struct FCBRec FCBRec;

typedef FCBRec *FCBRecPtr;

/*
 *	HFS Component Interface records
 */
typedef pascal OSErr (*Lg2PhysProcPtr)(void *fsdGlobalPtr, VCBPtr volCtrlBlockPtr, FCBRecPtr fileCtrlBlockPtr, short fileRefNum, unsigned long filePosition, unsigned long reqCount, unsigned long *volOffset, unsigned long *contiguousBytes);

#if GENERATINGCFM
typedef UniversalProcPtr Lg2PhysUPP;
#else
typedef Lg2PhysProcPtr Lg2PhysUPP;
#endif

enum {
	uppLg2PhysProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(VCBPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(FCBRecPtr)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(unsigned long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(unsigned long)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(unsigned long*)))
		 | STACK_ROUTINE_PARAMETER(8, SIZE_CODE(sizeof(unsigned long*)))
};

#if GENERATINGCFM
#define NewLg2PhysProc(userRoutine)		\
		(Lg2PhysUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppLg2PhysProcInfo, GetCurrentArchitecture())
#else
#define NewLg2PhysProc(userRoutine)		\
		((Lg2PhysUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallLg2PhysProc(userRoutine, fsdGlobalPtr, volCtrlBlockPtr, fileCtrlBlockPtr, fileRefNum, filePosition, reqCount, volOffset, contiguousBytes)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppLg2PhysProcInfo, (fsdGlobalPtr), (volCtrlBlockPtr), (fileCtrlBlockPtr), (fileRefNum), (filePosition), (reqCount), (volOffset), (contiguousBytes))
#else
#define CallLg2PhysProc(userRoutine, fsdGlobalPtr, volCtrlBlockPtr, fileCtrlBlockPtr, fileRefNum, filePosition, reqCount, volOffset, contiguousBytes)		\
		(*(userRoutine))((fsdGlobalPtr), (volCtrlBlockPtr), (fileCtrlBlockPtr), (fileRefNum), (filePosition), (reqCount), (volOffset), (contiguousBytes))
#endif

typedef pascal OSErr (*HFSCIProcPtr)(VCBPtr theVCB, short selectCode, void *paramBlock, void *fsdGlobalPtr, short fsid);

#if GENERATINGCFM
typedef UniversalProcPtr HFSCIUPP;
#else
typedef HFSCIProcPtr HFSCIUPP;
#endif

enum {
	uppHFSCIProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(VCBPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewHFSCIProc(userRoutine)		\
		(HFSCIUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppHFSCIProcInfo, GetCurrentArchitecture())
#else
#define NewHFSCIProc(userRoutine)		\
		((HFSCIUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallHFSCIProc(userRoutine, theVCB, selectCode, paramBlock, fsdGlobalPtr, fsid)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppHFSCIProcInfo, (theVCB), (selectCode), (paramBlock), (fsdGlobalPtr), (fsid))
#else
#define CallHFSCIProc(userRoutine, theVCB, selectCode, paramBlock, fsdGlobalPtr, fsid)		\
		(*(userRoutine))((theVCB), (selectCode), (paramBlock), (fsdGlobalPtr), (fsid))
#endif

struct HFSCIRec {
	long							compInterfMask;				/* component flags */
	HFSCIUPP						compInterfProc;				/* pointer to file system call processing code */
	Lg2PhysUPP						log2PhyProc;				/* pointer to Lg2PhysProc() code */
	Ptr								stackTop;					/* file system stack top */
	long							stackSize;					/* file system stack size */
	Ptr								stackPtr;					/* current file system stack pointer */
	long							reserved3;					/* --reserved, must be zero-- */
	long							idSector;					/* Sector you need to ID a local volume. For networked volumes, this must be -1 */
	long							reserved2;					/* --reserved, must be zero-- */
	long							reserved1;					/* --reserved, must be zero-- */
};
typedef struct HFSCIRec HFSCIRec;

typedef HFSCIRec *HFSCIRecPtr;

/*
 *	Disk Initialization Component Interface records
 */
typedef pascal OSErr (*DICIProcPtr)(short whatFunction, void *paramBlock, void *fsdGlobalPtr);

#if GENERATINGCFM
typedef UniversalProcPtr DICIUPP;
#else
typedef DICIProcPtr DICIUPP;
#endif

enum {
	uppDICIProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewDICIProc(userRoutine)		\
		(DICIUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDICIProcInfo, GetCurrentArchitecture())
#else
#define NewDICIProc(userRoutine)		\
		((DICIUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDICIProc(userRoutine, whatFunction, paramBlock, fsdGlobalPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDICIProcInfo, (whatFunction), (paramBlock), (fsdGlobalPtr))
#else
#define CallDICIProc(userRoutine, whatFunction, paramBlock, fsdGlobalPtr)		\
		(*(userRoutine))((whatFunction), (paramBlock), (fsdGlobalPtr))
#endif

struct DICIRec {
	long							compInterfMask;				/* component flags */
	DICIUPP							compInterfProc;				/* pointer to call processing code */
	short							maxVolNameLength;			/* maximum length of your volume name */
	unsigned short					blockSize;					/* your file system's block size */
	long							reserved3;					/* --reserved, must be zero-- */
	long							reserved2;					/* --reserved, must be zero-- */
	long							reserved1;					/* --reserved, must be zero-- */
};
typedef struct DICIRec DICIRec;

typedef DICIRec *DICIRecPtr;

/*
 * FormatListRec as returned by the .Sony disk driver's
 * Return Format List status call (csCode = 6).
 * If the status call to get this list for a drive is not
 * implemented by the driver, then a list with one entry
 * is contructed from the drive queue element for the drive.
 */
struct FormatListRec {
	unsigned long					volSize;					/* disk capacity in SECTORs */
	SignedByte						formatFlags;				/* flags */
	SignedByte						sectorsPerTrack;			/* sectors per track side */
	unsigned short					tracks;						/* number of tracks */
};
typedef struct FormatListRec FormatListRec;

typedef FormatListRec *FormatListRecPtr;

/*
 * SizeListRec built from FormatListRecs as described above.
 */
struct SizeListRec {
	short							sizeListFlags;				/* flags as set by external file system */
	FormatListRec					sizeEntry;					/* disk driver format list record */
};
typedef struct SizeListRec SizeListRec;

typedef SizeListRec *SizeListRecPtr;

/*
 * paramBlock for the diCIEvaluateSize call
 */
struct DICIEvaluateSizeRec {
	short							defaultSizeIndex;			/* default size for this FS */
	short							numSizeEntries;				/* number of size entries */
	short							driveNumber;				/* drive number */
	SizeListRecPtr					sizeListPtr;				/* ptr to size entry table */
	unsigned short					sectorSize;					/* bytes per sector */
};
typedef struct DICIEvaluateSizeRec DICIEvaluateSizeRec;

typedef DICIEvaluateSizeRec *DICIEvaluateSizeRecPtr;

/*
 * paramBlock for the diCIExtendedZero call
 */
struct DICIExtendedZeroRec {
	short							driveNumber;				/* drive number */
	StringPtr						volNamePtr;					/* ptr to volume name string */
	short							fsid;						/* file system ID */
	short							volTypeSelector;			/* volume type selector, if supports more than 1 type */
	unsigned short					numDefectBlocks;			/* number of bad logical blocks */
	unsigned short					defectListSize;				/* size of the defect list buffer in bytes */
	Ptr								defectListPtr;				/* pointer to defect list buffer */
	unsigned long					volSize;					/* size of volume in SECTORs */
	unsigned short					sectorSize;					/* bytes per sector */
	Ptr								extendedInfoPtr;			/* ptr to extended info */
};
typedef struct DICIExtendedZeroRec DICIExtendedZeroRec;

typedef DICIExtendedZeroRec *DICIExtendedZeroRecPtr;

/*
 * paramBlock for the diCIValidateVolName call
 */
struct DICIValidateVolNameRec {
	char							theChar;					/* the character to validate */
	Boolean							hasMessageBuffer;			/* false if no message */
	short							charOffset;					/* position of the current character (first char = 1) */
	StringPtr						messageBufferPtr;			/* pointer to message buffer or nil */
	short							charByteType;				/* theChar's byte type (smSingleByte, smFirstByte, or smLastByte) */
};
typedef struct DICIValidateVolNameRec DICIValidateVolNameRec;

typedef DICIValidateVolNameRec *DICIValidateVolNameRecPtr;

/*
 * paramBlock for the diCIGetVolTypeInfo call
 */
struct DICIGetVolTypeInfoRec {
	unsigned long					volSize;					/* size of volume in SECTORs */
	unsigned short					sectorSize;					/* bytes per sector */
	short							numVolTypes;				/* number of volume types supported */
	Str31							volTypesBuffer[4];			/* 4 string buffers */
};
typedef struct DICIGetVolTypeInfoRec DICIGetVolTypeInfoRec;

typedef DICIGetVolTypeInfoRec *DICIGetVolTypeInfoRecPtr;

/*
 * paramBlock for the diCIGetFormatString call
 */
struct DICIGetFormatStringRec {
	unsigned long					volSize;					/* volume size in SECTORs */
	unsigned short					sectorSize;					/* sector size */
	short							volTypeSelector;			/* volume type selector */
	short							stringKind;					/* sub-function = type of string */
	Str255							stringBuffer;				/* string buffer */
};
typedef struct DICIGetFormatStringRec DICIGetFormatStringRec;

typedef DICIGetFormatStringRec *DICIGetFormatStringRecPtr;

/*
 * paramBlock for the diCIGetExtendedFormatParams call
 */
struct DICIGetExtendedFormatRec {
	short							driveNumber;				/* drive number */
	short							volTypeSelector;			/* volume type selector or 0 */
	unsigned long					volSize;					/* size of volume in SECTORs */
	unsigned short					sectorSize;					/* bytes per sector */
	FSSpecPtr						fileSystemSpecPtr;			/* pointer to the foreign file system's FSSpec */
	Ptr								extendedInfoPtr;			/* pointer to extended parameter structure */
};
typedef struct DICIGetExtendedFormatRec DICIGetExtendedFormatRec;

typedef DICIGetExtendedFormatRec *DICIGetExtendedFormatRecPtr;

/*
 *	File System Manager records
 */
typedef pascal OSErr (*FSDCommProcPtr)(short message, void *paramBlock, void *globalsPtr);

#if GENERATINGCFM
typedef UniversalProcPtr FSDCommUPP;
#else
typedef FSDCommProcPtr FSDCommUPP;
#endif

enum {
	uppFSDCommProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewFSDCommProc(userRoutine)		\
		(FSDCommUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFSDCommProcInfo, GetCurrentArchitecture())
#else
#define NewFSDCommProc(userRoutine)		\
		((FSDCommUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallFSDCommProc(userRoutine, message, paramBlock, globalsPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFSDCommProcInfo, (message), (paramBlock), (globalsPtr))
#else
#define CallFSDCommProc(userRoutine, message, paramBlock, globalsPtr)		\
		(*(userRoutine))((message), (paramBlock), (globalsPtr))
#endif

struct FSDRec {
	struct FSDRec					*fsdLink;					/* ptr to next */
	short							fsdLength;					/* length of this FSD in BYTES */
	short							fsdVersion;					/* version number */
	short							fileSystemFSID;				/* file system id */
	Str31							fileSystemName;				/* file system name */
	FSSpec							fileSystemSpec;				/* foreign file system's FSSpec */
	Ptr								fileSystemGlobalsPtr;		/* ptr to file system globals */
	FSDCommUPP						fileSystemCommProc;			/* communication proc with the FFS */
	long							reserved3;					/* --reserved, must be zero-- */
	long							reserved2;					/* --reserved, must be zero-- */
	long							reserved1;					/* --reserved, must be zero-- */
	HFSCIRec						fsdHFSCI;					/* HFS component interface    */
	DICIRec							fsdDICI;					/* Disk Initialization component interface */
};
typedef struct FSDRec FSDRec;

typedef FSDRec *FSDRecPtr;

struct FSMGetIconInfoRec {
	long							theIcon[32];				/* The ICN# structure */
	long							theMask[32];				/* The mask for the icon above */
	Str255							whereStr;
};
typedef struct FSMGetIconInfoRec FSMGetIconInfoRec;

typedef FSMGetIconInfoRec *FSMGetIconInfoRecPtr;

/*
 * paramBlock for ffsGetIconMessage and fsmGetFSIconMessage
 */
struct FSMGetIconRec {
	short							refNum;						/* target drive num or volume refnum */
	FSMGetIconInfoRecPtr			iconBufferPtr;				/* pointer to icon buffer */
	long							requestSize;				/* requested size of the icon buffer */
	long							actualSize;					/* actual size of the icon data returned */
	SInt8							iconType;					/* kind of icon */
	Boolean							isEjectable;				/* true if the device is ejectable */
	DrvQElPtr						driveQElemPtr;				/* pointer to DQE */
	FSSpecPtr						fileSystemSpecPtr;			/* pointer to foreign file system's FSSpec */
	long							reserved1;					/* --reserved, must be zero-- */
};
typedef struct FSMGetIconRec FSMGetIconRec;

typedef FSMGetIconRec *FSMGetIconRecPtr;

/*
 *	HFS Utility routine prototypes
 */
extern pascal OSErr UTAllocateFCB(short *fileRefNum, FCBRecPtr *fileCtrlBlockPtr)
 TWOWORDINLINE(0x7000, 0xA824);
extern pascal OSErr UTReleaseFCB(short fileRefNum)
 TWOWORDINLINE(0x7001, 0xA824);
extern pascal OSErr UTLocateFCB(VCBPtr volCtrlBlockPtr, unsigned long fileNum, StringPtr namePtr, short *fileRefNum, FCBRecPtr *fileCtrlBlockPtr)
 TWOWORDINLINE(0x7002, 0xA824);
extern pascal OSErr UTLocateNextFCB(VCBPtr volCtrlBlockPtr, unsigned long fileNum, StringPtr namePtr, short *fileRefNum, FCBRecPtr *fileCtrlBlockPtr)
 TWOWORDINLINE(0x7003, 0xA824);
extern pascal OSErr UTIndexFCB(VCBPtr volCtrlBlockPtr, short *fileRefNum, FCBRecPtr *fileCtrlBlockPtr)
 TWOWORDINLINE(0x7004, 0xA824);
extern pascal OSErr UTResolveFCB(short fileRefNum, FCBRecPtr *fileCtrlBlockPtr)
 TWOWORDINLINE(0x7005, 0xA824);
extern pascal OSErr UTAllocateVCB(unsigned short *sysVCBLength, VCBPtr *volCtrlBlockPtr, unsigned short addSize)
 TWOWORDINLINE(0x7006, 0xA824);
extern pascal OSErr UTAddNewVCB(short driveNum, short *vRefNum, VCBPtr volCtrlBlockPtr)
 TWOWORDINLINE(0x7007, 0xA824);
extern pascal OSErr UTDisposeVCB(VCBPtr volCtrlBlockPtr)
 TWOWORDINLINE(0x7008, 0xA824);
extern pascal OSErr UTLocateVCBByRefNum(short refNum, short *vRefNum, VCBPtr *volCtrlBlockPtr)
 TWOWORDINLINE(0x7009, 0xA824);
extern pascal OSErr UTLocateVCBByName(StringPtr namePtr, short *moreMatches, short *vRefNum, VCBPtr *volCtrlBlockPtr)
 TWOWORDINLINE(0x700A, 0xA824);
extern pascal OSErr UTLocateNextVCB(StringPtr namePtr, short *moreMatches, short *vRefNum, VCBPtr *volCtrlBlockPtr)
 TWOWORDINLINE(0x700B, 0xA824);
extern pascal OSErr UTAllocateWDCB(WDPBPtr paramBlock)
 TWOWORDINLINE(0x700C, 0xA824);
extern pascal OSErr UTReleaseWDCB(short wdRefNum)
 TWOWORDINLINE(0x700D, 0xA824);
extern pascal OSErr UTResolveWDCB(long procID, short wdIndex, short wdRefNum, WDCBRecPtr *wdCtrlBlockPtr)
 TWOWORDINLINE(0x700E, 0xA824);
extern pascal OSErr UTFindDrive(short driveNum, DrvQElPtr *driveQElementPtr)
 TWOWORDINLINE(0x700F, 0xA824);
extern pascal OSErr UTAdjustEOF(short fileRefNum)
 TWOWORDINLINE(0x7010, 0xA824);
extern pascal OSErr UTSetDefaultVol(long nodeHint, unsigned long dirID, short refNum)
 TWOWORDINLINE(0x7011, 0xA824);
extern pascal OSErr UTGetDefaultVol(WDPBPtr paramBlock)
 TWOWORDINLINE(0x7012, 0xA824);
extern pascal OSErr UTEjectVol(VCBPtr volCtrlBlockPtr)
 TWOWORDINLINE(0x702B, 0xA824);
extern pascal OSErr UTCheckWDRefNum(short wdRefNum)
 TWOWORDINLINE(0x7013, 0xA824);
extern pascal OSErr UTCheckFileRefNum(short fileRefNum)
 TWOWORDINLINE(0x7014, 0xA824);
extern pascal OSErr UTCheckVolRefNum(short vRefNum)
 TWOWORDINLINE(0x7015, 0xA824);
extern pascal OSErr UTCheckPermission(VCBPtr volCtrlBlockPtr, short *modByte, unsigned long fileNum, ParmBlkPtr paramBlock)
 TWOWORDINLINE(0x7016, 0xA824);
extern pascal OSErr UTCheckVolOffline(short vRefNum)
 TWOWORDINLINE(0x7017, 0xA824);
extern pascal OSErr UTCheckVolModifiable(short vRefNum)
 TWOWORDINLINE(0x7018, 0xA824);
extern pascal OSErr UTCheckFileModifiable(short fileRefNum)
 TWOWORDINLINE(0x7019, 0xA824);
extern pascal OSErr UTCheckDirBusy(VCBPtr volCtrlBlockPtr, unsigned long dirID)
 TWOWORDINLINE(0x701A, 0xA824);
extern pascal OSErr UTParsePathname(short *volNamelength, StringPtr namePtr)
 TWOWORDINLINE(0x701B, 0xA824);
extern pascal OSErr UTGetPathComponentName(ParsePathRecPtr parseRec)
 TWOWORDINLINE(0x701C, 0xA824);
extern pascal OSErr UTDetermineVol(ParmBlkPtr paramBlock, short *status, short *moreMatches, short *vRefNum, VCBPtr *volCtrlBlockPtr)
 TWOWORDINLINE(0x701D, 0xA824);
extern pascal OSErr UTGetBlock(short refNum, void *log2PhyProc, unsigned long blockNum, short gbOption, Ptr *buffer)
 TWOWORDINLINE(0x701F, 0xA824);
extern pascal OSErr UTReleaseBlock(Ptr buffer, short rbOption)
 TWOWORDINLINE(0x7020, 0xA824);
extern pascal OSErr UTFlushCache(short refNum, short fcOption)
 TWOWORDINLINE(0x7021, 0xA824);
extern pascal OSErr UTMarkDirty(Ptr buffer)
 TWOWORDINLINE(0x7023, 0xA824);
extern pascal OSErr UTTrashVolBlocks(VCBPtr volCtrlBlockPtr)
 TWOWORDINLINE(0x7024, 0xA824);
extern pascal OSErr UTTrashFileBlocks(VCBPtr volCtrlBlockPtr, unsigned long fileNum)
 TWOWORDINLINE(0x7025, 0xA824);
extern pascal OSErr UTTrashBlocks(unsigned long beginPosition, unsigned long byteCount, VCBPtr volCtrlBlockPtr, short fileRefNum, short tbOption)
 TWOWORDINLINE(0x7026, 0xA824);
extern pascal OSErr UTCacheReadIP(void *log2PhyProc, unsigned long filePosition, Ptr ioBuffer, short fileRefNum, unsigned long reqCount, unsigned long *actCount, short cacheOption)
 TWOWORDINLINE(0x7027, 0xA824);
extern pascal OSErr UTCacheWriteIP(void *log2PhyProc, unsigned long filePosition, Ptr ioBuffer, short fileRefNum, unsigned long reqCount, unsigned long *actCount, short cacheOption)
 TWOWORDINLINE(0x7028, 0xA824);
extern pascal OSErr UTBlockInFQHashP(short vRefNum, unsigned long diskBlock)
 TWOWORDINLINE(0x702C, 0xA824);
/*
 *	File System Manager call prototypes
 */
extern pascal OSErr InstallFS(FSDRecPtr fsdPtr);
extern pascal OSErr RemoveFS(short fsid);
extern pascal OSErr SetFSInfo(short fsid, short bufSize, FSDRecPtr fsdPtr);
extern pascal OSErr GetFSInfo(short selector, short key, short *bufSize, FSDRecPtr fsdPtr);
extern pascal OSErr InformFSM(short theMessage, void *paramBlock);
extern pascal OSErr InformFFS(short fsid, void *paramBlock);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __FSM__ */

{
 	File:		FSM.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FSM;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FSM__}
{$SETC __FSM__ := 1}

{$I+}
{$SETC FSMIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	Types.p														}
{		ConditionalMacros.p										}
{	MixedMode.p													}
{	OSUtils.p													}
{		Memory.p												}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{$IFC OLDROUTINELOCATIONS }

CONST
	volMountInteractBit			= 15;							{ Input to VolumeMount: If set, it's OK for the file system }
	volMountInteractMask		= $8000;						{ to perform user interaction to mount the volume }
	volMountChangedBit			= 14;							{ Output from VoumeMount: If set, the volume was mounted, but }
	volMountChangedMask			= $4000;						{ the volume mounting information record needs to be updated. }
	volMountFSReservedMask		= $00ff;						{ bits 0-7 are defined by each file system for its own use }
	volMountSysReservedMask		= $ff00;						{ bits 8-15 are reserved for Apple system use }

{
 * additional volume mount info record
 }

TYPE
	VolumeMountInfoHeader = RECORD
		length:					INTEGER;								{ length of location data (including self) }
		media:					VolumeType;								{ type of media (must be registered with Apple) }
		flags:					INTEGER;								{ volume mount flags. Variable length data follows }
	END;

	VolumeMountInfoHeaderPtr = ^VolumeMountInfoHeader;


CONST
	gestaltFSMVersion			= 'fsm ';

	
TYPE
	VCBPtr = ^VCB;

{$ENDC}

CONST
	fsUsrCNID					= 16;							{ First assignable directory or file number }
{	File system trap word attribute bits }
	kHFSBit						= 9;							{ HFS call: bit 9 }
	kHFSMask					= $0200;
	kAsyncBit					= 10;							{ Asynchronous call: bit 10 }
	kAsyncMask					= $0400;

{
 * HFSCIProc selectCode values
 * Note: The trap attribute bits (the HFS bit and the asynchronous bit)
 * may be set in these selectCode values.
 }
	kFSMOpen					= $A000;
	kFSMClose					= $A001;
	kFSMRead					= $A002;
	kFSMWrite					= $A003;
	kFSMGetVolInfo				= $A007;
	kFSMCreate					= $A008;
	kFSMDelete					= $A009;
	kFSMOpenRF					= $A00A;
	kFSMRename					= $A00B;
	kFSMGetFileInfo				= $A00C;
	kFSMSetFileInfo				= $A00D;
	kFSMUnmountVol				= $A00E;
	kFSMMountVol				= $A00F;
	kFSMAllocate				= $A010;
	kFSMGetEOF					= $A011;
	kFSMSetEOF					= $A012;
	kFSMFlushVol				= $A013;
	kFSMGetVol					= $A014;
	kFSMSetVol					= $A015;
	kFSMEject					= $A017;
	kFSMGetFPos					= $A018;
	kFSMOffline					= $A035;
	kFSMSetFilLock				= $A041;
	kFSMRstFilLock				= $A042;
	kFSMSetFilType				= $A043;
	kFSMSetFPos					= $A044;
	kFSMFlushFile				= $A045;
{	The File System HFSDispatch selectCodes }
	kFSMOpenWD					= $0001;
	kFSMCloseWD					= $0002;
	kFSMCatMove					= $0005;
	kFSMDirCreate				= $0006;
	kFSMGetWDInfo				= $0007;
	kFSMGetFCBInfo				= $0008;
	kFSMGetCatInfo				= $0009;
	kFSMSetCatInfo				= $000A;
	kFSMSetVolInfo				= $000B;
	kFSMLockRng					= $0010;
	kFSMUnlockRng				= $0011;
	kFSMCreateFileIDRef			= $0014;
	kFSMDeleteFileIDRef			= $0015;
	kFSMResolveFileIDRef		= $0016;
	kFSMExchangeFiles			= $0017;
	kFSMCatSearch				= $0018;
	kFSMOpenDF					= $001A;
	kFSMMakeFSSpec				= $001B;
{	The Desktop Manager HFSDispatch selectCodes }
	kFSMDTGetPath				= $0020;
	kFSMDTCloseDown				= $0021;
	kFSMDTAddIcon				= $0022;
	kFSMDTGetIcon				= $0023;
	kFSMDTGetIconInfo			= $0024;
	kFSMDTAddAPPL				= $0025;
	kFSMDTRemoveAPPL			= $0026;
	kFSMDTGetAPPL				= $0027;
	kFSMDTSetComment			= $0028;
	kFSMDTRemoveComment			= $0029;
	kFSMDTGetComment			= $002A;
	kFSMDTFlush					= $002B;
	kFSMDTReset					= $002C;
	kFSMDTGetInfo				= $002D;
	kFSMDTOpenInform			= $002E;
	kFSMDTDelete				= $002F;
{	The AppleShare HFSDispatch selectCodes }
	kFSMGetVolParms				= $0030;
	kFSMGetLogInInfo			= $0031;
	kFSMGetDirAccess			= $0032;
	kFSMSetDirAccess			= $0033;
	kFSMMapID					= $0034;
	kFSMMapName					= $0035;
	kFSMCopyFile				= $0036;
	kFSMMoveRename				= $0037;
	kFSMOpenDeny				= $0038;
	kFSMOpenRFDeny				= $0039;
	kFSMGetXCatInfo				= $003A;
	kFSMGetVolMountInfoSize		= $003F;
	kFSMGetVolMountInfo			= $0040;
	kFSMVolumeMount				= $0041;
	kFSMShare					= $0042;
	kFSMUnShare					= $0043;
	kFSMGetUGEntry				= $0044;
	kFSMGetForeignPrivs			= $0060;
	kFSMSetForeignPrivs			= $0061;

{
 * UTDetermineVol status values
 }
	dtmvError					= 0;							{ param error }
	dtmvFullPathame				= 1;							{ determined by full pathname }
	dtmvVRefNum					= 2;							{ determined by volume refNum }
	dtmvWDRefNum				= 3;							{ determined by working directory refNum }
	dtmvDriveNum				= 4;							{ determined by drive number }
	dtmvDefault					= 5;							{ determined by default volume }

{
 * UTGetBlock options
 }
	gbDefault					= 0;							{ default value - read if not found }
{	bits and masks }
	gbReadBit					= 0;							{ read block from disk (forced read) }
	gbReadMask					= $0001;
	gbExistBit					= 1;							{ get existing cache block }
	gbExistMask					= $0002;
	gbNoReadBit					= 2;							{ don't read block from disk if not found in cache }
	gbNoReadMask				= $0004;
	gbReleaseBit				= 3;							{ release block immediately after GetBlock }
	gbReleaseMask				= $0008;

{
 * UTReleaseBlock options
 }
	rbDefault					= 0;							{ default value - just mark the buffer not in-use }
{	bits and masks }
	rbWriteBit					= 0;							{ force write buffer to disk }
	rbWriteMask					= $0001;
	rbTrashBit					= 1;							{ trash buffer contents after release }
	rbTrashMask					= $0002;
	rbDirtyBit					= 2;							{ mark buffer dirty }
	rbDirtyMask					= $0004;
	rbFreeBit					= 3;							{ free the buffer (save in the hash) }
{
 *	rbFreeMask (rbFreeBit + rbTrashBit) works as rbTrash on < System 7.0 RamCache;
 *	on >= System 7.0, rbfreeMask overrides rbTrash
 }
	rbFreeMask					= $000A;

{
 * UTFlushCache options
 }
	fcDefault					= 0;							{ default value - just flush any dirty buffers }
{	bits and masks }
	fcTrashBit					= 1;							{ trash buffers after flushing }
	fcTrashMask					= $0002;
	fcFreeBit					= 3;							{ free buffers after flushing }
	fcFreeMask					= $0008;						{ fcFreeMask works as fcTrash on < System 7.0 RamCache }

{
 * UTCacheReadIP and UTCacheWriteIP cacheOption
 }
	noCacheBit					= 5;							{ don't cache this please }
	noCacheMask					= $0020;
	rdVerifyBit					= 6;							{ read verify }
	rdVerifyMask				= $0040;

{
 * Cache routine internal error codes
 }
	chNoBuf						= 1;							{ no free cache buffers (all in use) }
	chInUse						= 2;							{ requested block in use }
	chnotfound					= 3;							{ requested block not found }
	chNotInUse					= 4;							{ block being released was not in use }

{
 * FCBRec.fcbFlags bits
 }
	fcbWriteBit					= 0;							{ Data can be written to this file }
	fcbWriteMask				= $01;
	fcbResourceBit				= 1;							{ This file is a resource fork }
	fcbResourceMask				= $02;
	fcbWriteLockedBit			= 2;							{ File has a locked byte range }
	fcbWriteLockedMask			= $04;
	fcbSharedWriteBit			= 4;							{ File is open for shared write access }
	fcbSharedWriteMask			= $10;
	fcbFileLockedBit			= 5;							{ File is locked (write-protected) }
	fcbFileLockedMask			= $20;
	fcbOwnClumpBit				= 6;							{ File has clump size specified in FCB }
	fcbOwnClumpMask				= $40;
	fcbModifiedBit				= 7;							{ File has changed since it was last flushed }
	fcbModifiedMask				= $80;

{
 * ExtFileProc options
 }
	extendFileAllBit			= 0;							{ allocate all requested bytes or none }
	extendFileAllMask			= $0001;
	extendFileContigBit			= 1;							{ force contiguous allocation }
	extendFileContigMask		= $0002;

{
 *	HFS Component Interface constants
 }
{
 * compInterfMask bits specific to HFS component
 }
	hfsCIDoesHFSBit				= 23;							{ set if file system supports HFS calls }
	hfsCIDoesHFSMask			= $00800000;
	hfsCIDoesAppleShareBit		= 22;							{ set if AppleShare calls supported }
	hfsCIDoesAppleShareMask		= $00400000;
	hfsCIDoesDeskTopBit			= 21;							{ set if Desktop Database calls supported }
	hfsCIDoesDeskTopMask		= $00200000;
	hfsCIDoesDynamicLoadBit		= 20;							{ set if dynamically loading code resource }
	hfsCIDoesDynamicLoadMask	= $00100000;					{		supported }
	hfsCIResourceLoadedBit		= 19;							{ set if code resource already loaded }
	hfsCIResourceLoadedMask		= $00080000;
	hfsCIHasHLL2PProcBit		= 18;							{ set if FFS' log2PhyProc and Extendfile proc }
	hfsCIHasHLL2PProcMask		= $00040000;					{ is written in a high level language. (i.e., uses Pascal calling convention) }

{
 *	Disk Initialization Component Interface constants
 }
{
 * compInterfMask bits specific to Disk Initialization component
 }
	diCIHasExtFormatParamsBit	= 18;							{ set if file system needs extended format }
	diCIHasExtFormatParamsMask	= $00040000;					{		parameters }
	diCIHasMultiVolTypesBit		= 17;							{ set if file system supports more than one }
	diCIHasMultiVolTypesMask	= $00020000;					{		volume type }
	diCIDoesSparingBit			= 16;							{ set if file system supports disk sparing }
	diCIDoesSparingMask			= $00010000;
	diCILiveBit					= 0;							{ set if file system is candidate for current }
	diCILiveMask				= $00000001;					{		formatting operation (set by PACK2) }

{
 * Disk Initialization Component Function selectors
 }
	diCILoad					= 1;							{ Make initialization code memory resident }
	diCIUnload					= 2;							{ Make initialization code purgeable }
	diCIEvaluateSizeChoices		= 3;							{ Evaluate size choices }
	diCIExtendedZero			= 4;							{ Write an empty volume directory }
	diCIValidateVolName			= 5;							{ Validate volume name }
	diCIGetVolTypeInfo			= 6;							{ get volume type info }
	diCIGetFormatString			= 7;							{ get dialog format string }
	diCIGetExtFormatParams		= 8;							{ get extended format parameters }
	diCIGetDefectList			= 9;							{ return the defect list for the indicated disk - reserved for future use }

{
 * Constants used in the DICIEvaluateSizeRec and FormatListRec
 }
	diCIFmtListMax				= 8;							{ maximum number of format list entries in DICIEvaluateSizeRec.numSizeEntries }
{	bits in FormatListRec.formatFlags: }
	diCIFmtFlagsValidBit		= 7;							{ set if sec, side, tracks valid }
	diCIFmtFlagsValidMask		= $80;
	diCIFmtFlagsCurrentBit		= 6;							{ set if current disk has this fmt }
	diCIFmtFlagsCurrentMask		= $40;
{	bits in FormatListRec.sizeListFlags: }
	diCISizeListOKBit			= 15;							{ set if this disk size usable }
	diCISizeListOKMask			= $8000;

{
 * DICIGetFormatStringRec.stringKind format strings
 }
	diCIAlternateFormatStr		= 1;							{ get alternate format  string (Balloon Help) }
	diCISizePresentationStr		= 2;							{ get size presentation string (for dialog) }

{
 * Error codes returned by Disk Sparing
 }
	diCIUserCancelErr			= 1;							{ user cancelled the disk init }
	diCICriticalSectorBadErr	= 20;							{ critical sectors are bad (hopeless)	}
	diCISparingFailedErr		= 21;							{ disk cannot be spared }
	diCITooManyBadSectorsErr	= 22;							{ too many bad sectors }
	diCIUnknownVolTypeErr		= 23;							{ the volume type passed in diCIExtendedZero paramBlock is not supported }
	diCIVolSizeMismatchErr		= 24;							{ specified volume size doesn’t match with formatted disk size }
	diCIUnknownDICallErr		= 25;							{ bogus DI function call selector }
	diCINoSparingErr			= 26;							{ disk is bad but the target FS doesn't do disk sparing }
	diCINoExtendInfoErr			= 27;							{ missing file system specific extra parameter in diCIExtendedZero call }
	diCINoMessageTextErr		= 28;							{ missing message text in DIReformat call }

{
 *	File System Manager constants
 }
{
 * Miscellaneous constants used by FSM
 }
	fsdVersion1					= 1;							{ current version of FSD record }
	fsmIgnoreFSID				= $fffe;						{ this FSID should be ignored by the driver }
	fsmGenericFSID				= $ffff;						{ unknown foreign file system ID }

{
 * compInterfMask bits common to all FSM components
 }
	fsmComponentEnableBit		= 31;							{ set if FSM component interface is enabled }
	fsmComponentEnableMask		= $80000000;
	fsmComponentBusyBit			= 30;							{ set if FSM component interface is busy }
	fsmComponentBusyMask		= $40000000;

{
 * Selectors for GetFSInfo
 }
	fsmGetFSInfoByIndex			= -1;							{ get fs info by index }
	fsmGetFSInfoByFSID			= 0;							{ get fs info by FSID }
	fsmGetFSInfoByRefNum		= 1;							{ get fs info by file/vol refnum }

{
 * InformFSM messages
 }
	fsmNopMessage				= 0;							{ nop }
	fsmDrvQElChangedMessage		= 1;							{ DQE has changed }
	fsmGetFSIconMessage			= 2;							{ Get FFS's disk icon }

{
 * Messages passed to the fileSystemCommProc
 }
	ffsNopMessage				= 0;							{ nop, should always return noErr }
	ffsGetIconMessage			= 1;							{ return disk icon and mask }
	ffsIDDiskMessage			= 2;							{ identify the about-to-be-mounted volume }
	ffsLoadMessage				= 3;							{ load in the FFS }
	ffsUnloadMessage			= 4;							{ unload the FFS }
	ffsIDVolMountMessage		= 5;							{ identify a VolMountInfo record }
	ffsInformMessage			= 6;							{ FFS defined message }
	ffsGetIconInfoMessage		= 7;

{
 * Error codes from FSM functions
 }
	fsmFFSNotFoundErr			= -431;							{ Foreign File system does not exist - new Pack2 could return this error too }
	fsmBusyFFSErr				= -432;							{ File system is busy, cannot be removed }
	fsmBadFFSNameErr			= -433;							{ Name length not 1 <= length <= 31 }
	fsmBadFSDLenErr				= -434;							{ FSD size incompatible with current FSM vers }
	fsmDuplicateFSIDErr			= -435;							{ FSID already exists on InstallFS }
	fsmBadFSDVersionErr			= -436;							{ FSM version incompatible with FSD }
	fsmNoAlternateStackErr		= -437;							{ no alternate stack for HFS CI }
	fsmUnknownFSMMessageErr		= -438;							{ unknown message passed to FSM }

{
 *	HFS Utility routine records
 }
{
 * record used by UTGetPathComponentName
 }

TYPE
	ParsePathRec = RECORD
		namePtr:				StringPtr;								{ pathname to parse }
		startOffset:			INTEGER;								{ where to start parsing }
		componentLength:		INTEGER;								{ the length of the pathname component parsed }
		moreName:				SignedByte;								{ non-zero if there are more components after this one }
		foundDelimiter:			SignedByte;								{ non-zero if parsing stopped because a colon (:) delimiter was found }
	END;

	ParsePathRecPtr = ^ParsePathRec;

	WDCBRec = RECORD
		wdVCBPtr:				VCBPtr;									{ Pointer to VCB of this working directory }
		wdDirID:				LONGINT;								{ Directory ID number of this working directory }
		wdCatHint:				LONGINT;								{ Hint for finding this working directory }
		wdProcID:				LONGINT;								{ Process that created this working directory }
	END;

	WDCBRecPtr = ^WDCBRec;

	FCBRec = RECORD
		fcbFlNm:				LONGINT;								{ FCB file number. Non-zero marks FCB used }
		fcbFlags:				SignedByte;								{ FCB flags }
		fcbTypByt:				SignedByte;								{ File type byte }
		fcbSBlk:				INTEGER;								{ File start block (in alloc size blks) }
		fcbEOF:					LONGINT;								{ Logical length or EOF in bytes }
		fcbPLen:				LONGINT;								{ Physical file length in bytes }
		fcbCrPs:				LONGINT;								{ Current position within file }
		fcbVPtr:				VCBPtr;									{ Pointer to the corresponding VCB }
		fcbBfAdr:				Ptr;									{ File's buffer address }
		fcbFlPos:				INTEGER;								{ Directory block this file is in }
		{ FCB Extensions for HFS }
		fcbClmpSize:			LONGINT;								{ Number of bytes per clump }
		fcbBTCBPtr:				Ptr;									{ Pointer to B*-Tree control block for file }
		fcbExtRec:				ARRAY [0..2] OF LONGINT;				{ First 3 file extents }
		fcbFType:				OSType;									{ File's 4 Finder Type bytes }
		fcbCatPos:				LONGINT;								{ Catalog hint for use on Close }
		fcbDirID:				LONGINT;								{ Parent Directory ID }
		fcbCName:				Str31;									{ CName of open file }
	END;

	FCBRecPtr = ^FCBRec;

{
 *	HFS Component Interface records
 }
	Lg2PhysProcPtr = ProcPtr;  { FUNCTION Lg2Phys(fsdGlobalPtr: UNIV Ptr; volCtrlBlockPtr: VCBPtr; fileCtrlBlockPtr: FCBRecPtr; fileRefNum: INTEGER; filePosition: LONGINT; reqCount: LONGINT; VAR volOffset: LONGINT; VAR contiguousBytes: LONGINT): OSErr; }
	Lg2PhysUPP = UniversalProcPtr;

CONST
	uppLg2PhysProcInfo = $003FEFE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param, 2 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewLg2PhysProc(userRoutine: Lg2PhysProcPtr): Lg2PhysUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallLg2PhysProc(fsdGlobalPtr: UNIV Ptr; volCtrlBlockPtr: VCBPtr; fileCtrlBlockPtr: FCBRecPtr; fileRefNum: INTEGER; filePosition: LONGINT; reqCount: LONGINT; VAR volOffset: LONGINT; VAR contiguousBytes: LONGINT; userRoutine: Lg2PhysUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
TYPE
	HFSCIProcPtr = ProcPtr;  { FUNCTION HFSCI(theVCB: VCBPtr; selectCode: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; fsid: INTEGER): OSErr; }
	HFSCIUPP = UniversalProcPtr;

CONST
	uppHFSCIProcInfo = $0000BEE0; { FUNCTION (4 byte param, 2 byte param, 4 byte param, 4 byte param, 2 byte param): 2 byte result; }

FUNCTION NewHFSCIProc(userRoutine: HFSCIProcPtr): HFSCIUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallHFSCIProc(theVCB: VCBPtr; selectCode: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; fsid: INTEGER; userRoutine: HFSCIUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	HFSCIRec = RECORD
		compInterfMask:			LONGINT;								{ component flags }
		compInterfProc:			HFSCIUPP;								{ pointer to file system call processing code }
		log2PhyProc:			Lg2PhysUPP;								{ pointer to Lg2PhysProc() code }
		stackTop:				Ptr;									{ file system stack top }
		stackSize:				LONGINT;								{ file system stack size }
		stackPtr:				Ptr;									{ current file system stack pointer }
		reserved3:				LONGINT;								{ --reserved, must be zero-- }
		idSector:				LONGINT;								{ Sector you need to ID a local volume. For networked volumes, this must be -1 }
		reserved2:				LONGINT;								{ --reserved, must be zero-- }
		reserved1:				LONGINT;								{ --reserved, must be zero-- }
	END;

	HFSCIRecPtr = ^HFSCIRec;

{
 *	Disk Initialization Component Interface records
 }
	DICIProcPtr = ProcPtr;  { FUNCTION DICI(whatFunction: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr): OSErr; }
	DICIUPP = UniversalProcPtr;

CONST
	uppDICIProcInfo = $00000FA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewDICIProc(userRoutine: DICIProcPtr): DICIUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallDICIProc(whatFunction: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; userRoutine: DICIUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	DICIRec = RECORD
		compInterfMask:			LONGINT;								{ component flags }
		compInterfProc:			DICIUPP;								{ pointer to call processing code }
		maxVolNameLength:		INTEGER;								{ maximum length of your volume name }
		blockSize:				INTEGER;								{ your file system's block size }
		reserved3:				LONGINT;								{ --reserved, must be zero-- }
		reserved2:				LONGINT;								{ --reserved, must be zero-- }
		reserved1:				LONGINT;								{ --reserved, must be zero-- }
	END;

	DICIRecPtr = ^DICIRec;

{
 * FormatListRec as returned by the .Sony disk driver's
 * Return Format List status call (csCode = 6).
 * If the status call to get this list for a drive is not
 * implemented by the driver, then a list with one entry
 * is contructed from the drive queue element for the drive.
 }
	FormatListRec = RECORD
		volSize:				LONGINT;								{ disk capacity in SECTORs }
		formatFlags:			SignedByte;								{ flags }
		sectorsPerTrack:		SignedByte;								{ sectors per track side }
		tracks:					INTEGER;								{ number of tracks }
	END;

	FormatListRecPtr = ^FormatListRec;

{
 * SizeListRec built from FormatListRecs as described above.
 }
	SizeListRec = RECORD
		sizeListFlags:			INTEGER;								{ flags as set by external file system }
		sizeEntry:				FormatListRec;							{ disk driver format list record }
	END;

	SizeListRecPtr = ^SizeListRec;

{
 * paramBlock for the diCIEvaluateSize call
 }
	DICIEvaluateSizeRec = RECORD
		defaultSizeIndex:		INTEGER;								{ default size for this FS }
		numSizeEntries:			INTEGER;								{ number of size entries }
		driveNumber:			INTEGER;								{ drive number }
		sizeListPtr:			SizeListRecPtr;							{ ptr to size entry table }
		sectorSize:				INTEGER;								{ bytes per sector }
	END;

	DICIEvaluateSizeRecPtr = ^DICIEvaluateSizeRec;

{
 * paramBlock for the diCIExtendedZero call
 }
	DICIExtendedZeroRec = RECORD
		driveNumber:			INTEGER;								{ drive number }
		volNamePtr:				StringPtr;								{ ptr to volume name string }
		fsid:					INTEGER;								{ file system ID }
		volTypeSelector:		INTEGER;								{ volume type selector, if supports more than 1 type }
		numDefectBlocks:		INTEGER;								{ number of bad logical blocks }
		defectListSize:			INTEGER;								{ size of the defect list buffer in bytes }
		defectListPtr:			Ptr;									{ pointer to defect list buffer }
		volSize:				LONGINT;								{ size of volume in SECTORs }
		sectorSize:				INTEGER;								{ bytes per sector }
		extendedInfoPtr:		Ptr;									{ ptr to extended info }
	END;

	DICIExtendedZeroRecPtr = ^DICIExtendedZeroRec;

{
 * paramBlock for the diCIValidateVolName call
 }
	DICIValidateVolNameRec = PACKED RECORD
		theChar:				CHAR;									{ the character to validate }
		hasMessageBuffer:		BOOLEAN;								{ false if no message }
		charOffset:				INTEGER;								{ position of the current character (first char = 1) }
		messageBufferPtr:		StringPtr;								{ pointer to message buffer or nil }
		charByteType:			INTEGER;								{ theChar's byte type (smSingleByte, smFirstByte, or smLastByte) }
	END;

	DICIValidateVolNameRecPtr = ^DICIValidateVolNameRec;

{
 * paramBlock for the diCIGetVolTypeInfo call
 }
	DICIGetVolTypeInfoRec = RECORD
		volSize:				LONGINT;								{ size of volume in SECTORs }
		sectorSize:				INTEGER;								{ bytes per sector }
		numVolTypes:			INTEGER;								{ number of volume types supported }
		volTypesBuffer:			ARRAY [0..3] OF Str31;					{ 4 string buffers }
	END;

	DICIGetVolTypeInfoRecPtr = ^DICIGetVolTypeInfoRec;

{
 * paramBlock for the diCIGetFormatString call
 }
	DICIGetFormatStringRec = RECORD
		volSize:				LONGINT;								{ volume size in SECTORs }
		sectorSize:				INTEGER;								{ sector size }
		volTypeSelector:		INTEGER;								{ volume type selector }
		stringKind:				INTEGER;								{ sub-function = type of string }
		stringBuffer:			Str255;									{ string buffer }
	END;

	DICIGetFormatStringRecPtr = ^DICIGetFormatStringRec;

{
 * paramBlock for the diCIGetExtendedFormatParams call
 }
	DICIGetExtendedFormatRec = RECORD
		driveNumber:			INTEGER;								{ drive number }
		volTypeSelector:		INTEGER;								{ volume type selector or 0 }
		volSize:				LONGINT;								{ size of volume in SECTORs }
		sectorSize:				INTEGER;								{ bytes per sector }
		fileSystemSpecPtr:		FSSpecPtr;								{ pointer to the foreign file system's FSSpec }
		extendedInfoPtr:		Ptr;									{ pointer to extended parameter structure }
	END;

	DICIGetExtendedFormatRecPtr = ^DICIGetExtendedFormatRec;

{
 *	File System Manager records
 }
	FSDCommProcPtr = ProcPtr;  { FUNCTION FSDComm(message: INTEGER; paramBlock: UNIV Ptr; globalsPtr: UNIV Ptr): OSErr; }
	FSDCommUPP = UniversalProcPtr;

CONST
	uppFSDCommProcInfo = $00000FA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewFSDCommProc(userRoutine: FSDCommProcPtr): FSDCommUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallFSDCommProc(message: INTEGER; paramBlock: UNIV Ptr; globalsPtr: UNIV Ptr; userRoutine: FSDCommUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	FSDRec = RECORD
		fsdLink:				^FSDRec;								{ ptr to next }
		fsdLength:				INTEGER;								{ length of this FSD in BYTES }
		fsdVersion:				INTEGER;								{ version number }
		fileSystemFSID:			INTEGER;								{ file system id }
		fileSystemName:			Str31;									{ file system name }
		fileSystemSpec:			FSSpec;									{ foreign file system's FSSpec }
		fileSystemGlobalsPtr:	Ptr;									{ ptr to file system globals }
		fileSystemCommProc:		FSDCommUPP;								{ communication proc with the FFS }
		reserved3:				LONGINT;								{ --reserved, must be zero-- }
		reserved2:				LONGINT;								{ --reserved, must be zero-- }
		reserved1:				LONGINT;								{ --reserved, must be zero-- }
		fsdHFSCI:				HFSCIRec;								{ HFS component interface    }
		fsdDICI:				DICIRec;								{ Disk Initialization component interface }
	END;

	FSDRecPtr = ^FSDRec;

	FSMGetIconInfoRec = RECORD
		theIcon:				ARRAY [0..31] OF LONGINT;				{ The ICN# structure }
		theMask:				ARRAY [0..31] OF LONGINT;				{ The mask for the icon above }
		whereStr:				Str255;
	END;

	FSMGetIconInfoRecPtr = ^FSMGetIconInfoRec;

{
 * paramBlock for ffsGetIconMessage and fsmGetFSIconMessage
 }
	FSMGetIconRec = RECORD
		refNum:					INTEGER;								{ target drive num or volume refnum }
		iconBufferPtr:			FSMGetIconInfoRecPtr;					{ pointer to icon buffer }
		requestSize:			LONGINT;								{ requested size of the icon buffer }
		actualSize:				LONGINT;								{ actual size of the icon data returned }
		iconType:				SInt8;									{ kind of icon }
		isEjectable:			BOOLEAN;								{ true if the device is ejectable }
		driveQElemPtr:			DrvQElPtr;								{ pointer to DQE }
		fileSystemSpecPtr:		FSSpecPtr;								{ pointer to foreign file system's FSSpec }
		reserved1:				LONGINT;								{ --reserved, must be zero-- }
	END;

	FSMGetIconRecPtr = ^FSMGetIconRec;

{
 *	HFS Utility routine prototypes
 }

FUNCTION UTAllocateFCB(VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A824;
	{$ENDC}
FUNCTION UTReleaseFCB(fileRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A824;
	{$ENDC}
FUNCTION UTLocateFCB(volCtrlBlockPtr: VCBPtr; fileNum: LONGINT; namePtr: StringPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $A824;
	{$ENDC}
FUNCTION UTLocateNextFCB(volCtrlBlockPtr: VCBPtr; fileNum: LONGINT; namePtr: StringPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $A824;
	{$ENDC}
FUNCTION UTIndexFCB(volCtrlBlockPtr: VCBPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $A824;
	{$ENDC}
FUNCTION UTResolveFCB(fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $A824;
	{$ENDC}
FUNCTION UTAllocateVCB(VAR sysVCBLength: INTEGER; VAR volCtrlBlockPtr: VCBPtr; addSize: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $A824;
	{$ENDC}
FUNCTION UTAddNewVCB(driveNum: INTEGER; VAR vRefNum: INTEGER; volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $A824;
	{$ENDC}
FUNCTION UTDisposeVCB(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $A824;
	{$ENDC}
FUNCTION UTLocateVCBByRefNum(refNum: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $A824;
	{$ENDC}
FUNCTION UTLocateVCBByName(namePtr: StringPtr; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $A824;
	{$ENDC}
FUNCTION UTLocateNextVCB(namePtr: StringPtr; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $A824;
	{$ENDC}
FUNCTION UTAllocateWDCB(paramBlock: WDPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $A824;
	{$ENDC}
FUNCTION UTReleaseWDCB(wdRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $A824;
	{$ENDC}
FUNCTION UTResolveWDCB(procID: LONGINT; wdIndex: INTEGER; wdRefNum: INTEGER; VAR wdCtrlBlockPtr: WDCBRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $A824;
	{$ENDC}
FUNCTION UTFindDrive(driveNum: INTEGER; VAR driveQElementPtr: DrvQElPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $A824;
	{$ENDC}
FUNCTION UTAdjustEOF(fileRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $A824;
	{$ENDC}
FUNCTION UTSetDefaultVol(nodeHint: LONGINT; dirID: LONGINT; refNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $A824;
	{$ENDC}
FUNCTION UTGetDefaultVol(paramBlock: WDPBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $A824;
	{$ENDC}
FUNCTION UTEjectVol(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702B, $A824;
	{$ENDC}
FUNCTION UTCheckWDRefNum(wdRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $A824;
	{$ENDC}
FUNCTION UTCheckFileRefNum(fileRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $A824;
	{$ENDC}
FUNCTION UTCheckVolRefNum(vRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $A824;
	{$ENDC}
FUNCTION UTCheckPermission(volCtrlBlockPtr: VCBPtr; VAR modByte: INTEGER; fileNum: LONGINT; paramBlock: ParmBlkPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $A824;
	{$ENDC}
FUNCTION UTCheckVolOffline(vRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $A824;
	{$ENDC}
FUNCTION UTCheckVolModifiable(vRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $A824;
	{$ENDC}
FUNCTION UTCheckFileModifiable(fileRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7019, $A824;
	{$ENDC}
FUNCTION UTCheckDirBusy(volCtrlBlockPtr: VCBPtr; dirID: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701A, $A824;
	{$ENDC}
FUNCTION UTParsePathname(VAR volNamelength: INTEGER; namePtr: StringPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $A824;
	{$ENDC}
FUNCTION UTGetPathComponentName(parseRec: ParsePathRecPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $A824;
	{$ENDC}
FUNCTION UTDetermineVol(paramBlock: ParmBlkPtr; VAR status: INTEGER; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $A824;
	{$ENDC}
FUNCTION UTGetBlock(refNum: INTEGER; log2PhyProc: UNIV Ptr; blockNum: LONGINT; gbOption: INTEGER; VAR buffer: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $A824;
	{$ENDC}
FUNCTION UTReleaseBlock(buffer: Ptr; rbOption: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $A824;
	{$ENDC}
FUNCTION UTFlushCache(refNum: INTEGER; fcOption: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $A824;
	{$ENDC}
FUNCTION UTMarkDirty(buffer: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $A824;
	{$ENDC}
FUNCTION UTTrashVolBlocks(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7024, $A824;
	{$ENDC}
FUNCTION UTTrashFileBlocks(volCtrlBlockPtr: VCBPtr; fileNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $A824;
	{$ENDC}
FUNCTION UTTrashBlocks(beginPosition: LONGINT; byteCount: LONGINT; volCtrlBlockPtr: VCBPtr; fileRefNum: INTEGER; tbOption: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7026, $A824;
	{$ENDC}
FUNCTION UTCacheReadIP(log2PhyProc: UNIV Ptr; filePosition: LONGINT; ioBuffer: Ptr; fileRefNum: INTEGER; reqCount: LONGINT; VAR actCount: LONGINT; cacheOption: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7027, $A824;
	{$ENDC}
FUNCTION UTCacheWriteIP(log2PhyProc: UNIV Ptr; filePosition: LONGINT; ioBuffer: Ptr; fileRefNum: INTEGER; reqCount: LONGINT; VAR actCount: LONGINT; cacheOption: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7028, $A824;
	{$ENDC}
FUNCTION UTBlockInFQHashP(vRefNum: INTEGER; diskBlock: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702C, $A824;
	{$ENDC}
{
 *	File System Manager call prototypes
 }
FUNCTION InstallFS(fsdPtr: FSDRecPtr): OSErr;
FUNCTION RemoveFS(fsid: INTEGER): OSErr;
FUNCTION SetFSInfo(fsid: INTEGER; bufSize: INTEGER; fsdPtr: FSDRecPtr): OSErr;
FUNCTION GetFSInfo(selector: INTEGER; key: INTEGER; VAR bufSize: INTEGER; fsdPtr: FSDRecPtr): OSErr;
FUNCTION InformFSM(theMessage: INTEGER; paramBlock: UNIV Ptr): OSErr;
FUNCTION InformFFS(fsid: INTEGER; paramBlock: UNIV Ptr): OSErr;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FSMIncludes}

{$ENDC} {__FSM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

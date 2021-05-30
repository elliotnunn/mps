{
     File:       FSM.p
 
     Contains:   HFS External File System Interfaces.
 
     Version:    Technology: Mac OS 9
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
{$IFC UNDEFINED __HFSVOLUMES__}
{$I HFSVolumes.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ VolMount declarations are now in Files.≈ }

{
 * Miscellaneous file system values not in Files.≈
 }

CONST
	fsUsrCNID					= 16;							{  First assignable directory or file number  }
																{     File system trap word attribute bits  }
	kHFSBit						= 9;							{  HFS call: bit 9  }
	kHFSMask					= $0200;
	kAsyncBit					= 10;							{  Asynchronous call: bit 10  }
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
	kFSMFlushFile				= $A045;						{     The File System HFSDispatch selectCodes  }
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
	kFSMXGetVolInfo				= $0012;
	kFSMCreateFileIDRef			= $0014;
	kFSMDeleteFileIDRef			= $0015;
	kFSMResolveFileIDRef		= $0016;
	kFSMExchangeFiles			= $0017;
	kFSMCatSearch				= $0018;
	kFSMOpenDF					= $001A;
	kFSMMakeFSSpec				= $001B;						{     The Desktop Manager HFSDispatch selectCodes  }
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
	kFSMDTDelete				= $002F;						{     The AppleShare HFSDispatch selectCodes  }
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
	kFSMSetForeignPrivs			= $0061;						{  The HFSPlus API SelectCodes (below) }
	kFSMGetVolumeInfo			= $001D;						{  Dispatched by ioVRefNum and volumeIndex  }
	kFSMSetVolumeInfo			= $001E;						{  Dispatched by ioVRefNum  }
	kFSMReadFork				= $0051;						{  Fork I/O calls dispatched by forkRefNum (ioRefNum)  }
	kFSMWriteFork				= $0052;
	kFSMGetForkPosition			= $0053;
	kFSMSetForkPosition			= $0054;
	kFSMGetForkSize				= $0055;
	kFSMSetForkSize				= $0056;
	kFSMAllocateFork			= $0057;
	kFSMFlushFork				= $0058;
	kFSMCloseFork				= $0059;
	kFSMGetForkCBInfo			= $005A;
	kFSMCloseIterator			= $005B;						{  Iterator calls are dispatched by upper two bytes of "iterator",  }
	kFSMGetCatalogInfoBulk		= $005C;						{  which is treated as an ioRefNum.  By convention, the lower two  }
	kFSMCatalogSearch			= $005D;						{  bytes of the FSIterator are zero, though this is not enforced.  }
	kFSMMakeFSRef				= $006E;						{  Dispatched by ioVRefNum/ioDirID/ioNamePtr  }
	kFSMCreateFileUnicode		= $0070;						{  FSRef dispatched calls.  The first two bytes of an FSRef  }
	kFSMCreateDirUnicode		= $0071;						{  are a volume reference number (not a working directory reference  }
	kFSMDeleteObject			= $0072;						{  number or drive number).  The remaining bytes of the FSRef are  }
	kFSMMoveObject				= $0073;						{  defined by that particular volume format.  }
	kFSMRenameUnicode			= $0074;
	kFSMExchangeObjects			= $0075;
	kFSMGetCatalogInfo			= $0076;
	kFSMSetCatalogInfo			= $0077;
	kFSMOpenIterator			= $0078;
	kFSMOpenFork				= $0079;
	kFSMMakeFSRefUnicode		= $007A;
	kFSMCompareFSRefs			= $007C;
	kFSMCreateFork				= $007D;
	kFSMDeleteFork				= $007E;
	kFSMIterateForks			= $007F;

	{	
	 * UTDetermineVol status values
	 	}
	dtmvError					= 0;							{  param error  }
	dtmvFullPathname			= 1;							{  determined by full pathname  }
	dtmvVRefNum					= 2;							{  determined by volume refNum  }
	dtmvWDRefNum				= 3;							{  determined by working directory refNum  }
	dtmvDriveNum				= 4;							{  determined by drive number  }
	dtmvDefault					= 5;							{  determined by default volume  }


	{	
	 * UTGetBlock options
	 	}
	gbDefault					= 0;							{  default value - read if not found  }
																{     bits and masks  }
	gbReadBit					= 0;							{  read block from disk (forced read)  }
	gbReadMask					= $0001;
	gbExistBit					= 1;							{  get existing cache block  }
	gbExistMask					= $0002;
	gbNoReadBit					= 2;							{  don't read block from disk if not found in cache  }
	gbNoReadMask				= $0004;
	gbReleaseBit				= 3;							{  release block immediately after GetBlock  }
	gbReleaseMask				= $0008;


	{	
	 * UTReleaseBlock options
	 	}
	rbDefault					= 0;							{  default value - just mark the buffer not in-use  }
																{     bits and masks  }
	rbWriteBit					= 0;							{  force write buffer to disk  }
	rbWriteMask					= $0001;
	rbTrashBit					= 1;							{  trash buffer contents after release  }
	rbTrashMask					= $0002;
	rbDirtyBit					= 2;							{  mark buffer dirty  }
	rbDirtyMask					= $0004;
	rbFreeBit					= 3;							{  free the buffer (save in the hash)  }
	rbFreeMask					= $000A;						{  rbFreeMask (rbFreeBit + rbTrashBit) works as rbTrash on < System 7.0 RamCache; on >= System 7.0, rbfreeMask overrides rbTrash  }


	{	
	 * UTFlushCache options
	 	}
	fcDefault					= 0;							{  default value - pass this fcOption to just flush any dirty buffers  }
																{     bits and masks  }
	fcTrashBit					= 0;							{  (don't pass this as fcOption, use only for testing bit)  }
	fcTrashMask					= $0001;						{  pass this fcOption value to flush and trash cache blocks  }
	fcFreeBit					= 1;							{  (don't pass this as fcOption, use only for testing bit)  }
	fcFreeMask					= $0003;						{  pass this fcOption to flush and free cache blocks (Note: both fcTrash and fcFree bits are set)  }


	{	
	 * UTCacheReadIP and UTCacheWriteIP cacheOption bits and masks are the ioPosMode
	 * bits and masks in Files.x
	 	}

	{	
	 * Cache routine internal error codes
	 	}
	chNoBuf						= 1;							{  no free cache buffers (all in use)  }
	chInUse						= 2;							{  requested block in use  }
	chnotfound					= 3;							{  requested block not found  }
	chNotInUse					= 4;							{  block being released was not in use  }


	{	
	 * FCBRec.fcbFlags bits
	 	}
	fcbWriteBit					= 0;							{  Data can be written to this file  }
	fcbWriteMask				= $01;
	fcbResourceBit				= 1;							{  This file is a resource fork  }
	fcbResourceMask				= $02;
	fcbWriteLockedBit			= 2;							{  File has a locked byte range  }
	fcbWriteLockedMask			= $04;
	fcbLargeFileBit				= 3;							{  File may grow beyond 2GB; cache uses file blocks, not bytes  }
	fcbLargeFileMask			= $08;
	fcbSharedWriteBit			= 4;							{  File is open for shared write access  }
	fcbSharedWriteMask			= $10;
	fcbFileLockedBit			= 5;							{  File is locked (write-protected)  }
	fcbFileLockedMask			= $20;
	fcbOwnClumpBit				= 6;							{  File has clump size specified in FCB  }
	fcbOwnClumpMask				= $40;
	fcbModifiedBit				= 7;							{  File has changed since it was last flushed  }
	fcbModifiedMask				= $80;


	{	
	 *  ForkControlBlock.moreFlags bits
	 	}
	fcbIteratorBit				= 0;							{  FCB belongs to an FSIterator  }
	fcbIteratorMask				= $0001;
	fcbUseForkIDBit				= 1;							{  Use the FCB's forkID instead of fcbResourceBit  }
	fcbUseForkIDMask			= $0002;

	{	
	 *  HFS Component Interface constants
	 	}

	{	
	 * compInterfMask bits specific to HFS component
	 	}
	hfsCIDoesHFSBit				= 23;							{  set if file system supports HFS calls  }
	hfsCIDoesHFSMask			= $00800000;
	hfsCIDoesAppleShareBit		= 22;							{  set if AppleShare calls supported  }
	hfsCIDoesAppleShareMask		= $00400000;
	hfsCIDoesDeskTopBit			= 21;							{  set if Desktop Database calls supported  }
	hfsCIDoesDeskTopMask		= $00200000;
	hfsCIDoesDynamicLoadBit		= 20;							{  set if dynamically loading code resource  }
	hfsCIDoesDynamicLoadMask	= $00100000;					{        supported  }
	hfsCIResourceLoadedBit		= 19;							{  set if code resource already loaded  }
	hfsCIResourceLoadedMask		= $00080000;
	hfsCIHasHLL2PProcBit		= 18;							{  set if FFS' log2PhyProc  }
	hfsCIHasHLL2PProcMask		= $00040000;					{  is written in a high level language. (i.e., uses Pascal calling convention)  }
	hfsCIWantsDTSupportBit		= 17;							{  set if FFS wants the Mac OS's Desktop Manager code to handle  }
	hfsCIWantsDTSupportMask		= $00020000;					{  all Desktop Manager requests to its volumes.  }


	{	
	 *  Disk Initialization Component Interface constants
	 	}

	{	
	 * compInterfMask bits specific to Disk Initialization component
	 	}
	diCIHasExtFormatParamsBit	= 18;							{  set if file system needs extended format  }
	diCIHasExtFormatParamsMask	= $00040000;					{        parameters  }
	diCIHasMultiVolTypesBit		= 17;							{  set if file system supports more than one  }
	diCIHasMultiVolTypesMask	= $00020000;					{        volume type  }
	diCIDoesSparingBit			= 16;							{  set if file system supports disk sparing  }
	diCIDoesSparingMask			= $00010000;
	diCILiveBit					= 0;							{  set if file system is candidate for current  }
	diCILiveMask				= $00000001;					{        formatting operation (set by PACK2)  }


	{	
	 * Disk Initialization Component Function selectors
	 	}
	diCILoad					= 1;							{  Make initialization code memory resident  }
	diCIUnload					= 2;							{  Make initialization code purgeable  }
	diCIEvaluateSizeChoices		= 3;							{  Evaluate size choices  }
	diCIExtendedZero			= 4;							{  Write an empty volume directory  }
	diCIValidateVolName			= 5;							{  Validate volume name  }
	diCIGetVolTypeInfo			= 6;							{  get volume type info  }
	diCIGetFormatString			= 7;							{  get dialog format string  }
	diCIGetExtFormatParams		= 8;							{  get extended format parameters  }
	diCIGetDefectList			= 9;							{  return the defect list for the indicated disk - reserved for future use  }


	{	
	 * Constants used in the DICIEvaluateSizeRec and FormatListRec
	 	}
	diCIFmtListMax				= 8;							{  maximum number of format list entries in DICIEvaluateSizeRec.numSizeEntries  }
																{     bits in FormatListRec.formatFlags:  }
	diCIFmtFlagsValidBit		= 7;							{  set if sec, side, tracks valid  }
	diCIFmtFlagsValidMask		= $80;
	diCIFmtFlagsCurrentBit		= 6;							{  set if current disk has this fmt  }
	diCIFmtFlagsCurrentMask		= $40;							{     bits in FormatListRec.sizeListFlags:  }
	diCISizeListOKBit			= 15;							{  set if this disk size usable  }
	diCISizeListOKMask			= $8000;


	{	
	 * DICIGetFormatStringRec.stringKind format strings
	 	}
	diCIAlternateFormatStr		= 1;							{  get alternate format  string (Balloon Help)  }
	diCISizePresentationStr		= 2;							{  get size presentation string (for dialog)  }


	{	
	 * Error codes returned by Disk Sparing
	 	}
	diCIUserCancelErr			= 1;							{  user cancelled the disk init  }
	diCICriticalSectorBadErr	= 20;							{  critical sectors are bad (hopeless)     }
	diCISparingFailedErr		= 21;							{  disk cannot be spared  }
	diCITooManyBadSectorsErr	= 22;							{  too many bad sectors  }
	diCIUnknownVolTypeErr		= 23;							{  the volume type passed in diCIExtendedZero paramBlock is not supported  }
	diCIVolSizeMismatchErr		= 24;							{  specified volume size doesn’t match with formatted disk size  }
	diCIUnknownDICallErr		= 25;							{  bogus DI function call selector  }
	diCINoSparingErr			= 26;							{  disk is bad but the target FS doesn't do disk sparing  }
	diCINoExtendInfoErr			= 27;							{  missing file system specific extra parameter in diCIExtendedZero call  }
	diCINoMessageTextErr		= 28;							{  missing message text in DIReformat call  }


	{	
	 *  File System Manager constants
	 	}

	{	
	 * Miscellaneous constants used by FSM
	 	}
	fsdVersion1					= 1;							{  current version of FSD record  }
	fsmIgnoreFSID				= $FFFE;						{  this FSID should be ignored by the driver  }
	fsmGenericFSID				= $FFFF;						{  unknown foreign file system ID  }


	{	
	 * compInterfMask bits common to all FSM components
	 	}
	fsmComponentEnableBit		= 31;							{  set if FSM component interface is enabled  }
	fsmComponentEnableMask		= $80000000;
	fsmComponentBusyBit			= 30;							{  set if FSM component interface is busy  }
	fsmComponentBusyMask		= $40000000;


	{	
	 * Selectors for GetFSInfo
	 	}
	fsmGetFSInfoByIndex			= -1;							{  get fs info by index  }
	fsmGetFSInfoByFSID			= 0;							{  get fs info by FSID  }
	fsmGetFSInfoByRefNum		= 1;							{  get fs info by file/vol refnum  }


	{	
	 * InformFSM messages
	 	}
	fsmNopMessage				= 0;							{  nop  }
	fsmDrvQElChangedMessage		= 1;							{  DQE has changed  }
	fsmGetFSIconMessage			= 2;							{  Get FFS's disk icon  }


	{	
	 * Messages passed to the fileSystemCommProc
	 	}
	ffsNopMessage				= 0;							{  nop, should always return noErr  }
	ffsGetIconMessage			= 1;							{  return disk icon and mask  }
	ffsIDDiskMessage			= 2;							{  identify the about-to-be-mounted volume  }
	ffsLoadMessage				= 3;							{  load in the FFS  }
	ffsUnloadMessage			= 4;							{  unload the FFS  }
	ffsIDVolMountMessage		= 5;							{  identify a VolMountInfo record  }
	ffsInformMessage			= 6;							{  FFS defined message  }
	ffsGetIconInfoMessage		= 7;



	{	
	 *  HFS Utility routine records
	 	}

	{	
	 * record used by UTGetPathComponentName
	 	}

TYPE
	ParsePathRecPtr = ^ParsePathRec;
	ParsePathRec = RECORD
		namePtr:				StringPtr;								{  pathname to parse  }
		startOffset:			INTEGER;								{  where to start parsing  }
		componentLength:		INTEGER;								{  the length of the pathname component parsed  }
		moreName:				SignedByte;								{  non-zero if there are more components after this one  }
		foundDelimiter:			SignedByte;								{  non-zero if parsing stopped because a colon (:) delimiter was found  }
	END;

	WDCBRecPtr = ^WDCBRec;
	WDCBRec = RECORD
		wdVCBPtr:				VCBPtr;									{  Pointer to VCB of this working directory  }
		wdDirID:				LONGINT;								{  Directory ID number of this working directory  }
		wdCatHint:				LONGINT;								{  Hint for finding this working directory  }
		wdProcID:				LONGINT;								{  Process that created this working directory  }
	END;

	FCBRecPtr = ^FCBRec;
	FCBRec = RECORD
		fcbFlNm:				UInt32;									{  FCB file number. Non-zero marks FCB used  }
		fcbFlags:				SignedByte;								{  FCB flags  }
		fcbTypByt:				SignedByte;								{  File type byte  }
		fcbSBlk:				UInt16;									{  File start block (in alloc size blks)  }
		fcbEOF:					UInt32;									{  Logical length or EOF in bytes  }
		fcbPLen:				UInt32;									{  Physical file length in bytes  }
		fcbCrPs:				UInt32;									{  Current position within file  }
		fcbVPtr:				VCBPtr;									{  Pointer to the corresponding VCB  }
		fcbBfAdr:				Ptr;									{  File's buffer address  }
		fcbFlPos:				UInt16;									{  Directory block this file is in  }
																		{  FCB Extensions for HFS  }
		fcbClmpSize:			UInt32;									{  Number of bytes per clump  }
		fcbBTCBPtr:				Ptr;									{  Pointer to B*-Tree control block for file  }
		fcbExtRec:				HFSExtentRecord;						{  First 3 file extents  }
		fcbFType:				OSType;									{  File's 4 Finder Type bytes  }
		fcbCatPos:				UInt32;									{  Catalog hint for use on Close  }
		fcbDirID:				UInt32;									{  Parent Directory ID  }
		fcbCName:				Str31;									{  CName of open file  }
	END;

	ForkControlBlockPtr = ^ForkControlBlock;
	ForkControlBlock = RECORD
		fcbFlNm:				UInt32;									{  FCB file number. Non-zero marks FCB used  }
		fcbFlags:				SignedByte;								{  FCB flags  }
		fcbTypByt:				SignedByte;								{  File type byte  }
		fcbSBlk:				UInt16;									{  File start block (in alloc size blks)  }
		fcbEOF:					UInt32;									{  Logical length or EOF in bytes  }
		fcbPLen:				UInt32;									{  Physical file length in bytes  }
		fcbCrPs:				UInt32;									{  Current position within file  }
		fcbVPtr:				VCBPtr;									{  Pointer to the corresponding VCB  }
		fcbBfAdr:				Ptr;									{  File's buffer address  }
		fcbFlPos:				UInt16;									{  Directory block this file is in  }
																		{  FCB Extensions for HFS  }
		fcbClmpSize:			UInt32;									{  Number of bytes per clump  }
		fcbBTCBPtr:				Ptr;									{  Pointer to B*-Tree control block for file  }
		fcbExtRec:				HFSExtentRecord;						{  First 3 file extents  }
		fcbFType:				OSType;									{  File's 4 Finder Type bytes  }
		fcbCatPos:				UInt32;									{  Catalog hint for use on Close  }
		fcbDirID:				UInt32;									{  Parent Directory ID  }
		fcbCName:				Str31;									{  CName of open file  }
																		{     New fields start here }
		moreFlags:				UInt16;									{  more flags, align following fields }
																		{     Old ExtendedFCB fields }
		processID:				ProcessSerialNumber;					{  Process Mgr process that opened the file (used to clean up at process death). }
		extents:				HFSPlusExtentRecord;					{  extents for HFS+ volumes }
																		{     New fields for HFS Plus APIs }
		endOfFile:				UInt64;									{  logical size of this fork }
		physicalEOF:			UInt64;									{  amount of space physically allocated to this fork }
		currentPosition:		UInt64;									{  default offset for next read/write }
		forkID:					UInt32;
		searchListPtr:			Ptr;									{  reserved for File Manager's use }
		reserved1:				PACKED ARRAY [0..7] OF UInt8;			{  reserved }
	END;

	{	
	 *  IteratorControlBlock - a ForkControlBlock used by a FSIterator
	 	}
	IteratorControlBlockPtr = ^IteratorControlBlock;
	IteratorControlBlock = RECORD
		containerID:			UInt32;									{  directory ID of iterator's container }
		flags:					UInt16;									{  reserved }
		user1:					PACKED ARRAY [0..13] OF UInt8;			{  14 bytes iterator's use }
		vcbPtr:					VCBPtr;									{  pointer to the iterator's VCB }
		reserved2:				UInt32;									{  reserved }
		user2:					PACKED ARRAY [0..5] OF UInt8;			{  6 bytes for iterator's use }
		reserved3:				UInt32;									{  reserved }
		user3:					PACKED ARRAY [0..11] OF UInt8;			{  12 bytes for iterator's use }
		cbType:					OSType;									{  must be 'fold' }
		user4:					PACKED ARRAY [0..39] OF UInt8;			{  40 bytes for iterator's use }
		moreFlags:				UInt16;									{  must be fcbIteratorMask }
		processID:				ProcessSerialNumber;					{  Process Mgr process that opened the iterator (used to clean up at process death). }
		user5:					PACKED ARRAY [0..91] OF UInt8;			{  92 bytes for iterator's use }
		searchListPtr:			Ptr;									{  reserved for File Manager's use }
		reserved1:				PACKED ARRAY [0..7] OF UInt8;			{  reserved }
	END;

	{	
	 *  HFS Component Interface records
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	Lg2PhysProcPtr = FUNCTION(fsdGlobalPtr: UNIV Ptr; volCtrlBlockPtr: VCBPtr; fileCtrlBlockPtr: FCBRecPtr; fileRefNum: INTEGER; filePosition: UInt32; reqCount: UInt32; VAR volOffset: UInt32; VAR contiguousBytes: UInt32): OSErr;
{$ELSEC}
	Lg2PhysProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	Lg2PhysUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	Lg2PhysUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppLg2PhysProcInfo = $003FEFE0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewLg2PhysUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewLg2PhysUPP(userRoutine: Lg2PhysProcPtr): Lg2PhysUPP; { old name was NewLg2PhysProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeLg2PhysUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeLg2PhysUPP(userUPP: Lg2PhysUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeLg2PhysUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeLg2PhysUPP(fsdGlobalPtr: UNIV Ptr; volCtrlBlockPtr: VCBPtr; fileCtrlBlockPtr: FCBRecPtr; fileRefNum: INTEGER; filePosition: UInt32; reqCount: UInt32; VAR volOffset: UInt32; VAR contiguousBytes: UInt32; userRoutine: Lg2PhysUPP): OSErr; { old name was CallLg2PhysProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HFSCIProcPtr = FUNCTION(theVCB: VCBPtr; selectCode: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; fsid: INTEGER): OSErr;
{$ELSEC}
	HFSCIProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HFSCIUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HFSCIUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppHFSCIProcInfo = $0000BEE0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewHFSCIUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewHFSCIUPP(userRoutine: HFSCIProcPtr): HFSCIUPP; { old name was NewHFSCIProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeHFSCIUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeHFSCIUPP(userUPP: HFSCIUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeHFSCIUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeHFSCIUPP(theVCB: VCBPtr; selectCode: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; fsid: INTEGER; userRoutine: HFSCIUPP): OSErr; { old name was CallHFSCIProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	HFSCIRecPtr = ^HFSCIRec;
	HFSCIRec = RECORD
		compInterfMask:			LONGINT;								{  component flags  }
		compInterfProc:			HFSCIUPP;								{  pointer to file system call processing code  }
		log2PhyProc:			Lg2PhysUPP;								{  pointer to Lg2PhysProc() code  }
		stackTop:				Ptr;									{  file system stack top  }
		stackSize:				LONGINT;								{  file system stack size  }
		stackPtr:				Ptr;									{  current file system stack pointer  }
		reserved3:				LONGINT;								{  --reserved, must be zero--  }
		idSector:				LONGINT;								{  Sector you need to ID a local volume. For networked volumes, this must be -1  }
		reserved2:				LONGINT;								{  --reserved, must be zero--  }
		reserved1:				LONGINT;								{  --reserved, must be zero--  }
	END;

	{	
	 *  Disk Initialization Component Interface records
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	DICIProcPtr = FUNCTION(whatFunction: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr): OSErr;
{$ELSEC}
	DICIProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DICIUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DICIUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDICIProcInfo = $00000FA0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewDICIUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewDICIUPP(userRoutine: DICIProcPtr): DICIUPP; { old name was NewDICIProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDICIUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDICIUPP(userUPP: DICIUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDICIUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDICIUPP(whatFunction: INTEGER; paramBlock: UNIV Ptr; fsdGlobalPtr: UNIV Ptr; userRoutine: DICIUPP): OSErr; { old name was CallDICIProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	DICIRecPtr = ^DICIRec;
	DICIRec = RECORD
		compInterfMask:			LONGINT;								{  component flags  }
		compInterfProc:			DICIUPP;								{  pointer to call processing code  }
		maxVolNameLength:		INTEGER;								{  maximum length of your volume name  }
		blockSize:				UInt16;									{  your file system's block size  }
		reserved3:				LONGINT;								{  --reserved, must be zero--  }
		reserved2:				LONGINT;								{  --reserved, must be zero--  }
		reserved1:				LONGINT;								{  --reserved, must be zero--  }
	END;

	{	
	 * FormatListRec as returned by the .Sony disk driver's
	 * Return Format List status call (csCode = 6).
	 * If the status call to get this list for a drive is not
	 * implemented by the driver, then a list with one entry
	 * is contructed from the drive queue element for the drive.
	 	}
	FormatListRecPtr = ^FormatListRec;
	FormatListRec = RECORD
		volSize:				UInt32;									{  disk capacity in SECTORs  }
		formatFlags:			SignedByte;								{  flags  }
		sectorsPerTrack:		SignedByte;								{  sectors per track side  }
		tracks:					UInt16;									{  number of tracks  }
	END;

	{	
	 * SizeListRec built from FormatListRecs as described above.
	 	}
	SizeListRecPtr = ^SizeListRec;
	SizeListRec = RECORD
		sizeListFlags:			INTEGER;								{  flags as set by external file system  }
		sizeEntry:				FormatListRec;							{  disk driver format list record  }
	END;

	{	
	 * paramBlock for the diCIEvaluateSize call
	 	}
	DICIEvaluateSizeRecPtr = ^DICIEvaluateSizeRec;
	DICIEvaluateSizeRec = RECORD
		defaultSizeIndex:		INTEGER;								{  default size for this FS  }
		numSizeEntries:			INTEGER;								{  number of size entries  }
		driveNumber:			INTEGER;								{  drive number  }
		sizeListPtr:			SizeListRecPtr;							{  ptr to size entry table  }
		sectorSize:				UInt16;									{  bytes per sector  }
	END;

	{	
	 * paramBlock for the diCIExtendedZero call
	 	}
	DICIExtendedZeroRecPtr = ^DICIExtendedZeroRec;
	DICIExtendedZeroRec = RECORD
		driveNumber:			INTEGER;								{  drive number  }
		volNamePtr:				StringPtr;								{  ptr to volume name string  }
		fsid:					INTEGER;								{  file system ID  }
		volTypeSelector:		INTEGER;								{  volume type selector, if supports more than 1 type  }
		numDefectBlocks:		UInt16;									{  number of bad logical blocks  }
		defectListSize:			UInt16;									{  size of the defect list buffer in bytes  }
		defectListPtr:			Ptr;									{  pointer to defect list buffer  }
		volSize:				UInt32;									{  size of volume in SECTORs  }
		sectorSize:				UInt16;									{  bytes per sector  }
		extendedInfoPtr:		Ptr;									{  ptr to extended info  }
	END;

	{	
	 * paramBlock for the diCIValidateVolName call
	 	}
	DICIValidateVolNameRecPtr = ^DICIValidateVolNameRec;
	DICIValidateVolNameRec = PACKED RECORD
		theChar:				CHAR;									{  the character to validate  }
		hasMessageBuffer:		BOOLEAN;								{  false if no message  }
		charOffset:				INTEGER;								{  position of the current character (first char = 1)  }
		messageBufferPtr:		StringPtr;								{  pointer to message buffer or nil  }
		charByteType:			INTEGER;								{  theChar's byte type (smSingleByte, smFirstByte, or smLastByte)  }
	END;

	{	
	 * paramBlock for the diCIGetVolTypeInfo call
	 	}
	DICIGetVolTypeInfoRecPtr = ^DICIGetVolTypeInfoRec;
	DICIGetVolTypeInfoRec = RECORD
		volSize:				UInt32;									{  size of volume in SECTORs  }
		sectorSize:				UInt16;									{  bytes per sector  }
		numVolTypes:			INTEGER;								{  number of volume types supported  }
		volTypesBuffer:			ARRAY [0..3] OF Str31;					{  4 string buffers  }
	END;

	{	
	 * paramBlock for the diCIGetFormatString call
	 	}
	DICIGetFormatStringRecPtr = ^DICIGetFormatStringRec;
	DICIGetFormatStringRec = RECORD
		volSize:				UInt32;									{  volume size in SECTORs  }
		sectorSize:				UInt16;									{  sector size  }
		volTypeSelector:		INTEGER;								{  volume type selector  }
		stringKind:				INTEGER;								{  sub-function = type of string  }
		stringBuffer:			Str255;									{  string buffer  }
	END;

	{	
	 * paramBlock for the diCIGetExtendedFormatParams call
	 	}
	DICIGetExtendedFormatRecPtr = ^DICIGetExtendedFormatRec;
	DICIGetExtendedFormatRec = RECORD
		driveNumber:			INTEGER;								{  drive number  }
		volTypeSelector:		INTEGER;								{  volume type selector or 0  }
		volSize:				UInt32;									{  size of volume in SECTORs  }
		sectorSize:				UInt16;									{  bytes per sector  }
		fileSystemSpecPtr:		FSSpecPtr;								{  pointer to the foreign file system's FSSpec  }
		extendedInfoPtr:		Ptr;									{  pointer to extended parameter structure  }
	END;

	{	
	 *  File System Manager records
	 	}

{$IFC TYPED_FUNCTION_POINTERS}
	FSDCommProcPtr = FUNCTION(message: INTEGER; paramBlock: UNIV Ptr; globalsPtr: UNIV Ptr): OSErr;
{$ELSEC}
	FSDCommProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FSDCommUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FSDCommUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppFSDCommProcInfo = $00000FA0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewFSDCommUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewFSDCommUPP(userRoutine: FSDCommProcPtr): FSDCommUPP; { old name was NewFSDCommProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFSDCommUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFSDCommUPP(userUPP: FSDCommUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFSDCommUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeFSDCommUPP(message: INTEGER; paramBlock: UNIV Ptr; globalsPtr: UNIV Ptr; userRoutine: FSDCommUPP): OSErr; { old name was CallFSDCommProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	FSDRecPtr = ^FSDRec;
	FSDRec = RECORD
		fsdLink:				FSDRecPtr;								{  ptr to next  }
		fsdLength:				INTEGER;								{  length of this FSD in BYTES  }
		fsdVersion:				INTEGER;								{  version number  }
		fileSystemFSID:			INTEGER;								{  file system id  }
		fileSystemName:			Str31;									{  file system name  }
		fileSystemSpec:			FSSpec;									{  foreign file system's FSSpec  }
		fileSystemGlobalsPtr:	Ptr;									{  ptr to file system globals  }
		fileSystemCommProc:		FSDCommUPP;								{  communication proc with the FFS  }
		reserved3:				LONGINT;								{  --reserved, must be zero--  }
		reserved2:				LONGINT;								{  --reserved, must be zero--  }
		reserved1:				LONGINT;								{  --reserved, must be zero--  }
		fsdHFSCI:				HFSCIRec;								{  HFS component interface     }
		fsdDICI:				DICIRec;								{  Disk Initialization component interface  }
	END;

	FSMGetIconInfoRecPtr = ^FSMGetIconInfoRec;
	FSMGetIconInfoRec = RECORD
		theIcon:				ARRAY [0..31] OF LONGINT;				{  The ICN# structure  }
		theMask:				ARRAY [0..31] OF LONGINT;				{  The mask for the icon above  }
		whereStr:				Str255;
	END;

	{	
	 * paramBlock for ffsGetIconMessage and fsmGetFSIconMessage
	 	}
	FSMGetIconRecPtr = ^FSMGetIconRec;
	FSMGetIconRec = RECORD
		refNum:					INTEGER;								{  target drive num or volume refnum  }
		iconBufferPtr:			FSMGetIconInfoRecPtr;					{  pointer to icon buffer  }
		requestSize:			LONGINT;								{  requested size of the icon buffer  }
		actualSize:				LONGINT;								{  actual size of the icon data returned  }
		iconType:				SInt8;									{  kind of icon. Note: A file system supporting kicnsIconFamily must  }
																		{  return noErr, up to requestSize bytes of data, and the actual size  }
																		{  of the 'icns' data in the actualSize field. If actualSize is greater  }
																		{  than requestSize, the caller must resize the icon buffer and retry  }
																		{  the request with the larger buffer and new requestSize.  }
		isEjectable:			BOOLEAN;								{  true if the device is ejectable  }
		driveQElemPtr:			DrvQElPtr;								{  pointer to DQE  }
		fileSystemSpecPtr:		FSSpecPtr;								{  pointer to foreign file system's FSSpec  }
		reserved1:				LONGINT;								{  --reserved, must be zero--  }
	END;

	{	
	 *  HFS Utility routine prototypes
	 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  UTAllocateFCB()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION UTAllocateFCB(VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A824;
	{$ENDC}

{
 *  UTReleaseFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTReleaseFCB(fileRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A824;
	{$ENDC}

{
 *  UTLocateFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateFCB(volCtrlBlockPtr: VCBPtr; fileNum: UInt32; namePtr: StringPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A824;
	{$ENDC}

{
 *  UTLocateNextFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateNextFCB(volCtrlBlockPtr: VCBPtr; fileNum: UInt32; namePtr: StringPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $A824;
	{$ENDC}

{
 *  UTIndexFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTIndexFCB(volCtrlBlockPtr: VCBPtr; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A824;
	{$ENDC}

{
 *  UTResolveFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTResolveFCB(fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A824;
	{$ENDC}

{
 *  UTAllocateVCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTAllocateVCB(VAR sysVCBLength: UInt16; VAR volCtrlBlockPtr: VCBPtr; addSize: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A824;
	{$ENDC}

{
 *  UTAddNewVCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTAddNewVCB(driveNum: INTEGER; VAR vRefNum: INTEGER; volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A824;
	{$ENDC}

{
 *  UTDisposeVCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTDisposeVCB(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A824;
	{$ENDC}

{
 *  UTLocateVCBByRefNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateVCBByRefNum(refNum: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $A824;
	{$ENDC}

{
 *  UTLocateVCBByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateVCBByName(namePtr: StringPtr; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $A824;
	{$ENDC}

{
 *  UTLocateNextVCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateNextVCB(namePtr: StringPtr; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $A824;
	{$ENDC}

{
 *  UTAllocateWDCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTAllocateWDCB(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $A824;
	{$ENDC}

{
 *  UTReleaseWDCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTReleaseWDCB(wdRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $A824;
	{$ENDC}

{
 *  UTResolveWDCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTResolveWDCB(procID: LONGINT; wdIndex: INTEGER; wdRefNum: INTEGER; VAR wdCtrlBlockPtr: WDCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A824;
	{$ENDC}

{
 *  UTFindDrive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTFindDrive(driveNum: INTEGER; VAR driveQElementPtr: DrvQElPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $A824;
	{$ENDC}

{
 *  UTAdjustEOF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTAdjustEOF(fileRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $A824;
	{$ENDC}

{
 *  UTSetDefaultVol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTSetDefaultVol(nodeHint: LONGINT; dirID: UInt32; refNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A824;
	{$ENDC}

{
 *  UTGetDefaultVol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTGetDefaultVol(paramBlock: WDPBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A824;
	{$ENDC}

{
 *  UTEjectVol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTEjectVol(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $A824;
	{$ENDC}

{
 *  UTCheckWDRefNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckWDRefNum(wdRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $A824;
	{$ENDC}

{
 *  UTCheckFileRefNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckFileRefNum(fileRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A824;
	{$ENDC}

{
 *  UTCheckVolRefNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckVolRefNum(vRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $A824;
	{$ENDC}

{
 *  UTCheckPermission()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckPermission(volCtrlBlockPtr: VCBPtr; VAR modByte: INTEGER; fileNum: UInt32; paramBlock: ParmBlkPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $A824;
	{$ENDC}

{
 *  UTCheckVolOffline()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckVolOffline(vRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7017, $A824;
	{$ENDC}

{
 *  UTCheckVolModifiable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckVolModifiable(vRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $A824;
	{$ENDC}

{
 *  UTCheckFileModifiable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckFileModifiable(fileRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $A824;
	{$ENDC}

{
 *  UTCheckDirBusy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckDirBusy(volCtrlBlockPtr: VCBPtr; dirID: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $A824;
	{$ENDC}

{
 *  UTParsePathname()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTParsePathname(VAR volNamelength: INTEGER; namePtr: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $A824;
	{$ENDC}

{
 *  UTGetPathComponentName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTGetPathComponentName(parseRec: ParsePathRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $A824;
	{$ENDC}

{
 *  UTDetermineVol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTDetermineVol(paramBlock: ParmBlkPtr; VAR status: INTEGER; VAR moreMatches: INTEGER; VAR vRefNum: INTEGER; VAR volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $A824;
	{$ENDC}

{
 *  UTGetBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTGetBlock(refNum: INTEGER; log2PhyProc: UNIV Ptr; blockNum: UInt32; gbOption: INTEGER; VAR buffer: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $A824;
	{$ENDC}

{
 *  UTReleaseBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTReleaseBlock(buffer: Ptr; rbOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A824;
	{$ENDC}

{
 *  UTFlushCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTFlushCache(refNum: INTEGER; fcOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A824;
	{$ENDC}

{
 *  UTMarkDirty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTMarkDirty(buffer: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $A824;
	{$ENDC}

{
 *  UTTrashVolBlocks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTTrashVolBlocks(volCtrlBlockPtr: VCBPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $A824;
	{$ENDC}

{
 *  UTTrashFileBlocks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTTrashFileBlocks(volCtrlBlockPtr: VCBPtr; fileNum: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $A824;
	{$ENDC}

{
 *  UTTrashBlocks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTTrashBlocks(beginPosition: UInt32; byteCount: UInt32; volCtrlBlockPtr: VCBPtr; fileRefNum: INTEGER; tbOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $A824;
	{$ENDC}

{
 *  UTCacheReadIP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCacheReadIP(log2PhyProc: UNIV Ptr; filePosition: UInt32; ioBuffer: Ptr; fileRefNum: INTEGER; reqCount: UInt32; VAR actCount: UInt32; cacheOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $A824;
	{$ENDC}

{
 *  UTCacheWriteIP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCacheWriteIP(log2PhyProc: UNIV Ptr; filePosition: UInt32; ioBuffer: Ptr; fileRefNum: INTEGER; reqCount: UInt32; VAR actCount: UInt32; cacheOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7028, $A824;
	{$ENDC}

{
 *  UTBlockInFQHashP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTBlockInFQHashP(vRefNum: INTEGER; diskBlock: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702C, $A824;
	{$ENDC}

{
 *  UTVolCacheReadIP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTVolCacheReadIP(volCtrlBlockPtr: VCBPtr; blockPosition: UInt32; ioBuffer: Ptr; reqCount: UInt32; VAR actCount: UInt32; cacheOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $A824;
	{$ENDC}

{
 *  UTVolCacheWriteIP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTVolCacheWriteIP(volCtrlBlockPtr: VCBPtr; blockPosition: UInt32; ioBuffer: Ptr; reqCount: UInt32; VAR actCount: UInt32; cacheOption: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $A824;
	{$ENDC}

{
 *  UTResolveFileRefNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTResolveFileRefNum(fileCtrlBlockPtr: FCBRecPtr; VAR fileRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $A824;
	{$ENDC}

{
 *  UTCheckFCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckFCB(fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $A824;
	{$ENDC}

{
 *  UTCheckForkPermissions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTCheckForkPermissions(volCtrlBlockPtr: VCBPtr; fileNum: UInt32; forkID: UInt32; fileLocked: BOOLEAN; permissions: SInt8; useSearchList: BOOLEAN; VAR fcbFlags: SInt8; VAR openForkRefNum: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $A824;
	{$ENDC}

{
 *  UTAddFCBToSearchList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTAddFCBToSearchList(fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $A824;
	{$ENDC}

{
 *  UTRemoveFCBFromSearchList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTRemoveFCBFromSearchList(fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703A, $A824;
	{$ENDC}

{
 *  UTLocateFCBInSearchList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTLocateFCBInSearchList(volCtrlBlockPtr: VCBPtr; fileNum: UInt32; VAR fileRefNum: INTEGER; VAR fileCtrlBlockPtr: FCBRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703B, $A824;
	{$ENDC}

{
 *  UTGetForkControlBlockSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UTGetForkControlBlockSize(VAR fcbSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703C, $A824;
	{$ENDC}


{
 *  File System Manager call prototypes
 }
{
 *  InstallFS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InstallFS(fsdPtr: FSDRecPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7000, $A0AC, $3E80;
	{$ENDC}

{
 *  RemoveFS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemoveFS(fsid: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $305F, $7001, $A0AC, $3E80;
	{$ENDC}

{
 *  GetFSInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFSInfo(selector: INTEGER; key: INTEGER; VAR bufSize: INTEGER; fsdPtr: FSDRecPtr): OSErr;

{
 *  SetFSInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetFSInfo(fsid: INTEGER; bufSize: INTEGER; fsdPtr: FSDRecPtr): OSErr;

{
 *  InformFSM()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InformFSM(theMessage: INTEGER; paramBlock: UNIV Ptr): OSErr;

{
 *  InformFFS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InformFFS(fsid: INTEGER; paramBlock: UNIV Ptr): OSErr;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FSMIncludes}

{$ENDC} {__FSM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

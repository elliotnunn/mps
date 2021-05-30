/*
	Errors.h -- Error definitions

	Version 2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
*/

/****************************************************************************
 modification history

 <C206/09oct86>	BBM	new this date (needed memROZError for heap/heapguts)
 <A301/21Oct86>	NSJ merged in all errors from other nfiles (nQuickEqu,
					SlotIntMgr, SlotMgrEqu, nToolEqu) almost the entire
					file is new on this date. also new sound manager errors.
 <A329/02Nov86> RDC Added new error codes and name changes for SlotManager.a
 <C473/02Dec86> ABO Merged in errors from ASPEqu.a and AFPEqu.a
 <C671/22Jan87> GWN Added new error code for SDM.
 <C679/23Jan87> GWN Added new error code for SDM.
 <C686/25Jan87> RDC New error code for bad slot interrupt
 <C694/26Jan87> RDC Changed error code for bad slot int so it would
 					not conflict with undocumented error code for Finder!
 <C696/26Jan87> GWN Added new error code for SDM.
 <C733/02Feb87> DAF Changed Color Manager Error numbers
 <C735/02Feb87> GWN Added new error code for SDM.
 <C744/03Feb87> S.McD. Added deep shit alert equate for bad sane opcodes.
 <C795/11Feb87> GWN Added new error code for SDM.
 <C816/13Feb87 	DAF Moved color manager error codes.
		13feb87	KLH added AppleShare HFS error # -124.
***************************************************************************/

#ifndef __ERRORS__
#define __ERRORS__


/* General System Errors (VBL Mgr, Queueing, Etc.) */

#define noErr	 	 0	 	 /* 0 for success */
#define qErr	 	 -1 	 /* queue element not found during deletion */
#define vTypErr 	 -2 	 /* invalid queue element */
#define corErr	 	 -3 	 /* core routine number out of range */
#define unimpErr	 -4 	 /* unimplemented core routine */
#define seNoDB	 	 -8 	 /* no debugger installed to handle debugger command <what num???> */

/* I/O System Errors */

#define controlErr	 -17
#define statusErr	 -18
#define readErr 	 -19
#define writErr 	 -20
#define badUnitErr	 -21
#define unitEmptyErr -22
#define openErr 	 -23
#define closErr 	 -24
#define dRemovErr	 -25	 /* tried to remove an open driver */
#define dInstErr	 -26	 /* DrvrInstall couldn't find driver in resources */ 
#define abortErr	 -27	 /* IO call aborted by KillIO */
#define notOpenErr	 -28	 /* Couldn't rd/wr/ctl/sts cause driver not opened */

/* File System error codes: */

#define dirFulErr	 -33	 /* Directory full */
#define dskFulErr	 -34	 /* disk full */
#define nsvErr	 	 -35	 /* no such volume */
#define ioErr	 	 -36	 /* I/O error (bummers) */
#define bdNamErr	 -37	 /* there may be no bad names in the final system! */
#define fnOpnErr	 -38	 /* File not open */
#define eofErr	 	 -39	 /* End of file */
#define posErr	 	 -40	 /* tried to position to before start of file (r/w) */
#define mFulErr 	 -41	 /* memory full (open) or file won't fit (load) */
#define tmfoErr 	 -42	 /* too many files open */
#define fnfErr	 	 -43	 /* File not found */

#define wPrErr	 	 -44	 /* diskette is write protected */  

#define fLckdErr	 -45	 /* file is locked */
#define vLckdErr	 -46	 /* volume is locked */
#define fBsyErr 	 -47	 /* File is busy (delete) */
#define dupFNErr	 -48	 /* duplicate filename (rename) */
#define opWrErr 	 -49	 /* file already open with with write permission */
#define paramErr	 -50	 /* error in user parameter list */
#define rfNumErr	 -51	 /* refnum error */
#define gfpErr 		 -52	 /* get file position error */
#define volOffLinErr -53	 /* volume not on line error (was Ejected) */
#define permErr 	 -54	 /* permissions error (on file open) */
#define volOnLinErr  -55	 /* drive volume already on-line at MountVol */
#define nsDrvErr	 -56	 /* no such drive (tried to mount a bad drive num) */
#define noMacDskErr  -57	 /* not a mac diskette (sig bytes are wrong) */
#define extFSErr	 -58	 /* volume in question belongs to an external fs */
#define fsRnErr 	 -59	 /* file system internal error: */
	 						 /*	during rename the old entry was deleted but could */
	 						 /*	 not be restored . . . */
#define badMDBErr	 -60	 /* bad master directory block */
#define wrPermErr	 -61	 /* write permissions error */

/* Font Manager Error Codes */

#define fontDecError 	-64	 /* error during font declaration */
#define fontNotDeclared -65	 /* font not declared */
#define fontSubErr	 	-66	 /* font substitution occured */

/* Disk, Serial Ports, Clock Specific Errors */

#define firstDskErr  -84
#define lastDskErr	 -64

#define noDriveErr	 -64	 /* drive not installed */
#define offLinErr	 -65	 /* r/w requested for an off-line drive */

#define noNybErr	 -66	 /* couldn't find 5 nybbles in 200 tries */
#define noAdrMkErr	 -67	 /* couldn't find valid addr mark */
#define dataVerErr	 -68	 /* read verify compare failed */
#define badCkSmErr	 -69	 /* addr mark checksum didn't check */
#define badBtSlpErr  -70	 /* bad addr mark bit slip nibbles */
#define noDtaMkErr	 -71	 /* couldn't find a data mark header */
#define badDCkSum	 -72	 /* bad data mark checksum */
#define badDBtSlp	 -73	 /* bad data mark bit slip nibbles */
#define wrUnderRun	 -74	 /* write underrun occurred */

#define cantStepErr  -75	 /* step handshake failed */
#define tk0BadErr	 -76	 /* track 0 detect doesn't change */
#define initIWMErr	 -77	 /* unable to initialize IWM */
#define twoSideErr	 -78	 /* tried to read 2nd side on a 1-sided drive */
#define spdAdjErr	 -79	 /* unable to correctly adjust disk speed */
#define seekErr 	 -80	 /* track number wrong on address mark */
#define sectNFErr	 -81	 /* sector number never found on a track */

#define fmt1Err 	 -82	 /* can't find sector 0 after track format */
#define fmt2Err 	 -83	 /* can't get enough sync */
#define verErr 		 -84	 /* track failed to verify */


#define clkRdErr	 -85	 /* unable to read same clock value twice */
#define clkWrErr	 -86	 /* time written did not verify */
#define prWrErr 	 -87	 /* parameter ram written didn't read-verify */
#define prInitErr	 -88	 /* InitUtil found the parameter ram uninitialized */

#define rcvrErr 	 -89	 /* SCC receiver error (framing, parity, OR) */
#define breakRecd	 -90	 /* Break received (SCC) */

/* AppleTalk error codes */

#define ddpSktErr	 -91	 /* error in soket number */
#define ddpLenErr	 -92	 /* data length too big */
#define noBridgeErr  -93	 /* no network bridge for non-local send */
#define lapProtErr	 -94	 /* error in attaching/detaching protocol */
#define excessCollsns -95	 /* excessive collisions on write */
#define portInUse	 -97	 /* driver Open error code (port is in use) */
#define portNotCf	 -98	 /* driver Open error code (parameter RAM not */
	 						 /* configured for this connection) */
#define memROZErr	 -99	 /* hard error in ROZ */

/* Scrap Manager error codes */
 
#define noScrapErr	 -100	 /* No scrap exists error */
#define noTypeErr	 -102	 /* No object of that type in scrap */

/* Storage allocator error codes */

#define memFullErr	 -108	 /* Not enough room in heap zone */
#define nilHandleErr -109	 /* Handle was NIL in HandleZone or other */
#define memWZErr	 -111	 /* WhichZone failed (applied to free block) */
#define memPurErr	 -112	 /* trying to purge a locked or non-purgeable block */

#define memAdrErr	 -110	 /* address was odd, or out of range */
#define memAZErr	 -113	 /* Address in zone check failed */
#define memPCErr	 -114	 /* Pointer Check failed */
#define memBCErr	 -115	 /* Block Check failed */
#define memSCErr	 -116	 /* Size Check failed */
#define memLockedErr -117	 /* trying to move a locked block (MoveHHi) */

/* New system error codes : */

#define dirNFErr 	 -120	 /* Directory not found */
#define tMWDOErr 	 -121	 /* No free WDCB available */
#define badMovErr 	 -122	 /* Move into offspring error */
#define wrgVolTypErr -123	 /* Wrong volume type error	 */
	 						 /* [operation not supported for MFS] */

/* Resource Manager error codes (other than I/O errors) */

#define resNotFound  -192	 /* Resource not found */
#define resFNotFound -193	 /* Resource file not found */
#define addResFailed -194	 /* AddResource failed */
#define addRefFailed -195	 /* AddReference failed */
#define rmvResFailed -196	 /* RmveResource failed */
#define rmvRefFailed -197	 /* RmveReference failed */
#define resAttrErr	 -198	 /* attribute inconsistent with operation */
#define mapReadErr	 -199	 /* map inconsistent with operation */

/* AppleTalk - NBP error codes */

#define nbpBuffOvr	 -1024	 /* Buffer overflow in LookupName */
#define nbpNoConfirm -1025	 /* Name not confirmed on ConfirmName */
#define nbpConfDiff  -1026	 /* Name confirmed at different socket */
#define nbpDuplicate -1027	 /* Duplicate name exists already */
#define nbpNotFound  -1028	 /* Name not found on remove */
#define nbpNISErr	 -1029	 /* Error trying to open the NIS */


/*______________________________________________________________ */

/* some miscellaneous result codes */

#define evtNotEnb1	 /* event not enabled at PostEvent */


/*  System Error Alert ID definitions.  These are just for reference because */
/*  one cannot intercept the calls and do anything programmatically... */

#define dsSysErr	 32767	/* general system error */
#define dsBusError	 1 		/* bus error */ 
#define dsAddressErr 2 		/* address error */
#define dsIllInstErr 3 		/* illegal instruction error */
#define dsZeroDivErr 4 		/* zero divide error */
#define dsChkErr	 5 		/* check trap error */
#define dsOvFlowErr  6 		/* overflow trap error */
#define dsPrivErr	 7 		/* privelege violation error */
#define dsTraceErr	 8 		/* trace mode error */
#define dsLineAErr	 9 		/* line 1010 trap error */
#define dsLineFErr	 10 	/* line 1111 trap error */
#define dsMiscErr	 11 	/* miscellaneous hardware exception error */
#define dsCoreErr	 12 	/* unimplemented core routine error */
#define dsIrqErr	 13 	/* uninstalled interrupt error */

#define dsIOCoreErr  14 	/* IO Core Error */
#define dsLoadErr	 15 	/* Segment Loader Error */
#define dsFPErr 	 16 	/* Floating point error */

#define dsNoPackErr  17 	/* package 0 not present */
#define dsNoPk1 	 18 	/* package 1 not present */
#define dsNoPk2 	 19 	/* package 2 not present */
#define dsNoPk3 	 20 	/* package 3 not present */
#define dsNoPk4 	 21 	/* package 4 not present */
#define dsNoPk5 	 22 	/* package 5 not present */
#define dsNoPk6 	 23 	/* package 6 not present */
#define dsNoPk7 	 24 	/* package 7 not present */

#define dsMemFullErr 25 	/* out of memory! */
#define dsBadLaunch  26 	/* can't launch file */

#define dsFSErr 	 27 	/* file system map has been trashed */
#define dsStknHeap	 28 	/* stack has moved into application heap */
#define dsReinsert	 30 	/* request user to reinsert off-line volume */
#define dsNotThe1	 31 	/* not the disk I wanted */
#define negZcbFreeErr 33 	/* ZcbFree has gone negative */
#define dsGreeting   40		/* welcome to Macintosh greeting     <C694> */
#define dsFinderErr  41		/* can't load the Finder error       <C694> */
#define menuPrgErr	 84 	/* happens when a menu is purged */



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


/*Color Quickdraw & Color Manager Errors */

#define cMatchErr       -150      /* Color2Index failed to find an index   <C773/02Feb87> DAF */
#define cTempMemErr     -151      /* failed to allocate memory for temporary structures  <C773/02Feb87> DAF */
#define cNoMemErr       -152      /* failed to allocate memory for structure  <C773/02Feb87> DAF */
#define cRangeErr       -153      /* range error on colorTable request     <C773/02Feb87> DAF */
#define cProtectErr     -154      /* colorTable entry protection violation  <C773/02Feb87> DAF */
#define cDevErr         -155      /* invalid type of graphics device        <C773/02Feb87> DAF */
#define cResErr         -156      /* invalid resolution for MakeITable      <C773/02Feb87> DAF */

/* errors for Color2Index/ITabMatch	 */

#define iTabPurgErr	-9
#define noColMatch	-10

/* errors for MakeITable */

#define qAllocErr	-11
#define tblAllocErr	-12
#define overRun		-13
#define noRoomErr	-14

/* errors for SetEntry */

#define seOutOfRange	-15
#define seProtErr		-16

#define i2CRangeErr	-17
#define gdBadDev	-18
#define reRangeErr	-19
#define seInvRequest -20
#define seNoMemErr	-21

/*more errors */

#define unitTblFullErr	-29	 	/* unit table has no more entries	<C206> */
#define dceExtErr		-30	 	/* dce extension error<C206> */
#define dsBadSlotInt    51      /* unserviceable slot interrupt      <C686> */
#define dsBadSANEopcode 81      /* bad opcode given to SANE Pack4    <C744> */

#define memROZWarn		-99 	/* soft error in ROZ	<C206> */
#define memROZError 	-99 	/* hard error in ROZ	<C206> */

#define volGoneErr		-124	/* Server volume has been disconnected. */
#define updPixMemErr	-125	/*insufficient memory to update a pixmap */

/*Menu Manager */

#define mBarNFnd		-126	/* system error code for MBDF not found	<C174> */
#define hMenuFindErr    -127    /* could not find HMenu's parent in MenuKey      <FJL 27Jan87> */

/*Sound Manager Error Returns  */

#define noHardware			-200
#define notEnoughHardware	-201
#define queueFull			-203
#define resProblem			-204
#define badChannel			-205
#define badFormat			-206


/*Slot Declaration ROM Manager Errors */

#define sdmJTInitErr        10       /*SDM Jump Table could not be initialized.           <C679> */
#define sdmInitErr          11       /*SDM could not be initialized.                      <C617> */
#define sdmSRTInitErr       12       /*Slot Resource Table could not be initialized.      <C617> */
#define sdmPRAMInitErr      13       /*Slot PRAM could not be initialized.                <C617> */
#define sdmPriInitErr       14       /*Cards could not be initialized.                    <C617> */
	
/*---The following errors may be generated during system Init. If they are, */
/*   they will be logged into the sInfo array and returned each time a call */
/*   to the slot manager is made (for the card wich generated the error). */

/* Errors specific to the start mgr. */
#define smSDMInitErr	-290	/*Error, SDM could not be initialized. */
#define smSRTInitErr	-291	/*Error, Slot Resource Table could not be initialized. */
#define smPRAMInitErr	-292	/*Error, Slot Resource Table could not be initialized. */
#define smPriInitErr	-293	/*Error, Cards could not be initialized. */

#define smEmptySlot		-300	/*No card in slot   	 */
#define smCRCFail 		-301	/*CRC check failed for declaration data */
#define smFormatErr 	-302	/*FHeader Format is not Apple's */
#define smRevisionErr	-303	/*Wrong revison level */
#define smNoDir			-304	/*Directory offset is Nil */	
#define smLWTstBad		-305	/*Long Word test field <> $5A932BC7. */
#define smNosInfoArray	-306	/*No sInfoArray. Memory Mgr error. */
#define smResrvErr		-307	/*Fatal reserved error. Resreved field <> 0. */
#define smUnExBusErr	-308	/*Unexpected BusError	 */
#define smBLFieldBad	-309	/*ByteLanes field was bad.<A329> */
#define smFHBlockRdErr	-310	/*Error occured during _sGetFHeader. */
#define smFHBlkDispErr	-311	/*Error occured during _sDisposePtr (Dispose of FHeader block). */
#define smDisposePErr	-312	/*_DisposePointer error */
#define smNoBoardsRsrc	-313	/*No Board sResource. */
#define smGetPRErr		-314	/*Error occured during _sGetPRAMRec (See SIMStatus). */
#define smNoBoardId		-315	/*No Board Id. */
#define smIntStatVErr	-316	/*The InitStatusV field was negative after primary or secondary init. */
#define smIntTblVErr	-317	/*An error occured while trying to initialize the Slot Resource Table. */
#define smNoJmpTbl      -318        /*SDM jump table could not be created.           <C679> */
#define smBadBoardId    -319        /*BoardId was wrong, re-init the PRAM record.    <C696> */
#define smBusErrTO      -320        /*BusError time out.                             <C795> */


/*---The following errors may be generated at any time after system Init and will not */
/*   be logged into the sInfo array. */

#define smBadRefId		-330	/*Reference Id not found in List */
#define smBadsList		-331	/*Bad sList: Id1 < Id2 < Id3 ...  format is not followed. */
#define smReservedErr	-332	/*Reserved field not zero	 */
#define smCodeRevErr	-333	/*Code revision is wrong */
#define smCPUEr			-334	/*Code revision is wrong */
#define smsPointerNil	-335	/*LPointer is nil {From sOffsetData.  */
								/*If this error occurs, check sInfo rec for more information. */
#define smNilsBlockErr	-336	/*Nil sBlock error {Dont allocate and try to use a nil sBlock} */
#define smSlotOOBErr	-337	/*Slot out of bounds error */
#define smSelOOBErr		-338	/*Selector out of bounds error */
#define smNewPErr		-339	/*_NewPtr error */
#define smBlkMoveErr	-340	/*_BlockMove error */
#define smCkStatusErr	-341	/*Status of slot = fail. */
#define smGetDrvrNamErr	-342	/*Error occured during _sGetDrvrName. */
#define smDisDrvrNamErr	-343	/*Error occured during _sDisDrvrName. */
#define smNoMoresRsrcs	-344	/*No more sResources */
#define smsGetDrvrErr	-345	/*Error occurred during _sGetDriver. */
#define smBadsPtrErr	-346	/*Bad pointer was passed to sCalcsPointer	<A329> */
#define smByteLanesErr	-347	/*NumByteLanes was determined to be zero.	<A329> */
#define smOffsetErr		-348	/*Offset was too big (temporary error, should be fixed)<A329> */
#define smNoGoodOpens	-349	/*No opens were successfull in the loop.	 */
#define smSRTOvrFlErr   -350    /*SRT over flow.                  <C671> */
#define smRecNotFnd     -351    /*Record not found in the SRT.           <C735> */


/*Device Manager Slot Support Error */

#define slotNErr-360	/* invalid slot # error */


/* ASP errors codes (XPP driver) */

#define aspBadVersNum   -1066           /* Server cannot support this ASP version
#define aspBufTooSmall  -1067           /* Buffer too small
#define aspNoMoreSess   -1068           /* No more sessions on server
#define aspNoServers    -1069           /* No servers at that address
#define aspParamErr     -1070           /* Parameter error
#define aspServerBusy   -1071           /* Server cannot open another session
#define aspSessClosed   -1072           /* Session closed
#define aspSizeErr      -1073           /* Command block too big
#define aspTooMany      -1074           /* Too many clients (server error)
#define aspNoAck        -1075           /* No ack on attention request (server err)

/* AFP errors codes (XPP driver)

#define afpAccessDenied     -5000			/* $EC78 */
#define afpAuthContinue     -5001			/* $EC77 */
#define afpBadUAM           -5002			/* $EC76 */
#define afpBadVersNum       -5003			/* $EC75 */
#define afpBitmapErr        -5004			/* $EC74 */
#define afpCantMove         -5005			/* $EC73 */
#define afpDenyConflict     -5006			/* $EC72 */
#define afpDirNotEmpty      -5007			/* $EC71 */
#define afpDiskFull         -5008			/* $EC70 */
#define afpEofError         -5009			/* $EC6F */
#define afpFileBusy         -5010			/* $EC6E */
#define afpFlatVol          -5011			/* $EC6D */
#define afpItemNotFound     -5012			/* $EC6C */
#define afpLockErr          -5013			/* $EC6B */
#define afpMiscErr          -5014			/* $EC6A */
#define afpNoMoreLocks      -5015			/* $EC69 */
#define afpNoServer         -5016			/* $EC68 */
#define afpObjectExists     -5017			/* $EC67 */
#define afpObjectNotFound   -5018			/* $EC66 */
#define afpParmErr          -5019			/* $EC65 */
#define afpRangeNotLocked   -5020			/* $EC64 */
#define afpRangeOverlap     -5021			/* $EC63 */
#define afpSessClosed       -5022			/* $EC62 */
#define afpUserNotAuth      -5023			/* $EC61 */
#define afpCallNotSupported -5024			/* $EC60 */
#define afpObjectTypeErr    -5025			/* $EC5F */
#define afpTooManyFilesOpen -5026			/* $EC5E */
#define afpServerGoingDown  -5027			/* $EC5D */
#define afpCantRename       -5028			/* $EC5C */
#define afpDirNotFound		-5029			/* $EC5B */
#define afpIconTypeError    -5030			/* $EC5A */

/*============================================================================
**
**   Sad Mac Equates (For NuMac).
**
**============================================================================ */
    
#define siInitSDTblErr      1    /*slot int dispatch table could not be initialized.  <C617> */
#define siInitVBLQsErr      2    /*VBLqueues for all slots could not be initialized.  <C617> */
#define siInitSPTblErr      3    /*slot priority table could not be initialized.      <C617> */

#define sdmInitErr          10   /*SDM could not be initialized.                      <C617> */
#define sdmSRTInitErr       11   /*Slot Resource Table could not be initialized.      <C617> */
#define sdmPRAMInitErr      12   /*Slot PRAM could not be initialized.                <C617> */
#define sdmPriInitErr       13   /*Cards could not be initialized.                    <C617> */


#endif
#endif

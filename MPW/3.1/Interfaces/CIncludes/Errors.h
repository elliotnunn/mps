/************************************************************

Created: Monday, September 18, 1989 at 4:47 PM
	Errors.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __ERRORS__
#define __ERRORS__

#define qErr -1 				/*queue element not found during deletion*/
#define vTypErr -2				/*invalid queue element*/
#define corErr -3				/*core routine number out of range*/
#define unimpErr -4 			/*unimplemented core routine*/
#define seNoDB -8				/*no debugger installed to handle debugger command*/
#define controlErr -17			/*I/O System Errors*/
#define statusErr -18			/*I/O System Errors*/
#define readErr -19 			/*I/O System Errors*/
#define writErr -20 			/*I/O System Errors*/
#define badUnitErr -21			/*I/O System Errors*/
#define unitEmptyErr -22		/*I/O System Errors*/
#define openErr -23 			/*I/O System Errors*/
#define closErr -24 			/*I/O System Errors*/
#define dRemovErr -25			/*tried to remove an open driver*/
#define dInstErr -26			/*DrvrInstall couldn't find driver in resources */
#define abortErr -27			/*IO call aborted by KillIO*/
#define iIOAbortErr -27 		/*IO abort error (Printing Manager)*/
#define notOpenErr -28			/*Couldn't rd/wr/ctl/sts cause driver not opened*/
#define dirFulErr -33			/*Directory full*/
#define dskFulErr -34			/*disk full*/
#define nsvErr -35				/*no such volume*/
#define ioErr -36				/*I/O error (bummers)*/
#define bdNamErr -37			/*there may be no bad names in the final system!*/
#define fnOpnErr -38			/*File not open*/
#define eofErr -39				/*End of file*/
#define posErr -40				/*tried to position to before start of file (r/w)*/
#define mFulErr -41 			/*memory full (open) or file won't fit (load)*/
#define tmfoErr -42 			/*too many files open*/
#define fnfErr -43				/*File not found*/
#define wPrErr -44				/*diskette is write protected.*/
#define fLckdErr -45			/*file is locked*/
#define vLckdErr -46			/*volume is locked*/
#define fBsyErr -47 			/*File is busy (delete)*/
#define dupFNErr -48			/*duplicate filename (rename)*/
#define opWrErr -49 			/*file already open with with write permission*/
#define paramErr -50			/*error in user parameter list*/
#define rfNumErr -51			/*refnum error*/
#define gfpErr -52				/*get file position error*/
#define volOffLinErr -53		/*volume not on line error (was Ejected)*/
#define permErr -54 			/*permissions error (on file open)*/
#define pixMapTooDeepErr -148
#define volOnLinErr -55 		/*drive volume already on-line at MountVol*/
#define nsDrvErr -56			/*no such drive (tried to mount a bad drive num)*/
#define noMacDskErr -57 		/*not a mac diskette (sig bytes are wrong)*/
#define extFSErr -58			/*volume in question belongs to an external fs*/
#define fsRnErr -59 			/*file system internal error:during rename the old entry was deleted but could not be restored.*/
#define badMDBErr -60			/*bad master directory block*/
#define wrPermErr -61			/*write permissions error*/
#define fontDecError -64		/*error during font declaration*/
#define lastDskErr -64			/*I/O System Errors*/
#define noDriveErr -64			/*drive not installed*/
#define offLinErr -65			/*r/w requested for an off-line drive*/
#define fontNotDeclared -65 	/*font not declared*/
#define noNybErr -66			/*couldn't find 5 nybbles in 200 tries*/
#define fontSubErr -66			/*font substitution occured*/
#define noAdrMkErr -67			/*couldn't find valid addr mark*/
#define dataVerErr -68			/*read verify compare failed*/
#define badCksmErr -69			/*addr mark checksum didn't check*/
#define badBtSlpErr -70 		/*bad addr mark bit slip nibbles*/
#define noDtaMkErr -71			/*couldn't find a data mark header*/
#define badDCksum -72			/*bad data mark checksum*/
#define badDBtSlp -73			/*bad data mark bit slip nibbles*/
#define wrUnderrun -74			/*write underrun occurred*/
#define cantStepErr -75 		/*step handshake failed*/
#define tk0BadErr -76			/*track 0 detect doesn't change*/
#define initIWMErr -77			/*unable to initialize IWM*/
#define twoSideErr -78			/*tried to read 2nd side on a 1-sided drive*/
#define spdAdjErr -79			/*unable to correctly adjust disk speed*/
#define seekErr -80 			/*track number wrong on address mark*/
#define sectNFErr -81			/*sector number never found on a track*/
#define fmt1Err -82 			/*can't find sector 0 after track format*/
#define fmt2Err -83 			/*can't get enough sync*/
#define verErr -84				/*track failed to verify*/
#define firstDskErr -84 		/*I/O System Errors*/
#define clkRdErr -85			/*unable to read same clock value twice*/
#define clkWrErr -86			/*time written did not verify*/
#define prWrErr -87 			/*parameter ram written didn't read-verify*/
#define prInitErr -88			/*InitUtil found the parameter ram uninitialized*/
#define rcvrErr -89 			/*SCC receiver error (framing; parity; OR)*/
#define breakRecd -90			/*Break received (SCC)*/
#define ddpSktErr -91			/*error in soket number*/
#define ddpLenErr -92			/*data length too big*/
#define noBridgeErr -93 		/*no network bridge for non-local send*/
#define lapProtErr -94			/*error in attaching/detaching protocol*/
#define excessCollsns -95		/*excessive collisions on write*/
#define portInUse -97			/*driver Open error code (port is in use)*/
#define portNotCf -98			/*driver Open error code (parameter RAM not configured for this connection)*/
#define memROZErr -99			/*hard error in ROZ*/
#define noScrapErr -100 		/*No scrap exists error*/
#define noTypeErr -102			/*No object of that type in scrap*/
#define memFullErr -108 		/*Not enough room in heap zone*/
#define nilHandleErr -109		/*Master Pointer was NIL in HandleZone or other*/
#define memAdrErr -110			/*address was odd; or out of range*/
#define memWZErr -111			/*WhichZone failed (applied to free block)*/
#define memPurErr -112			/*trying to purge a locked or non-purgeable block*/
#define memAZErr -113			/*Address in zone check failed*/
#define memPCErr -114			/*Pointer Check failed*/
#define memBCErr -115			/*Block Check failed*/
#define memSCErr -116			/*Size Check failed*/
#define memLockedErr -117		/*trying to move a locked block (MoveHHi)*/
#define dirNFErr -120			/*Directory not found*/
#define tmwdoErr -121			/*No free WDCB available*/
#define badMovErr -122			/*Move into offspring error*/
#define wrgVolTypErr -123		/*Wrong volume type error [operation not supported for MFS]*/
#define volGoneErr -124 		/*Server volume has been disconnected.*/
#define fsDSIntErr -127 		/*Internal file system error*/
#define resNotFound -192		/*Resource not found*/
#define resFNotFound -193		/*Resource file not found*/
#define addResFailed -194		/*AddResource failed*/
#define addRefFailed -195		/*AddReference failed*/
#define rmvResFailed -196		/*RmveResource failed*/
#define rmvRefFailed -197		/*RmveReference failed*/
#define resAttrErr -198 		/*attribute inconsistent with operation*/
#define mapReadErr -199 		/*map inconsistent with operation*/
#define userBreak -490			/*user debugger break*/
#define strUserBreak -491		/*user debugger break; display string on stack*/
#define exUserBreak -492		/*user debugger break; execute debugger commands on stack*/
#define nbpBuffOvr -1024		/*Buffer overflow in LookupName*/
#define nbpNoConfirm -1025
#define nbpConfDiff -1026		/*Name confirmed at different socket*/
#define nbpDuplicate -1027		/*Duplicate name exists already*/
#define nbpNotFound -1028		/*Name not found on remove*/
#define nbpNISErr -1029 		/*Error trying to open the NIS*/
#define aspBadVersNum -1066 	/*Server cannot support this ASP version*/
#define aspBufTooSmall -1067	/*Buffer too small*/
#define aspNoMoreSess -1068 	/*No more sessions on server*/
#define aspNoServers -1069		/*No servers at that address*/
#define aspParamErr -1070		/*Parameter error*/
#define aspServerBusy -1071 	/*Server cannot open another session*/
#define aspSessClosed -1072 	/*Session closed*/
#define aspSizeErr -1073		/*Command block too big*/
#define aspTooMany -1074		/*Too many clients (server error)*/
#define aspNoAck -1075			/*No ack on attention request (server err)*/
#define reqFailed -1096
#define tooManyReqs -1097
#define tooManySkts -1098
#define badATPSkt -1099
#define badBuffNum -1100
#define noRelErr -1101
#define cbNotFound -1102
#define noSendResp -1103
#define noDataArea -1104
#define reqAborted -1105
#define buf2SmallErr -3101
#define noMPPErr -3102
#define ckSumErr -3103
#define extractErr -3104
#define readQErr -3105
#define atpLenErr -3106
#define atpBadRsp -3107
#define recNotFnd -3108
#define sktClosedErr -3109
#define afpAccessDenied -5000
#define afpAuthContinue -5001
#define afpBadUAM -5002
#define afpBadVersNum -5003
#define afpBitmapErr -5004
#define afpCantMove -5005
#define afpDenyConflict -5006
#define afpDirNotEmpty -5007
#define afpDiskFull -5008
#define afpEofError -5009
#define afpFileBusy -5010
#define afpFlatVol -5011
#define afpItemNotFound -5012
#define memROZWarn -99			/*soft error in ROZ*/
#define afpLockErr -5013
#define afpMiscErr -5014
#define afpNoMoreLocks -5015
#define afpNoServer -5016
#define afpObjectExists -5017
#define afpObjectNotFound -5018
#define afpParmErr -5019
#define afpRangeNotLocked -5020
#define afpRangeOverlap -5021
#define afpSessClosed -5022
#define afpUserNotAuth -5023
#define afpCallNotSupported -5024
#define afpObjectTypeErr -5025
#define afpTooManyFilesOpen -5026
#define afpServerGoingDown -5027
#define afpCantRename -5028
#define afpDirNotFound -5029
#define afpIconTypeError -5030
#define afpVolLocked -5031		/*Volume is Read-Only*/
#define afpObjectLocked -5032	/*Object is M/R/D/W inhibited*/
#define envNotPresent -5500 	/*returned by glue.*/
#define envBadVers -5501		/*Version non-positive*/
#define envVersTooBig -5502 	/*Version bigger than call can handle*/
#define evtNotEnb 1 			/*event not enabled at PostEvent*/
#define dsSysErr 32767			/*general system error*/
#define dsBusError 1			/*bus error */
#define dsAddressErr 2			/*address error*/
#define dsIllInstErr 3			/*illegal instruction error*/
#define dsZeroDivErr 4			/*zero divide error*/
#define dsChkErr 5				/*check trap error*/
#define dsOvflowErr 6			/*overflow trap error*/
#define dsPrivErr 7 			/*privilege violation error*/
#define dsTraceErr 8			/*trace mode error*/
#define dsLineAErr 9			/*line 1010 trap error*/
#define dsLineFErr 10			/*line 1111 trap error*/
#define dsMiscErr 11			/*miscellaneous hardware exception error*/
#define dsCoreErr 12			/*unimplemented core routine error*/
#define dsIrqErr 13 			/*uninstalled interrupt error*/
#define dsIOCoreErr 14			/*IO Core Error*/
#define dsLoadErr 15			/*Segment Loader Error*/
#define dsFPErr 16				/*Floating point error*/
#define dsNoPackErr 17			/*package 0 not present*/
#define dsNoPk1 18				/*package 1 not present*/
#define dsNoPk2 19				/*package 2 not present*/
#define dsNoPk3 20				/*package 3 not present*/
#define dsNoPk4 21				/*package 4 not present*/
#define dsNoPk5 22				/*package 5 not present*/
#define dsNoPk6 23				/*package 6 not present*/
#define dsNoPk7 24				/*package 7 not present*/
#define dsMemFullErr 25 		/*out of memory!*/
#define dsBadLaunch 26			/*can't launch file*/
#define dsFSErr 27				/*file system map has been trashed*/
#define dsStknHeap 28			/*stack has moved into application heap*/
#define dsReinsert 30			/*request user to reinsert off-line volume*/
#define dsNotThe1 31			/*not the disk I wanted*/
#define negZcbFreeErr 33		/*ZcbFree has gone negative*/
#define dsGreeting 40			/*welcome to Macintosh greeting*/
#define dsFinderErr 41			/*can't load the Finder error*/
#define shutDownAlert 42		/*handled like a shutdown error*/
#define menuPrgErr 84			/*happens when a menu is purged*/
#define swOverrunErr 1			/*serial driver error masks*/
#define parityErr 16			/*serial driver error masks*/
#define hwOverrunErr 32 		/*serial driver error masks*/
#define framingErr 64			/*serial driver error masks*/
#define cMatchErr -150			/*Color2Index failed to find an index*/
#define cTempMemErr -151		/*failed to allocate memory for temporary structures*/
#define cNoMemErr -152			/*failed to allocate memory for structure*/
#define cRangeErr -153			/*range error on colorTable request*/
#define cProtectErr -154		/*colorTable entry protection violation*/
#define cDevErr -155			/*invalid type of graphics device*/
#define cResErr -156			/*invalid resolution for MakeITable*/
#define unitTblFullErr -29		/*unit table has no more entries*/
#define dceExtErr -30			/*dce extension error*/
#define dsBadSlotInt 51 		/*unserviceable slot interrupt*/
#define dsBadSANEopcode 81		/*bad opcode given to SANE Pack4*/
#define dsNoPatch 98			/*Can't patch for particular Model Mac*/
#define dsBadPatch 99			/*Can't load patch resource*/
#define updPixMemErr -125		/*insufficient memory to update a pixmap*/
#define mBarNFnd -126			/*system error code for MBDF not found*/
#define hMenuFindErr -127		/*could not find HMenu's parent in MenuKey*/
#define noHardware -200 		/*Sound Manager Error Returns*/
#define notEnoughHardware -201	/*Sound Manager Error Returns*/
#define queueFull -203			/*Sound Manager Error Returns*/
#define resProblem -204 		/*Sound Manager Error Returns*/
#define badChannel -205 		/*Sound Manager Error Returns*/
#define badFormat -206			/*Sound Manager Error Returns*/
#define smSDMInitErr -290		/*Error; SDM could not be initialized.*/
#define smSRTInitErr -291		/*Error; Slot Resource Table could not be initialized.*/
#define smPRAMInitErr -292		/*Error; Slot Resource Table could not be initialized.*/
#define smPriInitErr -293		/*Error; Cards could not be initialized.*/
#define nmTypErr -299
#define smEmptySlot -300		/*No card in slot*/
#define smCRCFail -301			/*CRC check failed for declaration data*/
#define smFormatErr -302		/*FHeader Format is not Apple's*/
#define smRevisionErr -303		/*Wrong revison level*/
#define smNoDir -304			/*Directory offset is Nil */
#define smLWTstBad -305 		/*Long Word test field <> $5A932BC7.*/
#define smNosInfoArray -306 	/*No sInfoArray. Memory Mgr error.*/
#define smResrvErr -307 		/*Fatal reserved error. Resreved field <> 0.*/
#define smUnExBusErr -308		/*Unexpected BusError*/
#define smBLFieldBad -309		/*ByteLanes field was bad.*/
#define smFHBlockRdErr -310 	/*Error occured during _sGetFHeader.*/
#define smDisposePErr -312		/*_DisposePointer error*/
#define smNoBoardsRsrc -313 	/*No Board sResource.*/
#define smGetPRErr -314 		/*Error occured during _sGetPRAMRec (See SIMStatus).*/
#define smNoBoardId -315		/*No Board Id.*/
#define smInitStatVErr -316 	/*The InitStatusV field was negative after primary or secondary init.*/
#define smInitTblErr -317		/*An error occured while trying to initialize the Slot Resource Table.*/
#define smNoJmpTbl -318 		/*SDM jump table could not be created.*/
#define smBadBoardId -319		/*BoardId was wrong; re-init the PRAM record.*/
#define smBusErrTO -320 		/*BusError time out.*/
#define smBadRefId -330 		/*Reference Id not found in List*/
#define smBadsList -331 		/*Bad sList: Id1 < Id2 < Id3 ...format is not followed.*/
#define smReservedErr -332		/*Reserved field not zero*/
#define smCodeRevErr -333		/*Code revision is wrong*/
#define smCPUErr -334			/*Code revision is wrong*/
#define smsPointerNil -335		/*LPointer is nil From sOffsetData. If this error occurs; check sInfo rec for more information.*/
#define smNilsBlockErr -336 	/*Nil sBlock error (Dont allocate and try to use a nil sBlock)*/
#define smSlotOOBErr -337		/*Slot out of bounds error*/
#define smSelOOBErr -338		/*Selector out of bounds error*/
#define smNewPErr -339			/*_NewPtr error*/
#define smBlkMoveErr -340		/*_BlockMove error*/
#define smCkStatusErr -341		/*Status of slot = fail.*/
#define smGetDrvrNamErr -342	/*Error occured during _sGetDrvrName.*/
#define smDisDrvrNamErr -343	/*Error occured during _sDisDrvrName.*/
#define smNoMoresRsrcs -344 	/*No more sResources*/
#define smsGetDrvrErr -345		/*Error occurred during _sGetDriver.*/
#define smBadsPtrErr -346		/*Bad pointer was passed to sCalcsPointer*/
#define smByteLanesErr -347 	/*NumByteLanes was determined to be zero.*/
#define smOffsetErr -348		/*Offset was too big (temporary error*/
#define smNoGoodOpens -349		/*No opens were successfull in the loop.*/
#define smSRTOvrFlErr -350		/*SRT over flow.*/
#define smRecNotFnd -351		/*Record not found in the SRT.*/
#define slotNumErr -360 		/*invalid slot # error*/
#define gcrOnMFMErr -400		/*gcr format on high density media error*/
#define rgnTooBigErr -500
#define teScrapSizeErr -501 	/*scrap item too big for text edit record*/
#define hwParamErr -502 		/*bad selector for _HWPriv*/

/*	The following errors are for primary or secondary init code.  The errors are logged in the
vendor status field of the sInfo record.  Normally the vendor error is not Apple's concern,
but a special error is needed to patch secondary inits.

 */

#define svTempDisable -32768	/*Temporarily disable card but run primary init.*/
#define svDisabled -32640		/*Reserve range -32640 to -32768 for Apple temp disables.*/
#define siInitSDTblErr 1		/*slot int dispatch table could not be initialized.*/
#define siInitVBLQsErr 2		/*VBLqueues for all slots could not be initialized.*/
#define siInitSPTblErr 3		/*slot priority table could not be initialized.*/
#define sdmJTInitErr 10 		/*SDM Jump Table could not be initialized.*/
#define sdmInitErr 11			/*SDM could not be initialized.*/
#define sdmSRTInitErr 12		/*Slot Resource Table could not be initialized.*/
#define sdmPRAMInitErr 13		/*Slot PRAM could not be initialized.*/
#define sdmPriInitErr 14		/*Cards could not be initialized.*/
#define dsMBarNFnd 85			/*Menu Manager Errors*/
#define dsHMenuFindErr 86		/*Menu Manager Errors*/

extern short MacOSErr;

#ifdef __cplusplus
extern "C" {
#endif
pascal void SysError(short errorCode)
	= {0x301F,0xA9C9};
#ifdef __cplusplus
}
#endif

#endif

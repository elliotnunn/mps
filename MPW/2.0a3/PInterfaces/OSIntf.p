{
  File: OSIntf.p

 Version: 2.0a2.2

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved

 modifications:
	10/9/86 - nsj added Apple Desktop Bus stuff
				  changed all Byte type record fields to SignedByte
	10/13/86 - added Slot Declaration ROM Manager, removed InitVBLQueue
	13feb87	KLH	Inside Mac wrong! tmCount is long.
	
}


UNIT OSIntf;

  INTERFACE

	USES {$U MemTypes.p} MemTypes,
	  {$U QuickDraw.p} QuickDraw;

	CONST
	  {for Event Manager}

	  everyEvent = - 1;
	  NullEvent = 0;
	  mouseDown = 1;
	  mouseUp = 2;
	  keyDown = 3;
	  keyUp = 4;
	  autoKey = 5;
	  updateEvt = 6;
	  diskEvt = 7;
	  activateEvt = 8;
	  networkEvt = 10;
	  driverEvt = 11;
	  app1Evt = 12;
	  app2Evt = 13;
	  app3Evt = 14;
	  app4Evt = 15;

	  { event mask equates }
	  mDownMask = 2;
	  mUpMask = 4;
	  keyDownMask = 8;
	  keyUpMask = 16;
	  autoKeyMask = 32;
	  updateMask = 64;
	  diskMask = 128;
	  activMask = 256;
	  networkMask = 1024;
	  driverMask = 2048;
	  app1Mask = 4096;
	  app2Mask = 8192;
	  app3Mask = 16384;
	  app4Mask = - 32768;

	  {to decipher event message for keyDown events}
	  charCodeMask = $000000FF;
	  keyCodeMask = $0000FF00;

	  { modifiers }
	  optionKey = 2048; { Bit 3 of high byte }
	  alphaLock = 1024; { Bit 2 }
	  shiftKey = 512; 	{ Bit 1 }
	  cmdKey = 256; 	{ Bit 0 }
	  btnState = 128; 	{ Bit 7 of low byte is mouse button state }

	  activeFlag = 1; 	{ bit 0 of modifiers for activate event }

	  {error for PostEvent}
	  evtNotEnb = 1;

	  {for Memory Manager}
	  memFullErr = - 108; 	{ Not enough room in heap zone }
	  nilHandleErr = - 109; { Master Pointer was NIL in HandleZone or other }
	  memWZErr = - 111; 	{ WhichZone failed (applied to free block) }
	  memPurErr = - 112; 	{ trying to purge a locked or non-purgeable block }
	  memLockedErr = - 117; { Block is locked }
	  noErr = 0; 			{ All is well }

	  {file system error codes}
	  dirFulErr = - 33; { Directory full }
	  dskFulErr = - 34; { disk full }
	  nsVErr = - 35; 	{ no such volume }
	  ioErr = - 36; 	{ I/O error }
	  bdNamErr = - 37; 	{ bad name }
	  fnOpnErr = - 38; 	{ File not open }
	  eofErr = - 39; 	{ End of file }
	  posErr = - 40; 	{ tried to position to before start of file (r/w) }
	  mFulErr = - 41; 	{ memory full(open) or file won't fit (load) }
	  tmFOErr = - 42; 	{ too many files open }
	  fnFErr = - 43; 	{ File not found }

	  wPrErr = - 44; 	{ diskette is write protected }
	  fLckdErr = - 45; 	{ file is locked }
	  vLckdErr = - 46; 	{ volume is locked }
	  fbsyErr = - 47; 	{ File is busy (delete) }
	  dupFNErr = - 48;	{ duplicate filename (rename) }
	  opWrErr = - 49; 	{ file already open with with write permission }
	  paramErr = - 50; 	{ error in user parameter list }
	  rfNumErr = - 51; 	{ refnum error }
	  gfpErr = - 52; 	{ get file position error }
	  volOffLinErr = - 53; { volume not on line error (was Ejected) }
	  permErr = - 54; 	{ permissions error (on file open) }
	  volOnLinErr = - 55; { drive volume already on-line at MountVol }
	  nsDrvErr = - 56; 	{ no such drive (tried to mount a bad drive num) }
	  noMacDskErr = - 57; { not a mac diskette (sig bytes are wrong) }
	  extFSErr = - 58; 	{ volume in question belongs to an external fs }
	  fsrnErr = - 59; 	{ file system rename error }
	  badMDBErr = - 60; { bad master directory block }
	  wrPermErr = - 61; { write permissions error }

	  lastDskErr = - 64; { last in a range of disk errors }
	  noDriveErr = - 64; { drive not installed }
	  offLinErr = - 65; { r/w requested for an off-line drive }
	  noNybErr = - 66; 	{ couldn't find 5 nybbles in 200 tries }
	  noAdrMkErr = - 67; { couldn't find valid addr mark }
	  dataVerErr = - 68; { read verify compare failed }
	  badCkSmErr = - 69; { addr mark checksum didn't check }
	  badBtSlpErr = - 70; { bad addr mark bit slip nibbles }
	  noDtaMkErr = - 71; { couldn't find a data mark header }
	  badDCkSum = - 72; { bad data mark checksum }
	  badDBtSlp = - 73; { bad data mark bit slip nibbles }
	  wrUnderRun = - 74; { write underrun occurred }
	  cantStepErr = - 75; { step handshake failed }
	  tk0BadErr = - 76; { track 0 detect doesn't change }
	  initIWMErr = - 77; { unable to initialize IWM }
	  twoSideErr = - 78; { tried to read 2nd side on a 1-sided drive }
	  spdAdjErr = - 79; { unable to correctly adjust disk speed }
	  seekErr = - 80; 	{ track number wrong on address mark }
	  sectNFErr = - 81; { sector number never found on a track }
	  firstDskErr = - 84; { first in a range of disk errors }

	  dirNFErr = - 120; { Directory not found }
	  tmWDOErr = - 121; { No free WDCB available }
	  badMovErr = - 122; { Move into offspring error }
	  wrgVolTypErr = - 123; { Wrong volume type error - operation not supported
							 for MFS}
	  fsdsIntErr = - 127; { Internal file system error }

	  maxSize = $800000; { Max data block size is 8 megabytes }

	  {finder constants}
	  fOnDesk = 1;
	  fHasBundle = 8192;
	  fInvisible = 16384;
	  fTrash = - 3;
	  fDesktop = - 2;
	  fDisk = 0;

	  {io constants}

	  {ioPosMode values}
	  fsAtMark = 0;
	  fsFromStart = 1;
	  fsFromLEOF = 2;
	  fsFromMark = 3;
	  rdVerify = 64;

	  {ioPermission values}
	  fsCurPerm = 0;
	  fsRdPerm = 1;
	  fsWrPerm = 2;
	  fsRdWrPerm = 3;
	  fsRdWrShPerm = 4;

	  {refNums from the serial ports}
	  ainRefNum = - 6; 	{serial port A input}
	  aoutRefNum = - 7; {serial port A output}
	  binRefNum = - 8; 	{serial port B input}
	  boutRefNum = - 9; {serial port B output}

	  {baud rate constants}
	  baud300 = 380;
	  baud600 = 189;
	  baud1200 = 94;
	  baud1800 = 62;
	  baud2400 = 46;
	  baud3600 = 30;
	  baud4800 = 22;
	  baud7200 = 14;
	  baud9600 = 10;
	  baud19200 = 4;
	  baud57600 = 0;

	  {SCC channel configuration word}
	  {driver reset information masks}
	  stop10 = 16384;
	  stop15 = - 32768;
	  stop20 = - 16384;
	  noParity = 0;
	  oddParity = 4096;
	  evenParity = 12288;
	  data5 = 0;
	  data6 = 2048;
	  data7 = 1024;
	  data8 = 3072;

	  {serial driver error masks}
	  swOverrunErr = 1;
	  parityErr = 16;
	  hwOverrunErr = 32;
	  framingErr = 64;

	  {serial driver result codes}

	  openErr = - 23; 	{attempt to open Serial driver failed}
	  portConf = - 98; 	{port not configured}
	  portBusy = - 99; 	{port in use}

	  {serial Port configuration usage constants for Config field of SysParmType}
	  useFree = 0;
	  useATalk = 1;
	  useAsync = 2;

	  {serial driver message constant}
	  xOffWasSent = $80;

	  {for application parameter}
	  {constants for message returned by the finder on launch}
	  appOpen = 0;
	  appPrint = 1;

	  {for sound driver}
	  swmode = - 1;
	  ftmode = 1;
	  ffmode = 0;

	  {Desk Accessories - Message Definitions (in CSCode of Control Call)}

	  accEvent = 64; 	{event message from SystemEvent}
	  accRun = 65; 		{run message from SystemTask}
	  accCursor = 66; 	{cursor message from SystemTask}
	  accMenu = 67; 	{menu message from SystemMenu}
	  accUndo = 68; 	{undo message from SystemEdit}
	  accCut = 70; 		{cut message from SystemEdit}
	  accCopy = 71; 	{copy message from SystemEdit}
	  accPaste = 72; 	{paste message from SystemEdit}
	  accClear = 73; 	{clear message from SystemEdit}

	  goodbye = - 1; {goodbye message}

	  {for "machine" parameter of Environs}
	  macXLMachine = 0;
	  macMachine = 1;

	  ioDirFlg = 3; 	{ IF BitTst( myParamBlk^.ioFlAttrib, ioDirFlg) THEN … }
	  ioDirMask = $10; 	{ IF BitAnd( myParamBlk^.ioFlAttrib, ioDirMask) = ioDirMask
							THEN … }
	  fsrtParID = 1; 	{ DirID of parent's root }
	  fsrtDirID = 2; 	{ Root DirID }

	  { device manager - Chooser message values}

	  newSelMsg = 12; 	{ a new selection has been made}
	  fillListMsg = 13; { fill the list with choices to be made}
	  getSelMsg = 14; 	{ mark one or more choices as selcted}
	  selectMsg = 15; 	{ a choice has actually been made}
	  deselectMsg = 16; { a choice has been canceled}
	  terminateMsg = 17; { lets device package clean up}
	  buttonMsg = 19; 	{ a button has been clicked}

	  {caller value}

	  chooserID = 1; { caller value for the Chooser}

	  {result types for RelString Call}

	  sortsBefore = - 1;{ first string < second string}
	  sortsEqual = 0; 	{ first string = second string}
	  sortsAfter = 1; 	{ first string > second string}

{********** NEW CODE FOR OSINTF.P **********}

{ Slot Declaration ROM Manager }

{ Errors }

{---The following errors may be generated during system Init. If they are,
    they will be logged into the sInfo array and returned each time a call
    to the slot manager is made (for the card wich generated the error). }

{ Errors specific to the start mgr.}
smSDMInitErr	=	-290;		{ Error, SDM could not be initialized.}
smSRTInitErr	=	-291;		{ Error, Slot Resource Table could not be initialized.}
smPRAMInitErr	=	-292;		{ Error, Slot Resource Table could not be initialized.}
smPriInitErr	=	-293;		{ Error, Cards could not be initialized.}

smEmptySlot		=	-300;		{ No card in slot}   							
smCRCFail 		= 	-301;		{ CRC check failed for declaration data}		
smFormatErr 	= 	-302;		{ FHeader Format is not Apple's}				
smRevisionErr	= 	-303;		{ Wrong revison level}						
smNoDir			= 	-304;		{ Directory offset is Nil}					
smLWTstBad		= 	-305;		{ Long Word test field <> $5A932BC7.}		
smNosInfoArray	= 	-306;		{ No sInfoArray. Memory Mgr error.}		
smResrvErr		= 	-307;		{ Fatal reserved error. Resreved field <> 0.}
smUnExBusErr	= 	-308;		{ Unexpected BusError}	
smBLFieldBad	=	-309;		{ ByteLane field is bad.}
smFHBlockRdErr	=	-310;		{ Error occured during _sGetFHeader.}
smFHBlkDispErr	=	-311;		{ Error occured during _sDisposePtr (Dispose of FHeader block).}
smDisposePErr	=	-312;		{ _DisposePointer error}
smNoBoardsRsrc	=	-313;		{ No Board sResource.}
smGetPRErr		=	-314;		{ Error occured during _sGetPRAMRec (See SIMStatus).}
smNoBoardId		=	-315;		{ No Board Id.}
smIntStatVErr	=	-316;		{ The InitStatusV field was negative after primary or secondary init.}
smIntTblVErr	=	-317;		{ An error occured while trying to initialize the Slot Resource Table.}

{---The following errors may be generated at any time after system Init and will not
;   be logged into the sInfo array.

smBadRefId		= 	-330;		{ Reference Id not found in List}				
smBadsList		=	-331;		{ Bad sList: Id1 < Id2 < Id3 ...  format is not followed.}
smReservedErr	= 	-332;		{ Reserved field not zero}					
smCodeRevErr	= 	-333;		{ Code revision is wrong}						
smCPUErr		= 	-334;		{ Code revision is wrong}
smsPointerNil	=	-335;		{ LPointer is nil - From sOffsetData. If this error occurs, check sInfo rec for more information.}
smNilsBlockErr	=	-336;		{ Nil sBlock error - Dont allocate and try to use a nil sBlock}
smSlotOOBErr	=	-337;		{ Slot out of bounds error}
smSelOOBErr		=	-338;		{ Selector out of bounds error}
smNewPErr		=	-339;		{ _NewPtr error}
smBlkMoveErr	=	-340;		{ _BlockMove error}
smCkStatusErr	=	-341;		{ Status of slot = fail.}
smGetDrvrNamErr	=	-342;		{ Error occured during _sGetDrvrName.}
smDisDrvrNamErr	=	-343;		{ Error occured during _sDisDrvrName.}
smNoMoresRsrcs	=	-344;		{ No more sResources}
smsGetDrvrErr	=	-345;		{ Error occurred during _sGetDriver.}
smBadsPtrErr	=	-346;		{ Bad pointer was passed to sCalcsPointer}
smByteLanesErr	=	-347;		{ NumByteLanes was determined to be zero.}
smOffsetErr		=	-348;		{ Offset was too big (temporary error, should be fixed)}
smNoGoodOpens	=	-349;		{ No opens were successfull in the loop.}
 
{ StatusFlags constants }

fCardIsChanged	=		1;		{ Card is Changed field in StatusFlags field of sInfoArray}

fCkForSame		=		0;		{ For SearchSRT. Flag to check for SAME sResource in the table. }
fCkForNext		=		1;		{ For SearchSRT. Flag to check for NEXT sResource in the table. }

fWarmStart		=		2;		{ If this bit is set then warm start, else cold start.}



{ State constants } 

stateNil		=		0;			{ State	:Nil}
stateSDMInit	=		1;			{		:Slot declaration manager Init}
statePRAMInit	=		2;			{		:sPRAM record init}
statePInit		=		3;			{		:Primary init}
stateSInit		=		4;			{		:Secondary init}


{  Sad Mac Equates (For NuMac). }
    
siInitSDTblErr      =     1;    { slot int dispatch table could not be initialized.  <C617> }
siInitVBLQsErr      =     2;    { VBLqueues for all slots could not be initialized.  <C617> }
siInitSPTblErr      =     3;    { slot priority table could not be initialized.      <C617> }

sdmInitErr          =     10;   { SDM could not be initialized.                      <C617> }
sdmSRTInitErr       =     11;   { Slot Resource Table could not be initialized.      <C617> }
sdmPRAMInitErr      =     12;   { Slot PRAM could not be initialized.                <C617> }
sdmPriInitErr       =     13;   { Cards could not be initialized.                    <C617> }
	



TYPE
	  {for Event Manager}
	  EventRecord = RECORD
					  what: INTEGER;
					  message: LONGINT;
					  when: LONGINT;
					  where: Point;
					  modifiers: INTEGER;
					END;

	  Zone = RECORD
			   BkLim: Ptr;
			   PurgePtr: Ptr;
			   HFstFree: Ptr;
			   ZCBFree: LONGINT;
			   GZProc: ProcPtr;
			   MoreMast: INTEGER;
			   Flags: INTEGER;
			   CntRel: INTEGER;
			   MaxRel: INTEGER;
			   CntNRel: INTEGER;
			   MaxNRel: INTEGER;
			   CntEmpty: INTEGER;
			   CntHandles: INTEGER;
			   MinCBFree: LONGINT;
			   PurgeProc: ProcPtr;
			   SparePtr: Ptr; { reserved for future }
			   AllocPtr: Ptr;
			   HeapData: INTEGER;
			 END;
	  THz = ^Zone; { pointer to the start of a heap zone }
	  Size = LONGINT; { size of a block in bytes }
	  OSErr = INTEGER; { error code }

	  QElemPtr = ^QElem; {ptr to generic queue element}

	  {Vertical Blanking Control Block Queue Element}
	  VBLTask = RECORD
				  qLink: QElemPtr; {link to next element}
				  qType: INTEGER; {unique ID for validity check}
				  vblAddr: ProcPtr; {address of service routine}
				  vblCount: INTEGER; {count field for timeout}
				  vblPhase: INTEGER; {phase to allow synchronization}
				END; {VBLCntrlBlk}
	  {VBLQElPtr = ^VBLTask;}

	  evQEl = RECORD
				qLink: QElemPtr;
				qType: INTEGER;
				evtQwhat: INTEGER; {this part is identical to the EventRecord
									as...}
				evtQmessage: LONGINT; {defined in ToolIntf}
				evtQwhen: LONGINT;
				evtQwhere: Point;
				evtQmodifiers: INTEGER;
			  END;

	  {drive queue elements}
	  DrvQEl = RECORD
				 qLink: QElemPtr;
				 qType: INTEGER;
				 dQDrive: INTEGER;
				 dQRefNum: INTEGER; {ref num of the drvr which handles this drive}
				 dQFSID: INTEGER; {id of file system which handles this drive}
				 dQDrvSz: INTEGER; {size of drive in 512-byte blocks -- not for
									drvs 1&2}
				 dQDrvSz2: INTEGER; {high word of drive size if qType = 1}
			   END;

	  DrvQElPtr = ^DrvQEl;

	  {for NGet and NSet TrapAdress}
	  TrapType = (OSTrap, ToolTrap);

	  {file system}

	  ParamBlkType = (IOParam, FileParam, VolumeParam, CntrlParam);

	  OSType = PACKED ARRAY [1..4] OF CHAR; {same as rsrc mgr's Restype}

	  FInfo = RECORD {record of finder info}
				fdType: OSType; {the type of the file}
				fdCreator: OSType; {file's creator}
				fdFlags: INTEGER; {flags ex. hasbundle,invisible,locked, etc.}
				fdLocation: Point; {file's location in folder}
				fdFldr: INTEGER; {folder containing file}
			  END; {FInfo}


	  FXInfo = RECORD
				 fdIconID: INTEGER; {Icon ID}
				 fdUnused: ARRAY [1..4] OF INTEGER; {unused but reserved 8 bytes}
				 fdComment: INTEGER; {Comment ID}
				 fdPutAway: LONGINT; {Home Dir ID}
			   END;

	  DInfo = RECORD
				frRect: Rect; {folder rect}
				frFlags: INTEGER; {Flags}
				frLocation: Point; {folder location}
				frView: INTEGER; {folder view}
			  END;

	  DXInfo = RECORD
				 frScroll: Point; {scroll position}
				 frOpenChain: LONGINT; {DirID chain of open folders}
				 frUnused: INTEGER; {unused but reserved}
				 frComment: INTEGER; {comment}
				 frPutAway: LONGINT; {DirID}
			   END;


	  ParamBlockRec = RECORD
	  {12 byte header used by the file and IO system}
						qLink: QElemPtr; {queue link in header}
						qType: INTEGER; {type byte for safety check}
						ioTrap: INTEGER; {FS: the Trap}
						ioCmdAddr: Ptr; {FS: address to dispatch to}

								 {common header to all variants}
						ioCompletion: ProcPtr; {completion routine addr (0 for
												synch calls)}
						ioResult: OSErr; {result code}
						ioNamePtr: StringPtr; {ptr to Vol:FileName string}
						ioVRefNum: INTEGER; {volume refnum (DrvNum for Eject and
											 MountVol)}

				 {different components for the different type of parameter blocks}
						CASE ParamBlkType OF
						  IOParam:
							(ioRefNum: INTEGER; {refNum for I/O operation}
							 ioVersNum: SignedByte; {version number}
							 ioPermssn: SignedByte; {Open: permissions (byte)}

							 ioMisc: Ptr; {Rename: new name}
								   {GetEOF,SetEOF: logical end of file}
								   {Open: optional ptr to buffer}
								   {SetFileType: new type}
							 ioBuffer: Ptr; {data buffer Ptr}
							 ioReqCount: LONGINT; {requested byte count; also =
												   ioNewDirID}
							 ioActCount: LONGINT; {actual byte count completed}
							 ioPosMode: INTEGER; {initial file positioning}
							 ioPosOffset: LONGINT); {file position offset}

						  FileParam:
							(ioFRefNum: INTEGER; {reference number}
							 ioFVersNum: SignedByte; {version number}
							 filler1: SignedByte;
							 ioFDirIndex: INTEGER; {GetFInfo directory index}
							 ioFlAttrib: SignedByte; {GetFInfo: in-use bit=7, lock
													  bit=0}
							 ioFlVersNum: SignedByte; {file version number}
							 ioFlFndrInfo: FInfo; {user info}
							 ioFlNum: LONGINT; {GetFInfo: file number; TF-
												ioDirID}
							 ioFlStBlk: INTEGER; {start file block (0 if none)}
							 ioFlLgLen: LONGINT; {logical length (EOF)}
							 ioFlPyLen: LONGINT; {physical lenght}
							 ioFlRStBlk: INTEGER; {start block rsrc fork}
							 ioFlRLgLen: LONGINT; {file logical length rsrc fork}
							 ioFlRPyLen: LONGINT; {file physical length rsrc fork}
							 ioFlCrDat: LONGINT; {file creation date & time (32
												  bits in secs)}
							 ioFlMdDat: LONGINT); {last modified date and time}

						  VolumeParam:
							(filler2: LONGINT;
							 ioVolIndex: INTEGER; {volume index number}
							 ioVCrDate: LONGINT; {creation date and time}
							 ioVLsBkUp: LONGINT; {last backup date and time}
							 ioVAtrb: INTEGER; {volume attrib}
							 ioVNmFls: INTEGER; {number of files in directory}
							 ioVDirSt: INTEGER; {start block of file directory}
							 ioVBlLn: INTEGER; {GetVolInfo: length of dir in
												blocks}
							 ioVNmAlBlks: INTEGER; {GetVolInfo: num blks (of alloc
													size)}
							 ioVAlBlkSiz: LONGINT; {GetVolInfo: alloc blk byte
													size}
							 ioVClpSiz: LONGINT; {GetVolInfo: bytes to allocate at
												  a time}
							 ioAlBlSt: INTEGER; {starting disk(512-byte) block in
												 block map}
							 ioVNxtFNum: LONGINT; {GetVolInfo: next free file
												   number}
							 ioVFrBlk: INTEGER); {GetVolInfo: # free alloc blks
												  for this vol}

						  CntrlParam:
							(ioCRefNum: INTEGER; {refNum for I/O operation}
							 CSCode: INTEGER; {word for control status code}
							 CSParam: ARRAY [0..10] OF INTEGER); {operation-defined
							parameters}
					  END; {ParamBlockRec}

	  ParmBlkPtr = ^ParamBlockRec;

	  HParamBlockRec = RECORD
	  {12 byte header used by the file system}
						 qLink: QElemPtr;
						 qType: INTEGER;
						 ioTrap: INTEGER;
						 ioCmdAddr: Ptr;

								  {common header to all variants}
						 ioCompletion: ProcPtr; {completion routine, or NIL if
												 none}
						 ioResult: OSErr; {result code}
						 ioNamePtr: StringPtr; {ptr to pathname}
						 ioVRefNum: INTEGER; {volume refnum}

				 {different components for the different type of parameter blocks}
						 CASE ParamBlkType OF
						   IOParam:
							 (ioRefNum: INTEGER; {refNum for I/O operation}
							  ioVersNum: SignedByte; {version number}
							  ioPermssn: SignedByte; {Open: permissions (byte)}

							  ioMisc: Ptr; {HRename: new name}
									{HOpen: optional ptr to buffer}
							  ioBuffer: Ptr; {data buffer Ptr}
							  ioReqCount: LONGINT; {requested byte count}
							  ioActCount: LONGINT; {actual byte count completed}
							  ioPosMode: INTEGER; {initial file positioning}
							  ioPosOffset: LONGINT); {file position offset}

						   FileParam:
							 (ioFRefNum: INTEGER; {reference number} (*choose
								 either this or ioRefNum *)
							  ioFVersNum: SignedByte; {version number, normally 0}
							  filler1: SignedByte;
							  ioFDirIndex: INTEGER; {HGetFInfo directory index}
							  ioFlAttrib: SignedByte; {HGetFInfo: in-use bit=7,
													   lock bit=0}
							  ioFlVersNum: SignedByte; {file version number
														returned by GetFInfoz}
							  ioFlFndrInfo: FInfo; {user info}
							  ioDirID: LONGINT; {directory ID}
							  ioFlStBlk: INTEGER; {start file block (0 if none)}
							  ioFlLgLen: LONGINT; {logical length (EOF)}
							  ioFlPyLen: LONGINT; {physical length}
							  ioFlRStBlk: INTEGER; {start block rsrc fork}
							  ioFlRLgLen: LONGINT; {file logical length rsrc fork}
							  ioFlRPyLen: LONGINT; {file physical length rsrc
													fork}
							  ioFlCrDat: LONGINT; {file creation date & time (32
												   bits in secs)}
							  ioFlMdDat: LONGINT); {last modified date and time}

						   VolumeParam:
							 (filler2: LONGINT;
							  ioVolIndex: INTEGER; {volume index number}
							  ioVCrDate: LONGINT; {creation date and time}
							  ioVLsMod: LONGINT; {last date and time volume was
												  flushed}
							  ioVAtrb: INTEGER; {volume attrib}
							  ioVNmFls: INTEGER; {number of files in directory}
							  ioVBitMap: INTEGER; {start block of volume bitmap}
							  ioAllocPtr: INTEGER; {HGetVInfo: length of dir in
													blocks}
							  ioVNmAlBlks: INTEGER; {HGetVInfo: num blks (of alloc
													 size)}
							  ioVAlBlkSiz: LONGINT; {HGetVInfo: alloc blk byte
													 size}
							  ioVClpSiz: LONGINT; {HGetVInfo: bytes to allocate at
												   a time}
							  ioAlBlSt: INTEGER; {starting disk(512-byte) block in
												  block map}
							  ioVNxtCNID: LONGINT; {HGetVInfo: next free file
													number}
							  ioVFrBlk: INTEGER; {HGetVInfo: # free alloc blks for
												  this vol}
							  ioVSigWord: INTEGER; {Volume signature}
							  ioVDrvInfo: INTEGER; {Drive number}
							  ioVDRefNum: INTEGER; {Driver refNum}
							  ioVFSID: INTEGER; {ID of file system handling this
												 volume}
							  ioVBkUp: LONGINT; {Last backup date (0 if never
												 backed up)}
							  ioVSeqNum: INTEGER; {Sequence number of this volume
												   in volume set}
							  ioVWrCnt: LONGINT; {Volume write count}
							  ioVFilCnt: LONGINT; {Volume file count}
							  ioVDirCnt: LONGINT; {Volume directory count}
							  ioVFndrInfo: ARRAY [1..8] OF LONGINT); {Finder info.
							 for volume}
					   END; {HParamBlockRec}

	  HParmBlkPtr = ^HParamBlockRec;

	  FCBPBRec = RECORD { for PBGetFCBInfo }
	  {12 byte header used by the file and IO system}
				   qLink: QElemPtr; {queue link in header}
				   qType: INTEGER; {type byte for safety check}
				   ioTrap: INTEGER; {FS: the Trap}
				   ioCmdAddr: Ptr; {FS: address to dispatch to}
				   ioCompletion: ProcPtr; {completion routine addr (0 for synch
										   calls)}
				   ioResult: OSErr; {result code}
				   ioNamePtr: StringPtr; {ptr to Vol:FileName string}
				   ioVRefNum: INTEGER; {volume refnum (DrvNum for Eject and
										MountVol)}
				   ioRefNum: INTEGER; {file to get the FCB about}
				   filler: INTEGER;
				   ioFCBIndx: INTEGER; {FCB index for _GetFCBInfo }
				   ioFCBFiller1: INTEGER; {filler}
				   ioFCBFlNm: LONGINT; {File number }
				   ioFCBFlags: INTEGER; {FCB flags }
				   ioFCBStBlk: INTEGER; {File start block }
				   ioFCBEOF: LONGINT; {Logical end-of-file }
				   ioFCBPLen: LONGINT; {Physical end-of-file }
				   ioFCBCrPs: LONGINT; {Current file position }
				   ioFCBVRefNum: INTEGER; {Volume refNum }
				   ioFCBClpSiz: LONGINT; {File clump size }
				   ioFCBParID: LONGINT; {Parent directory ID }
				 END;

	  FCBPBPtr = ^FCBPBRec;

	  CMovePBRec = RECORD
					 qLink: QElemPtr; {queue link in header}
					 qType: INTEGER; {type byte for safety check}
					 ioTrap: INTEGER; {FS: the Trap}
					 ioCmdAddr: Ptr; {FS: address to dispatch to}
					 ioCompletion: ProcPtr; {completion routine addr (0 for synch
											 calls)}
					 ioResult: OSErr; {result code}
					 ioNamePtr: StringPtr; {ptr to Vol:FileName string}
					 ioVRefNum: INTEGER; {volume refnum (DrvNum for Eject and
										  MountVol)}
					 filler1: LONGINT;
					 ioNewName: StringPtr; {name of new directory}
					 filler2: LONGINT;
					 ioNewDirID: LONGINT; {directory ID of new directory}
					 filler3: ARRAY [1..2] OF LONGINT;
					 ioDirID: LONGINT; {directory ID of current directory}
				   END;
	  CMovePBPtr = ^CMovePBRec;

	  WDPBRec = RECORD {for PBGetWDInfo }
				  qLink: QElemPtr; {queue link in header}
				  qType: INTEGER; {type byte for safety check}
				  ioTrap: INTEGER; {FS: the Trap}
				  ioCmdAddr: Ptr; {FS: address to dispatch to}
				  ioCompletion: ProcPtr; {completion routine addr (0 for synch
										  calls)}
				  ioResult: OSErr; {result code}
				  ioNamePtr: StringPtr; {ptr to Vol:FileName string}
				  ioVRefNum: INTEGER; {volume refnum }
				  filler1: INTEGER; {not used}
				  ioWDIndex: INTEGER; {Working Directory index for _GetWDInfo }
				  ioWDProcID: LONGINT; {WD's ProcID }
				  ioWDVRefNum: INTEGER; {WD's Volume RefNum }
				  filler2: ARRAY [1..7] OF INTEGER;
				  ioWDDirID: LONGINT; {WD's DirID }
				END;

	  WDPBPtr = ^WDPBRec;

	  CInfoType = (hFileInfo, dirInfo);

	  CInfoPBRec = RECORD {ioDirFlg clear; equates for catalog information return}
					 qLink: QElemPtr; {queue link in header}
					 qType: INTEGER; {type byte for safety check}
					 ioTrap: INTEGER; {FS: the Trap}
					 ioCmdAddr: Ptr; {FS: address to dispatch to}
					 ioCompletion: ProcPtr; {completion routine addr (0 for synch
											 calls)}
					 ioResult: OSErr; {result code}
					 ioNamePtr: StringPtr; {ptr to Vol:FileName string}
					 ioVRefNum: INTEGER; {volume refnum (DrvNum for Eject and
										  MountVol)}
					 ioFRefNum: INTEGER; {file reference number}
					 ioFVersNum: SignedByte; {version number}
					 filler1: SignedByte;
					 ioFDirIndex: INTEGER; {GetFInfo directory index}
					 ioFlAttrib: SignedByte; {GetFInfo: in-use bit=7, lock bit=0}
					 filler2: SignedByte;
					 CASE CInfoType OF
					   hFileInfo:
						 (ioFlFndrInfo: FInfo; {user info}
						  ioDirID: LONGINT; {directory ID or file number}
						  ioFlStBlk: INTEGER; {start file block (0 if none)}
						  ioFlLgLen: LONGINT; {logical length (EOF)}
						  ioFlPyLen: LONGINT; {physical lenght}
						  ioFlRStBlk: INTEGER; {start block rsrc fork}
						  ioFlRLgLen: LONGINT; {file logical length rsrc fork}
						  ioFlRPyLen: LONGINT; {file physical length rsrc fork}
						  ioFlCrDat: LONGINT; {file creation date & time (32 bits
											   in secs)}
						  ioFlMdDat: LONGINT; {last modified date and time}
						  ioFlBkDat: LONGINT; {file last backup date}
						  ioFlXFndrInfo: FXInfo; {file additional finder info
												  bytes}
						  ioFlParID: LONGINT; {file parent directory ID
											   (integer?)}
						  ioFlClpSiz: LONGINT); {file clump size}
					   dirInfo: {equates for directory information return}
						 (ioDrUsrWds: DInfo; {Directory's user info bytes}
						  ioDrDirID: LONGINT; {Directory ID}
						  ioDrNmFls: INTEGER; {Number of files in a directory}
						  filler3: ARRAY [1..9] OF INTEGER;
						  ioDrCrDat: LONGINT; {Directory creation date}
						  ioDrMdDat: LONGINT; {Directory modification date}
						  ioDrBkDat: LONGINT; {Directory backup date }
						  ioDrFndrInfo: DXInfo; {Directory finder info bytes}
						  ioDrParID: LONGINT); {Directory's parent directory ID}
				   END;

	  CInfoPBPtr = ^CInfoPBRec;

	  {20 bytes of system parameter area}
	  SysParmType = PACKED RECORD
					  Valid: Byte; {validation field ($A7)}
					  ATalkA: Byte; {AppleTalk node number hint for port A }
					  ATalkB: Byte; {AppleTalk node number hint for port B }
					  Config: Byte; {ATalk port configuration A = bits 4-7, B =
									 0-3}
					  PortA: INTEGER; {SCC port A configuration}
					  PortB: INTEGER; {SCC port B configuration}
					  Alarm: LONGINT; {alarm time}
					  Font: INTEGER; {default font id}
					  KbdPrint: INTEGER; {high byte = kbd repeat}
							  {high nibble = thresh in 4/60ths}
							  {low nibble = rates in 2/60ths}
							  {low byte = print stuff}
					  VolClik: INTEGER; {low 3 bits of high byte = volume control}
							 {high nibble of low byte = double time in 4/60ths}
							{low nibble of low byte = caret blink time in 4/60ths}
					  Misc: INTEGER; {EEEC EEEE PSKB FFHH}
						  {E = extra}
						  {P = paranoia level}
						  {S = mouse scaling}
						  {K = key click}
						  {B = boot disk}
						  {F = menu flash}
						  {H = help level}
					END; {SysParmType}
	  SysPPtr = ^SysParmType;

	  {volume control block data structure}
	  VCB = RECORD
			  qLink: QElemPtr; {link to next element}
			  qType: INTEGER; {not used}
			  vcbFlags: INTEGER;
			  vcbSigWord: INTEGER;
			  vcbCrDate: LONGINT;
			  vcbLsMod: LONGINT;
			  vcbAtrb: INTEGER;
			  vcbNmFls: INTEGER;
			  vcbVBMSt: INTEGER;
			  vcbAllocPtr: INTEGER;
			  vcbNmAlBlks: INTEGER;
			  vcbAlBlkSiz: LONGINT;
			  vcbClpSIz: LONGINT;
			  vcbAlBlSt: INTEGER;
			  vcbNxtCNID: LONGINT;
			  vcbFreeBks: INTEGER;
			  vcbVN: STRING[27];
			  vcbDrvNum: INTEGER;
			  vcbDRefNum: INTEGER;
			  vcbFSID: INTEGER;
			  vcbVRefNum: INTEGER;
			  vcbMAdr: Ptr;
			  vcbBufAdr: Ptr;
			  vcbMLen: INTEGER;
			  vcbDirIndex: INTEGER;
			  vcbDirBlk: INTEGER;

					   {new HFS extensions}
			  vcbVolBkup: LONGINT;
			  vcbVSegNum: INTEGER;
			  vcbWrCnt: LONGINT;
			  vcbXTClpSiz: LONGINT;
			  vcbCTClpSiz: LONGINT;
			  vcbNmRtDirs: INTEGER;
			  vcbFilCnt: LONGINT;
			  vcbDirCnt: LONGINT;
			  vcbFndrInfo: ARRAY [1..8] OF LONGINT;
			  vcbVCSize: INTEGER;
			  vcbVBMCSiz: INTEGER;
			  vcbCtlCSiz: INTEGER;
						{additional VCB info}
			  vcbXTAlBlks: INTEGER;
			  vcbCTAlBlks: INTEGER;
			  vcbXTRef: INTEGER;
			  vcbCTRef: INTEGER;
			  vcbCtlBuf: Ptr;
			  vcbDirIDM: LONGINT;
			  vcbOffsM: INTEGER;

			END;

	  {general queue data structure}
	  QHdr = RECORD
			   QFlags: INTEGER; {misc flags}
			   QHead: QElemPtr; {first elem}
			   QTail: QElemPtr; {last elem}
			 END; {QHdr}
	  QHdrPtr = ^QHdr;
	  {there are currently 4 types of queues:			}
	  {   VType   -   queue of Vertical Blanking Control Blocks 	  }
	  {   IOQType -   queue of I/0 queue elements		   }
	  {   DrvType -   queue of drivers			 }
	  {   EvType  -   queue of Event Records		   }
	  {   FSQType -   queue of VCB elements 		  }
	  {   TimerType no longer is used.	DrvType replaces it here in enum type}
	  QTypes = (dummyType, vType, ioQType, drvQType, evType, fsQType);

	  QElem = RECORD
				CASE QTypes OF
				  vType:
					(vblQelem: VBLTask); {vertical blanking}

				  ioQType:
					(ioQElem: ParamBlockRec); {I/O parameter block}

				  drvQType:
					(drvQElem: DrvQEl); {drive}

				  evType:
					(evQElem: evQEl); {event}

				  fsQType:
					(vcbQElem: VCB); {volume control block}

			  END; {QElem}

	  {device control entry}
	  DCtlEntry = RECORD
					DCtlDriver: Ptr; {ptr to ROM or handle to RAM driver}
					DCtlFlags: INTEGER; {flags}
					DCtlQHdr: QHdr; {driver's i/o queue}
					DCtlPosition: LONGINT; {byte pos used by read and write calls}
					DCtlStorage: Handle; {hndl to RAM drivers private storage}
					DCtlRefNum: INTEGER; {driver's reference number}
					DCtlCurTicks: LONGINT; {long counter for timing system task
											calls}
					DCtlWindow: Ptr; {ptr to driver's window if any}
					DCtlDelay: INTEGER; {number of ticks btwn sysTask calls}
					DCtlEMask: INTEGER; {desk acessory event mask}
					DCtlMenu: INTEGER; {menu ID of menu associated with driver}
				  END; {DCtlEntry}
	  DCtlPtr = ^DCtlEntry;
	  DCtlHandle = ^DCtlPtr;

	  {for Serial Driver}
	  SerShk = PACKED RECORD {handshake control fields}
				 fXOn: Byte; {XON flow control enabled flag}
				 fCTS: Byte; {CTS flow control enabled flag}
				 xon: CHAR; {XOn character}
				 xoff: CHAR; {XOff character}
				 errs: Byte; {errors mask bits}
				 evts: Byte; {event enable mask bits}
				 fInX: Byte; {Input flow control enabled flag}
				 null: Byte; {unused}
			   END;

	  {parameter block structure for file and IO routines}
	  SerStaRec = PACKED RECORD
					cumErrs: Byte; {cumulative errors report}
					xOFFSent: Byte; {XOff Sent flag}
					rdPend: Byte; {read pending flag}
					wrPend: Byte; {write pending flag}
					ctsHold: Byte; {CTS flow control hold flag}
					xOFFHold: Byte; {XOff flow control hold flag}
				  END;

	  {for Sound Driver}

	  {for 4-tone sound generation}
	  Wave = PACKED ARRAY [0..255] OF Byte;
	  WavePtr = ^Wave;
	  FTSoundRec = RECORD
					 duration: INTEGER;
					 sound1Rate: LONGINT;
					 sound1Phase: LONGINT;
					 sound2Rate: LONGINT;
					 sound2Phase: LONGINT;
					 sound3Rate: LONGINT;
					 sound3Phase: LONGINT;
					 sound4Rate: LONGINT;
					 sound4Phase: LONGINT;
					 sound1Wave: WavePtr;
					 sound2Wave: WavePtr;
					 sound3Wave: WavePtr;
					 sound4Wave: WavePtr;
				   END;
	  FTSndRecPtr = ^FTSoundRec;

	  FTSynthRec = RECORD
					 mode: INTEGER;
					 sndRec: FTSndRecPtr;
				   END;
	  FTSynthPtr = ^FTSynthRec;

	  Tone = RECORD
			   count: INTEGER;
			   amplitude: INTEGER;
			   duration: INTEGER;
			 END;

	  Tones = ARRAY [0..5000] OF Tone;

	  SWSynthRec = RECORD
					 mode: INTEGER;
					 triplets: Tones;
				   END;

	  SWSynthPtr = ^SWSynthRec;

	  freeWave = PACKED ARRAY [0..30000] OF Byte;

	  FFSynthRec = RECORD
					 mode: INTEGER;
					 count: Fixed;
					 waveBytes: freeWave;
				   END;

	  FFSynthPtr = ^FFSynthRec;

	  {for date and time}
	  DateTimeRec = RECORD
					  year, {1904,1905,...}
					  month, {1,...,12 corresponding to Jan,...,Dec}
					  day, {1,...31}
					  hour, {0,...,23}
					  minute, {0,...,59}
					  second, {0,...,59}
					  dayOfWeek: INTEGER; {1,...,7 corresponding to Sun,...,Sat}
					END; {DateTimeRec}

	  {for application parameter}
	  appFile = RECORD
				  vRefNum: INTEGER;
				  ftype: OSType;
				  versNum: INTEGER; {versNum in high byte}
				  fName: Str255;
				END; {appFile}

	  {for RAM serial driver}
	  SPortSel = (SPortA, SPortB);

	  DriveKind = (sony, hard20);

	  DrvSts = RECORD
				 track: INTEGER; {current track}
				 writeProt: SignedByte; {bit 7 = 1 if volume is locked}
				 diskInPlace: SignedByte; {disk in drive}
				 installed: SignedByte; {drive installed}
				 sides: SignedByte; {-1 for 2-sided, 0 for 1-sided}
				 driveQLink: QElemPtr; {next queue entry}
				 driveQVers: INTEGER; {1 for HD20}
				 dQDrive: INTEGER; {drive number}
				 dQRefNum: INTEGER; {driver reference number}
				 dQFSID: INTEGER; {file system ID}
				 CASE DriveKind OF
				   sony:
					 (twoSideFmt: SignedByte; {-1 for 2-sided, 0 for 1-sided, --
											   valid after first read or write}
					  needsFlush: SignedByte; {-1 for MacPlus drive}
					  diskErrs: INTEGER); {soft error count}
				   hard20:
					 (driveSize: INTEGER; {drive block size low word}
					  driveS1: INTEGER; {drive block size high word}
					  driveType: INTEGER; {1 for HD20}
					  driveManf: INTEGER; {1 for Apple Computer, Inc.}
					  driveChar: Byte; {230 ($E6) for HD20}
					  driveMisc: SignedByte) {0 -- reserved}
			   END;

	  {for Time Manager}

	  TMTask = RECORD
				 qLink: QElemPtr; {next queue entry}
				 qType: INTEGER; {queue type}
				 tmAddr: ProcPtr; {pointer to task}
				 tmCount: LONGINT; {reserved}
			   END;

{********** NEW CODE FOR OSINTF.P **********}

{Device Manager Slot Support}

SlotIntQElement = RECORD
					sqLink: Ptr;		{ptr to next element}
					sqType: INTEGER;	{queue type ID for validity}
					sqPrio: INTEGER;	{priority}
					sqAddr: ProcPtr;	{interrupt service routine}
					sqParm: LONGINT;	{optional A1 parameter}
				  END;
				  
SQElemPtr = ^SlotIntQElement;


{Slot Declaration Manager}

SpBlock = PACKED RECORD
			spResult: LONGINT;			{FUNCTION Result. [Used by: every function]}
			spsPointer: Ptr;			{Structure pointer}
			spSize: LONGINT;			{Size of structure}
			spOffsetData: LONGINT;		{Offset/Data field.  [Used by:sOffsetData]}
			spIOFileName: Ptr;			{Pointer to IOFile name. [Used by sDisDrvrName]}
			spsExecPBlk: Ptr;			{Pointer to sExec parameter block.}
			spStackPtr: Ptr;			{Old Stack pointer.}
			spMisc: LONGINT;			{Misc field for SDM.}
			spReserved: LONGINT;		{Reserved for future expansion}
			spIOReserved: LONGINT;		{Reserved field of Slot Resource Table}
			spRefNum: INTEGER;			{RefNum}
			spCategory: INTEGER;		{sType: Category	}
			spCType: INTEGER;			{		  Type		}
			spDrvrSW: INTEGER;  		{		  DrvrSW	}
			spDrvrHW: INTEGER;  		{		  DrvrHW	}
			spTBMask: SignedByte;		{Type bit mask (Bits 0..3 determine which words 0..3 to mask).}
		  	spSlot: SignedByte;			{Slot number}
			spID: SignedByte;			{Structure ID}
			spExtDev: SignedByte;		{Id of the external device.}
			spHwDev: SignedByte;		{Id of the hardware device.}
			spByteLanes: SignedByte;	{Bytelanes value from FHeader in the declaration ROM.}	 
			spFlags: SignedByte;		{Flags passed to routines (SSearchSRT,_InitSDeclMgr,...}
			spKey: SignedByte;			{Internal use only.}
		  END;

SpBlockPtr = ^SpBlock;

SInfoRecord = PACKED RECORD
				siDirPtr: Ptr;				{Pointer to directory}
				siInitStatusA: INTEGER;		{initialization error}
				siInitStatusV: INTEGER;		{status returned by vendor init code}
				siState: SignedByte;		{initialization state}
				siCPUByteLanes: SignedByte;	{0=[d0..d7], 1=[d8..d15], ...}
				siTopOfROM: SignedByte;		{Top of ROM = $FssFFFFx, where x is TopOfROM.}
				siStatusFlags: SignedByte;	{bit 0 - card is changed}
				siTOConst: INTEGER;			{ Time Out Constant for BusErr }
				siReserved: PACKED ARRAY [0..1] OF SignedByte;		{reserved}
 			  END;
			  
SInfoRecPtr = ^SInfoRecord;


SDMRecord = PACKED RECORD
				sdBEVSave: ProcPtr;		{Save old BusErr vector.}
				sdBusErrProc: ProcPtr;	{Go here to determine if it is a BusErr.}
				sdErrorEntry: ProcPtr;	{Go here if BusErrProc determines it is really a BusErr.}
				sdReserved: LONGINT;	{Reserved}
			 END;
			  

FHeaderRec = PACKED RECORD
				fhDirOffset: LONGINT;	{offset to directory}
				fhLength: LONGINT;		{length of ROM}
				fhCRC: LONGINT;			{CRC}
				fhROMRev: SignedByte;	{revision of ROM}
				fhFormat: SignedByte;	{format - 2}
				fhTstPat: LONGINT;		{test pattern}
				fhReserved: INTEGER;	{reserved}
				fhByteLanes: SignedByte;{ByteLanes}
			 END;
			 
FHeaderRecPtr = ^FHeaderRec;


SEBlock = PACKED RECORD
				seSlot: SignedByte;			{Slot number.}
				sesRsrcId: SignedByte;		{sResource Id.}
				seStatus: INTEGER;			{Status of code executed by sExec.}
				seFlags: SignedByte;		{Flags.}
				seFiller0: SignedByte;		{Filler, must be SignedByte to align on odd boundry}
				seFiller1: SignedByte;		{Filler}
				seFiller2: SignedByte;		{Filler}
											{ extensions for sLoad + sBoot }
				seResult: LONGINT;			{Result of sLoad.}
				seIOFileName: LONGINT;		{Pointer to IOFile name.}
				seDevice: SignedByte;		{Which device to read from.}
				sePartition: SignedByte;	{The partition.}
				seOSType: SignedByte;		{Type of OS.}
				seReserved: SignedByte;		{Reserved field.}
				seRefNum: SignedByte;		{ RefNum of the driver.}
											{ extensions for sBoot }
				seNumDevices: SignedByte;	{Number of devices to load.}
				seBootState: SignedByte;	{State of StartBoot code.}
			 END;

SEHeader1 = PACKED RECORD
				seRevision: SignedByte;		{Revision of seBlock. Must be same as SEHeader2}
				seCPUId: SignedByte;		{Id of CPU}
				seTimeOut: INTEGER;			{Time Out}
				seCode: SignedByte;			{Beginning of code.}
			 END;
				
SEHeader2 = PACKED RECORD
				seRevision: SignedByte;		{Revision of seBlock. Must be same as SEHeader1}
				seCPUId: SignedByte;		{Id of CPU}
				seTimeOut: INTEGER;			{Time Out}
				seCodeOffset: LONGINT;		{Offset to code.}
			 END;


SRRBlock = PACKED RECORD
				srrHWDev: SignedByte;		{Hardware device id.}
				srrSlot: SignedByte;		{Slot}
				srrId: SignedByte;			{Id}
				srrExtDev: SignedByte;		{External Device}
				srrRefNum: INTEGER;			{RefNum of driver}
				srrIOReserved: INTEGER;		{Reserved}
				srrCategory: INTEGER;		{sType:	Category}
				srrCType: INTEGER;			{		Type	}
				srrDrvrSW: INTEGER; 		{		DrvrSW	}
				srrDrvrHW: INTEGER;  		{		DrvrHW	}
				srrsRsrcPtr: Ptr;			{Pointer to sResource}
			 END;


{Apple Desktop Bus}

ADBOpBlock = RECORD
				dataBuffPtr: Ptr;      	{address of data buffer}
				opServiceRtPtr: Ptr;	{service routine pointer}
				opDataAreaPtr: Ptr;		{optional data area address}
			 END;

ADBOpBPtr = ^ADBOpBlock;

ADBDataBlock = PACKED RECORD
				devType: SignedByte;	{device type}
				origADBAddr: SignedByte;{original ADB Address}
				dbServiceRtPtr: Ptr;	{service routine pointer}
				dbDataAreaAddr: Ptr;		{data area address}
			   END;
			   
ADBDBlkPtr = ^ADBDataBlock;

ADBSetInfoBlock = RECORD
					siServiceRtPtr: Ptr;		{service routine pointer}
					siDataAreaAddr: Ptr;		{data area address}
			   	  END;

ADBSInfoPtr = ^ADBSetInfoBlock;

ADBAddress = SignedByte;

					{Memory Manager}

AnAddress = LONGINT; {pointers, handles, etc. need to be coerced to
					 	this type to be passed to StripAddress}

					{Start Manager}

DefaultRec	=	RECORD
					drDriveNum:	INTEGER;
					drRefNum:	INTEGER;
				END;
DefRecPtr = ^DefaultRec;


DefaultVidRec	=	RECORD
					sdSlot:		BYTE;
					sdsResID:	BYTE;
				END;
DefVidPtr = ^DefaultVidRec;


DefaultOSRec	=	RECORD
					sdOSType:	BYTE;
					sdReserved:	BYTE;
				END;
DefOSPtr = ^DefaultOSRec;



	  {for Event Manager}

	FUNCTION PostEvent(eventNum: INTEGER; eventMsg: LONGINT): OSErr;

	FUNCTION PPostEvent(eventCode: INTEGER; eventMsg: LONGINT;
						VAR qEl: evQEl): OSErr;

	PROCEDURE FlushEvents(whichMask, stopMask: INTEGER);
	  INLINE $201F, $A032;

	PROCEDURE SetEventMask(theMask: INTEGER);
	  INLINE $31DF, $0144;

	FUNCTION OSEventAvail(mask: INTEGER; VAR theEvent: EventRecord): BOOLEAN;

	FUNCTION GetOSEvent(mask: INTEGER; VAR theEvent: EventRecord): BOOLEAN;

	{OS utilities}

	FUNCTION HandToHand(VAR theHndl: Handle): OSErr;

	FUNCTION PtrToXHand(srcPtr: Ptr; dstHndl: Handle; size: LONGINT): OSErr;

	FUNCTION PtrToHand(srcPtr: Ptr; VAR dstHndl: Handle; size: LONGINT): OSErr;

	FUNCTION HandAndHand(hand1, hand2: Handle): OSErr;

	FUNCTION PtrAndHand(ptr1: Ptr; hand2: Handle; size: LONGINT): OSErr;

	PROCEDURE SysBeep(duration: INTEGER);
	  INLINE $A9C8;

	PROCEDURE Environs(VAR rom, machine: INTEGER);

	PROCEDURE Restart;

	{routines to set A5 to CurrentA5 and then restore A5 to previous value}
	{useful for ensuring good world for IOCompletion routines}

	PROCEDURE SetUpA5;
	  INLINE $2F0D, $2A78, $0904;
	{MOVE.L A5,-(SP)	 ;save old A5 on stack
	 MOVE.L CurrentA5,A5	;get the real A5}

	PROCEDURE RestoreA5;
	  INLINE $2A5F;
	{MOVE.L (A7)+,A5	 ;restore A5}

	{from HEAPZONE.TEXT}

	PROCEDURE SetApplBase(startPtr: Ptr);

	PROCEDURE InitApplZone;

	PROCEDURE InitZone(pgrowZone: ProcPtr; cmoreMasters: INTEGER; limitPtr,
					   startPtr: Ptr);

	FUNCTION GetZone: THz;

	PROCEDURE SetZone(hz: THz);

	FUNCTION ApplicZone: THz;
	  INLINE $2EB8, $02AA;

	FUNCTION SystemZone: THz;
	  INLINE $2EB8, $02A6;

	FUNCTION CompactMem(cbNeeded: Size): Size;

	PROCEDURE PurgeMem(cbNeeded: Size);

	FUNCTION FreeMem: LONGINT;

	PROCEDURE ResrvMem(cbNeeded: Size);

	FUNCTION MaxMem(VAR grow: Size): Size;

	FUNCTION TopMem: Ptr;
	  INLINE $2EB8, $0108;

	PROCEDURE SetGrowZone(growZone: ProcPtr);

	PROCEDURE SetApplLimit(zoneLimit: Ptr);

	FUNCTION GetApplLimit: Ptr;
	  INLINE $2EB8, $0130;

	FUNCTION StackSpace: LONGINT;

	PROCEDURE PurgeSpace(VAR total, contig: LONGINT);

	FUNCTION MaxBlock: LONGINT;

	PROCEDURE MaxApplZone;

	PROCEDURE MoveHHi(h: Handle);

	FUNCTION NewPtr(byteCount: Size): Ptr;

	PROCEDURE DisposPtr(p: Ptr);

	FUNCTION GetPtrSize(p: Ptr): Size;

	PROCEDURE SetPtrSize(p: Ptr; newSize: Size);

	FUNCTION PtrZone(p: Ptr): THz;

	FUNCTION NewHandle(byteCount: Size): Handle;

	FUNCTION NewEmptyHandle: Handle;

	PROCEDURE DisposHandle(h: Handle);

	FUNCTION GetHandleSize(h: Handle): Size;

	PROCEDURE SetHandleSize(h: Handle; newSize: Size);

	FUNCTION HandleZone(h: Handle): THz;

	FUNCTION RecoverHandle(p: Ptr): Handle;

	PROCEDURE EmptyHandle(h: Handle);

	PROCEDURE ReAllocHandle(h: Handle; byteCount: Size);

	PROCEDURE HLock(h: Handle);

	PROCEDURE HUnLock(h: Handle);

	PROCEDURE HPurge(h: Handle);

	PROCEDURE HNoPurge(h: Handle);

	PROCEDURE HSetRBit(h: Handle);

	PROCEDURE HClrRBit(h: Handle);

	PROCEDURE HSetState(h: Handle; flags: SignedByte);

	FUNCTION HGetState(h: Handle): SignedByte;

	PROCEDURE MoreMasters;

	PROCEDURE BlockMove(srcPtr, destPtr: Ptr; byteCount: Size);

	FUNCTION MemError: OSErr;
	  INLINE $3EB8, $0220;

	FUNCTION GZSaveHnd: Handle;
	  INLINE $2EB8, $0328;

	{interface for core routines pertaining to the vertical retrace mgr}
	{routines defined in VBLCORE.TEXT}

	FUNCTION VInstall(vblTaskPtr: QElemPtr): OSErr;

	FUNCTION VRemove(vblTaskPtr: QElemPtr): OSErr;

	{interface for Operating System Dispatcher}
	{routines defined in DISPATCH.TEXT}

	FUNCTION GetTrapAddress(trapNum: INTEGER): LONGINT;

	PROCEDURE SetTrapAddress(trapAddr: LONGINT; trapNum: INTEGER);

	FUNCTION NGetTrapAddress(trapNum: INTEGER; tTyp: TrapType): LONGINT;

	PROCEDURE NSetTrapAddress(trapAddr: LONGINT; trapNum: INTEGER;
							  tTyp: TrapType);

	{interface for utility core routines (defined in sysutil)}

	FUNCTION GetSysPPtr: SysPPtr;

	FUNCTION WriteParam: OSErr;

	FUNCTION SetDateTime(time: LONGINT): OSErr;

	FUNCTION ReadDateTime(VAR time: LONGINT): OSErr;

	PROCEDURE GetDateTime(VAR secs: LONGINT);

	PROCEDURE SetTime(d: DateTimeRec);

	PROCEDURE GetTime(VAR d: DateTimeRec);

	PROCEDURE Date2Secs(d: DateTimeRec; VAR s: LONGINT);

	PROCEDURE Secs2Date(s: LONGINT; VAR d: DateTimeRec);

	PROCEDURE Delay(numTicks: LONGINT; VAR finalTicks: LONGINT);

	FUNCTION EqualString(str1, str2: Str255; caseSens,
						 diacSens: BOOLEAN): BOOLEAN;

	FUNCTION RelString(aStr, bStr: Str255; caseSens, diacSens: BOOLEAN): INTEGER;

	PROCEDURE UprString(VAR theString: Str255; diacSens: BOOLEAN);

	FUNCTION InitUtil: OSErr;
	  INLINE $A03F, $3E80;

	PROCEDURE UnLoadSeg(routineAddr: Ptr);
	  INLINE $A9F1;

	PROCEDURE ExitToShell;
	  INLINE $A9F4;

	PROCEDURE GetAppParms(VAR apName: Str255; VAR apRefNum: INTEGER;
						  VAR apParam: Handle);
	  INLINE $A9F5;

	PROCEDURE CountAppFiles(VAR message: INTEGER; VAR count: INTEGER);

	PROCEDURE GetAppFiles(index: INTEGER; VAR theFile: appFile);

	PROCEDURE ClrAppFiles(index: INTEGER);

	{queue routines - part of Macintosh core Utility routines}

	PROCEDURE FInitQueue;
	  INLINE $A016;

	PROCEDURE Enqueue(qElement: QElemPtr; qHeader: QHdrPtr);

	FUNCTION Dequeue(qElement: QElemPtr; qHeader: QHdrPtr): OSErr;

	FUNCTION GetFSQHdr: QHdrPtr;

	FUNCTION GetDrvQHdr: QHdrPtr;

	FUNCTION GetVCBQHdr: QHdrPtr;

	FUNCTION GetVBLQHdr: QHdrPtr;

	FUNCTION GetEvQHdr: QHdrPtr;

	FUNCTION GetDCtlEntry(refNum: INTEGER): DCtlHandle;

	FUNCTION PBOpen(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBClose(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBRead(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBWrite(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBControl(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBStatus(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBKillIO(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetVInfo(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetVol(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetVol(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBFlushVol(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBCreate(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBDelete(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBOpenRF(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBRename(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetFInfo(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetFInfo(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetFLock(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBRstFLock(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetFVers(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBAllocate(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetEOF(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetEOF(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetFPos(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetFPos(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBFlushFile(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBMountVol(paramBlock: ParmBlkPtr): OSErr;

	FUNCTION PBUnMountVol(paramBlock: ParmBlkPtr): OSErr;

	FUNCTION PBEject(paramBlock: ParmBlkPtr): OSErr;

	FUNCTION PBOffLine(paramBlock: ParmBlkPtr): OSErr;

	PROCEDURE AddDrive(drvrRefNum: INTEGER; drvNum: INTEGER; qEl: DrvQElPtr);

	FUNCTION PBOpenWD(paramBlock: WDPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBCloseWD(paramBlock: WDPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHSetVol(paramBlock: WDPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHGetVol(paramBlock: WDPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBCatMove(paramBlock: CMovePBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBDirCreate(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetWDInfo(paramBlock: WDPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetFCBInfo(paramBlock: FCBPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBGetCatInfo(paramBlock: CInfoPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetCatInfo(paramBlock: CInfoPBPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBAllocContig(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBLockRange(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBUnLockRange(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetVInfo(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHGetVInfo(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHOpen(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHOpenRF(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHCreate(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHDelete(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHRename(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHRstFLock(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHSetFLock(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHGetFInfo(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBHSetFInfo(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION PBSetPEOF(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;

	FUNCTION FSOpen(fileName: Str255; vRefNum: INTEGER;
					VAR refNum: INTEGER): OSErr;

	FUNCTION FSClose(refNum: INTEGER): OSErr;

	FUNCTION FSRead(refNum: INTEGER; VAR count: LONGINT; buffPtr: Ptr): OSErr;

	FUNCTION FSWrite(refNum: INTEGER; VAR count: LONGINT; buffPtr: Ptr): OSErr;

	FUNCTION Control(refNum: INTEGER; CSCode: INTEGER; csParamPtr: Ptr): OSErr;

	FUNCTION Status(refNum: INTEGER; CSCode: INTEGER; csParamPtr: Ptr): OSErr;

	FUNCTION KillIO(refNum: INTEGER): OSErr;

	{-volume level calls-}

	FUNCTION GetVInfo(drvNum: INTEGER; volName: StringPtr; VAR vRefNum: INTEGER;
					  VAR FreeBytes: LONGINT): OSErr;

	FUNCTION GetFInfo(fileName: Str255; vRefNum: INTEGER;
					  VAR FndrInfo: FInfo): OSErr;

	FUNCTION GetVol(volName: StringPtr; VAR vRefNum: INTEGER): OSErr;

	FUNCTION SetVol(volName: StringPtr; vRefNum: INTEGER): OSErr;

	FUNCTION UnMountVol(volName: StringPtr; vRefNum: INTEGER): OSErr;

	FUNCTION Eject(volName: StringPtr; vRefNum: INTEGER): OSErr;

	FUNCTION FlushVol(volName: StringPtr; vRefNum: INTEGER): OSErr;

	{-file level calls for unopened files-}

	FUNCTION Create(fileName: Str255; vRefNum: INTEGER; creator: OSType;
					fileType: OSType): OSErr;

	FUNCTION FSDelete(fileName: Str255; vRefNum: INTEGER): OSErr;

	FUNCTION OpenRF(fileName: Str255; vRefNum: INTEGER;
					VAR refNum: INTEGER): OSErr;

	FUNCTION Rename(oldName: Str255; vRefNum: INTEGER; newName: Str255): OSErr;

	FUNCTION SetFInfo(fileName: Str255; vRefNum: INTEGER; FndrInfo: FInfo): OSErr;

	FUNCTION SetFLock(fileName: Str255; vRefNum: INTEGER): OSErr;

	FUNCTION RstFLock(fileName: Str255; vRefNum: INTEGER): OSErr;

	{-file level calls for opened files-}

	FUNCTION Allocate(refNum: INTEGER; VAR count: LONGINT): OSErr;

	FUNCTION GetEOF(refNum: INTEGER; VAR LogEOF: LONGINT): OSErr;

	FUNCTION SetEOF(refNum: INTEGER; LogEOF: LONGINT): OSErr;

	FUNCTION GetFPos(refNum: INTEGER; VAR filePos: LONGINT): OSErr;

	FUNCTION SetFPos(refNum: INTEGER; posMode: INTEGER; posOff: LONGINT): OSErr;

	FUNCTION GetVRefNum(fileRefNum: INTEGER; VAR vRefNum: INTEGER): OSErr;

	{Serial Driver Interface}

	FUNCTION OpenDriver(name: Str255; VAR drvrRefNum: INTEGER): OSErr;

	FUNCTION CloseDriver(refNum: INTEGER): OSErr;

	FUNCTION SerReset(refNum: INTEGER; serConfig: INTEGER): OSErr;

	FUNCTION SerSetBuf(refNum: INTEGER; serBPtr: Ptr; serBLen: INTEGER): OSErr;

	FUNCTION SerHShake(refNum: INTEGER; Flags: SerShk): OSErr;

	FUNCTION SerSetBrk(refNum: INTEGER): OSErr;

	FUNCTION SerClrBrk(refNum: INTEGER): OSErr;

	FUNCTION SerGetBuf(refNum: INTEGER; VAR count: LONGINT): OSErr;

	FUNCTION SerStatus(refNum: INTEGER; VAR serSta: SerStaRec): OSErr;

	FUNCTION DiskEject(drvNum: INTEGER): OSErr;

	FUNCTION SetTagBuffer(buffPtr: Ptr): OSErr;

	FUNCTION DriveStatus(drvNum: INTEGER; VAR Status: DrvSts): OSErr;

	FUNCTION RamSDOpen(whichPort: SPortSel): OSErr;

	PROCEDURE RamSDClose(whichPort: SPortSel);

	{for Sound Driver}

	PROCEDURE SetSoundVol(level: INTEGER);

	PROCEDURE GetSoundVol(VAR level: INTEGER);

	PROCEDURE StartSound(synthRec: Ptr; numBytes: LONGINT;
						 CompletionRtn: ProcPtr);

	PROCEDURE StopSound;

	FUNCTION SoundDone: BOOLEAN;

	{for the system error handler}

	PROCEDURE SysError(errorCode: INTEGER);
	  INLINE $301F, $A9C9;

	{for the Time Manager}

	PROCEDURE InsTime(tmTaskPtr: QElemPtr);

	PROCEDURE RmvTime(tmTaskPtr: QElemPtr);

	PROCEDURE PrimeTime(tmTaskPtr: QElemPtr; count: LONGINT);


{********** NEW CODE FOR OSINTF.P **********}

{Device Manager Slot Support}

FUNCTION SIntInstall(sIntQElemPtr: SQElemPtr; theSlot: INTEGER ): OsErr;
FUNCTION SIntRemove(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OsErr;


{Slot Declaration Manager}
		{ Principle }
FUNCTION SReadByte(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadWord(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadLong(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetcString(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetColorIcon(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetBlock(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindStruct(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadStruct(spBlkPtr: SpBlockPtr): OSErr;
	
		{ Special }
FUNCTION SReadInfo(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPutPRAMRec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadFHeader(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SNextsRsrc(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SNextTypesRsrc(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SRsrcInfo(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SDisposePtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCkCardStat(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadDrvrName(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SMacBoot(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SDetDevBase(spBlkPtr: SpBlockPtr): OSErr;

		{ Advanced }
FUNCTION InitSDeclMgr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPrimaryInit(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCardChanged(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SExec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SOffsetData(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SInitPRAMRecs(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadPBSize(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SNewPtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCalcStep(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SInitsRsrcTable(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SSearchSRT(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SUpdateSRT(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCalcsPointer(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetDriver(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPtrToSlot(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindsInfoRecPtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindsRsrcPtr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SDeleteSRTRec(spBlkPtr: SpBlockPtr): OSErr;


{Vertical Retrace Manager}

FUNCTION SlotVInstall(VBLBlockPtr: QElemPtr; theSlot: INTEGER ): OsErr;
FUNCTION SlotVRemove(VBLBlockPtr: QElemPtr; theSlot: INTEGER): OsErr;
FUNCTION AttachVBL(theSlot: INTEGER): OsErr;
FUNCTION DoVBLTask(theSlot: INTEGER): OsErr;


{Apple Desktop Bus}

PROCEDURE ADBReInit;
	INLINE $A07B;
FUNCTION ADBOp(data: Ptr; compRout: ProcPtr; buffer: Ptr; commandNum: INTEGER): OsErr;
FUNCTION CountADBs: INTEGER;
FUNCTION GetIndADB(VAR info: ADBDataBlock; devTableIndex: INTEGER): ADBAddress;
FUNCTION GetADBInfo(VAR info: ADBDataBlock; ADBAddr: ADBAddress): OsErr;
FUNCTION SetADBInfo(VAR info: ADBSetInfoBlock; ADBAddr: ADBAddress): OsErr;

FUNCTION KeyTrans(transData: Ptr; keycode: INTEGER; VAR state: LONGINT): LONGINT;

{Memory Manager}

FUNCTION StripAddress(theAddress: AnAddress): AnAddress;

{Start Manager}

PROCEDURE GetDefaultStartup(defaultRecPtr: DefRecPtr);
PROCEDURE SetDefaultStartup(defaultRecPtr: DefRecPtr);
PROCEDURE GetVideoDefault(defaultVidPtr: DefVidPtr);
PROCEDURE SetVideoDefault(defaultVidPtr: DefVidPtr);
PROCEDURE SetOSDefault(defaultOSPtr: DefOSPtr);
PROCEDURE GetOSDefault(defaultOSPtr: DefOSPtr);

{Time Manager}

FUNCTION DTInstall(dtTaskPtr: QElemPtr) : OSErr;


END.


{
  File: OSIntf.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved
}


UNIT OSIntf;

INTERFACE

USES {$U MemTypes.p} MemTypes,
	 {$U QuickDraw.p} QuickDraw;

CONST

{for Event Manager}
everyEvent = -1;
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
app4Mask = -32768;

{to decipher event message for keyDown events}
charCodeMask = $000000FF;
keyCodeMask = $0000FF00;
adbAddrMask = $00FF0000;

{ modifiers }
controlKey = 4096; { Bit 4 of high byte }
optionKey = 2048; { Bit 3 of high byte }
alphaLock = 1024; { Bit 2 }
shiftKey = 512; { Bit 1 }
cmdKey = 256; 	{ Bit 0 }
btnState = 128; { Bit 7 of low byte is mouse button state }

activeFlag = 1; { bit 0 of modifiers for activate event }

{error for PostEvent}
evtNotEnb = 1;

{ General System Errors (VBL Mgr, Queueing, Etc.) }
noErr = 0; 		{ All is well }
qErr = -1; 	 	{ queue element not found during deletion }
vTypErr = -2; 	{ invalid queue element }
corErr = -3; 	{ core routine number out of range }
unimpErr = -4; 	{ unimplemented core routine }
seNoDB = -8;	{ no debugger installed to handle debugger command }

{ I/O System Errors }
controlErr		= -17;
statusErr		= -18;
readErr 		= -19;
writErr 		= -20;
badUnitErr		= -21;
unitEmptyErr	= -22;
openErr 		= -23;	{ attempt to open Serial driver failed }
closErr 		= -24;
dRemovErr		= -25;	{ tried to remove an open driver }
dInstErr		= -26;	{ DrvrInstall couldn't find driver in resources }
abortErr		= -27;	{ IO call aborted by KillIO }
iIOAbortErr		= -27;	{ IO abort error (Printing Manager) }
notOpenErr		= -28;	{ Couldn't rd/wr/ctl/sts cause driver not opened }

{file system error codes}
dirFulErr = -33; { Directory full }
dskFulErr = -34; { disk full }
nsVErr = -35; 	{ no such volume }
ioErr = -36; 	{ I/O error }
bdNamErr = -37; { bad name }
fnOpnErr = -38; { File not open }
eofErr = -39; 	{ End of file }
posErr = -40; 	{ tried to position to before start of file (r/w) }
mFulErr = -41; 	{ memory full(open) or file won't fit (load) }
tmFOErr = -42; 	{ too many files open }
fnFErr = -43; 	{ File not found }

wPrErr = -44; { diskette is write protected }
fLckdErr = -45; { file is locked }
vLckdErr = -46; { volume is locked }
fbsyErr = -47; { File is busy (delete) }
dupFNErr = -48;	{ duplicate filename (rename) }
opWrErr = -49; { file already open with with write permission }
paramErr = -50; { error in user parameter list }
rfNumErr = -51; { refnum error }
gfpErr = -52; { get file position error }
volOffLinErr = -53; { volume not on line error (was Ejected) }
permErr = -54; { permissions error (on file open) }
volOnLinErr = -55; { drive volume already on-line at MountVol }
nsDrvErr = -56; { no such drive (tried to mount a bad drive num) }
noMacDskErr = -57; { not a mac diskette (sig bytes are wrong) }
extFSErr = -58; { volume in question belongs to an external fs }
fsrnErr = -59; { file system rename error }
badMDBErr = -60; { bad master directory block }
wrPermErr = -61; { write permissions error }

lastDskErr = -64; { last in a range of disk errors }
noDriveErr = -64; { drive not installed }
offLinErr = -65; { r/w requested for an off-line drive }
noNybErr = -66; { couldn't find 5 nybbles in 200 tries }
noAdrMkErr = -67; { couldn't find valid addr mark }
dataVerErr = -68; { read verify compare failed }
badCksmErr = -69; { addr mark checksum didn't check }
badBtSlpErr = -70; { bad addr mark bit slip nibbles }
noDtaMkErr = -71; { couldn't find a data mark header }
badDCksum = -72; { bad data mark checksum }
badDBtSlp = -73; { bad data mark bit slip nibbles }
wrUnderrun = -74; { write underrun occurred }
cantStepErr = -75; { step handshake failed }
tk0BadErr = -76; { track 0 detect doesn't change }
initIWMErr = -77; { unable to initialize IWM }
twoSideErr = -78; { tried to read 2nd side on a 1-sided drive }
spdAdjErr = -79; { unable to correctly adjust disk speed }
seekErr = -80; { track number wrong on address mark }
sectNFErr = -81; { sector number never found on a track }
firstDskErr = -84; { first in a range of disk errors }

{for Memory Manager}
memFullErr = -108; 		{ Not enough room in heap zone }
nilHandleErr = -109;	{ Master Pointer was NIL in HandleZone or other }
memWZErr = -111;		{ WhichZone failed (applied to free block) }
memPurErr = -112; 		{ trying to purge a locked or non-purgeable block }
memLockedErr = -117;	{ Block is locked }

dirNFErr = -120;		{ Directory not found }
tmwdoErr = -121;		{ No free WDCB available }
badMovErr = -122;		{ Move into offspring error }
wrgVolTypErr = -123;	{ Wrong volume type error -
						operation not supported for MFS}
volGoneErr = -124;		{ Server volume has been disconnected. }

{System Error Alert ID definitions. These are just for reference because }
{ one cannot intercept the calls and do anything programmatically... }

dsSysErr	 = 32767;	{ general system error }
dsBusError	= 1; 		{ bus error } 
dsAddressErr = 2; 		{ address error }
dsIllInstErr = 3; 		{ illegal instruction error }
dsZeroDivErr = 4;		{ zero divide error }
dsChkErr	= 5; 		{ check trap error }
dsOvflowErr	= 6;		{ overflow trap error }
dsPrivErr	= 7; 		{ privelege violation error }
dsTraceErr	= 8; 		{ trace mode error }
dsLineAErr	= 9; 		{ line 1010 trap error }
dsLineFErr	= 10; 		{ line 1111 trap error }
dsMiscErr	= 11; 		{ miscellaneous hardware exception error }
dsCoreErr	= 12; 		{ unimplemented core routine error }
dsIrqErr	= 13; 		{ uninstalled interrupt error }

dsIOCoreErr	= 14; 		{ IO Core Error }
dsLoadErr	= 15; 		{ Segment Loader Error }
dsFPErr		= 16; 		{ Floating point error }

dsNoPackErr = 17; 		{ package 0 not present }
dsNoPk1		= 18; 		{ package 1 not present }
dsNoPk2		= 19; 		{ package 2 not present }
dsNoPk3		= 20; 		{ package 3 not present }
dsNoPk4		= 21; 		{ package 4 not present }
dsNoPk5		= 22; 		{ package 5 not present }
dsNoPk6		= 23; 		{ package 6 not present }
dsNoPk7		= 24; 		{ package 7 not present }

dsMemFullErr = 25;	 	{ out of memory! }
dsBadLaunch	= 26; 		{ can't launch file }

dsFSErr		= 27; 		{ file system map has been trashed }
dsStknHeap	= 28; 		{ stack has moved into application heap }
dsReinsert	= 30; 		{ request user to reinsert off-line volume }
dsNotThe1	= 31; 		{ not the disk I wanted }
negZcbFreeErr = 33; 	{ ZcbFree has gone negative }
dsGreeting	= 40;		{ welcome to Macintosh greeting }
dsFinderErr	= 41;		{ can't load the Finder error }
shutDownAlert = 42;		{ handled like a shutdown error }
menuPrgErr	= 84; 		{ happens when a menu is purged }


maxSize = $800000;		{ Max data block size is 8 megabytes }

{finder constants}
fOnDesk = 1;
fHasBundle = 8192;
fInvisible = 16384;
fTrash = -3;
fDesktop = -2;
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
ainRefNum = -6;		{serial port A input}
aoutRefNum = -7;	{serial port A output}
binRefNum = -8;		{serial port B input}
boutRefNum = -9;	{serial port B output}

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
stop15 = -32768;
stop20 = -16384;
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
swmode = -1;
ftmode = 1;
ffmode = 0;

{Desk Accessories - Message Definitions (in CSCode of Control Call)}

accEvent = 64; 	{event message from SystemEvent}
accRun = 65; 	{run message from SystemTask}
accCursor = 66; {cursor message from SystemTask}
accMenu = 67; 	{menu message from SystemMenu}
accUndo = 68; 	{undo message from SystemEdit}
accCut = 70; 	{cut message from SystemEdit}
accCopy = 71; 	{copy message from SystemEdit}
accPaste = 72; 	{paste message from SystemEdit}
accClear = 73; 	{clear message from SystemEdit}

goodbye = -1; {goodbye message}

{for "machine" parameter of Environs}
macXLMachine = 0;
macMachine = 1;

ioDirFlg = 3; 		{ IF BitTst( myParamBlk^.ioFlAttrib, ioDirFlg) THEN … }
ioDirMask = $10; 	{ IF BitAnd( myParamBlk^.ioFlAttrib, ioDirMask) = ioDirMask
					THEN … }
fsrtParID = 1; 		{ DirID of parent's root }
fsrtDirID = 2; 		{ Root DirID }

{ device manager - Chooser message values}

newSelMsg = 12; 	{ a new selection has been made}
fillListMsg = 13; 	{ fill the list with choices to be made}
getSelMsg = 14; 	{ mark one or more choices as selcted}
selectMsg = 15; 	{ a choice has actually been made}
deselectMsg = 16; 	{ a choice has been canceled}
terminateMsg = 17;	{ lets device package clean up}
buttonMsg = 19; 	{ a button has been clicked}

chooserID = 1;		{ caller value for the Chooser}

{ cdev message types }

initDev = 0;		{ Time for cdev to initialize itself }
hitDev = 1;			{ Hit on one of my items }
closeDev = 2;		{ Close yourself }
nulDev = 3;			{ Null event }
updateDev = 4;		{ Update event }
activDev = 5;		{ Activate event }
deactivDev = 6;		{ Deactivate event }
keyEvtDev = 7;		{ Key down/auto key }
macDev = 8;			{ Decide whether or not to show up }

{ cdev error codes }

cdevGenErr = -1;	{ General error; gray cdev w/o alert }
cdevMemErr = 0;		{ Memory shortfall; alert user please }
cdevResErr = 1;		{ Couldn't get a needed resource; alert }
cdevUnset = 3;		{ cdevValue is initialized to this }

{result types for RelString Call}

sortsBefore = -1;	{ first string < second string}
sortsEqual = 0; 	{ first string = second string}
sortsAfter = 1; 	{ first string > second string}

{ Masks for ShutDwnInstall procedure }

sdOnPowerOff	= 1;	{ call procedure before power off }
sdOnRestart		= 2;	{ call procedure before restart }
sdOnUnmount		= 4;	{ call procedure before unmounting }
sdOnDrivers		= 8;	{ call procedure before closing drivers }
sdRestartOrPower = 3;	{ call before either power off or restart }

{***** for 256K ROMs *****}

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

slotNumErr		=	-360;		{ invalid slot # error }

{ StatusFlags constants }

fCardIsChanged	=		1;		{ Card is Changed field in StatusFlags field of sInfoArray}

fCkForSame		=		0;		{ For SearchSRT. Flag to check for SAME sResource in the table. }
fCkForNext		=		1;		{ For SearchSRT. Flag to check for NEXT sResource in the table. }

fWarmStart		=		2;		{ If this bit is set then warm start, else cold start.}

false32b		=		0;		{ 24 bit addressing }
true32b			=		1;		{ 32 bit addressing }


{ State constants } 

stateNil		=		0;		{ State	:Nil}
stateSDMInit	=		1;		{		:Slot declaration manager Init}
statePRAMInit	=		2;		{		:sPRAM record init}
statePInit		=		3;		{		:Primary init}
stateSInit		=		4;		{		:Secondary init}


{  Sad Mac Equates (For NuMac). }
    
siInitSDTblErr      =     1;   	{ slot int dispatch table could not be initialized. }
siInitVBLQsErr      =     2;   	{ VBLqueues for all slots could not be initialized. }
siInitSPTblErr      =     3;    { slot priority table could not be initialized. }

sdmJTInitErr        =     10;	{ SDM Jump Table could not be initialized. }
sdmInitErr          =     11;	{ SDM could not be initialized. }
sdmSRTInitErr       =     12;	{ Slot Resource Table could not be initialized. }
sdmPRAMInitErr      =     13;	{ Slot PRAM could not be initialized. }
sdmPriInitErr       =     14;	{ Cards could not be initialized. }
	
{ SysEnvirons equates }

envMac		  = -1;			{returned by glue, if any}
envXL		  = -2;			{returned by glue, if any}
envMachUnknown = 0;
env512KE	  = 1;
envMacPlus	  = 2;
envSE		  = 3;
envMacII	  = 4;

envCPUUnknown = 0;			{ CPU types }
env68000	  = 1;
env68010	  = 2;
env68020	  = 3;

envUnknownKbd = 0;			{ Keyboard types }
envMacKbd	  = 1;
envMacAndPad  = 2;
envMacPlusKbd = 3;
envAExtendKbd = 4;
envStandADBKbd = 5;

{ SysEnvirons errors }

envNotPresent	=	-5500;		{ returned by glue. Official stuff now }
envBadSel		=	-5501;		{ Selector non-positive }
envSelTooBig	=	-5502;		{ Selector bigger than call can handle }


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
			evtQwhat: INTEGER; {this part is identical to the EventRecord as...}
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

	ParamBlkType = (IOParam, FileParam, VolumeParam, CntrlParam,
					SlotDevParam, MultiDevParam);

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

					{ following varients added for device manager }
					  SlotDevParam:
						(filler3: LONGINT;
						 ioMix: Ptr;
						 ioFlags: INTEGER;
						 ioSlot: SignedByte;
						 ioID: SignedByte);

					  MultiDevParam:
						(filler4: LONGINT;
						 ioMMix: Ptr;
						 ioMFlags: INTEGER;
						 ioSEBlkPtr: Ptr);

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
	{there are currently 4 types of queues: }
	{	VType	-   queue of Vertical Blanking Control Blocks }
	{   IOQType -   queue of I/0 queue elements }
	{   DrvType -   queue of drivers }
	{   EvType  -   queue of Event Records }
	{   FSQType -   queue of VCB elements }
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
				dCtlDriver: Ptr; {ptr to ROM or handle to RAM driver}
				dCtlFlags: INTEGER; {flags}
				dCtlQHdr: QHdr; {driver's i/o queue}
				dCtlPosition: LONGINT; {byte pos used by read and write calls}
				dCtlStorage: Handle; {hndl to RAM drivers private storage}
				dCtlRefNum: INTEGER; {driver's reference number}
				dCtlCurTicks: LONGINT; {counter for timing system task calls}
				dCtlWindow: Ptr; {ptr to driver's window if any}
				dCtlDelay: INTEGER; {number of ticks btwn sysTask calls}
				dCtlEMask: INTEGER; {desk acessory event mask}
				dCtlMenu: INTEGER; {menu ID of menu associated with driver}
			END; {DCtlEntry}
	DCtlPtr = ^DCtlEntry;
	DCtlHandle = ^DCtlPtr;

	{device control entry extended for slots}
	AuxDCE = PACKED RECORD
		{original DCE record}
				dCtlDriver: Ptr;		{ptr to ROM or handle to RAM driver}
				dCtlFlags: INTEGER;		{flags}
				dCtlQHdr: QHdr;			{driver's i/o queue}
				dCtlPosition: LONGINT;	{byte pos used by read and write calls}
				dCtlStorage: Handle;	{hndl to RAM drivers private storage}
				dCtlRefNum: INTEGER;	{driver's reference number}
				dCtlCurTicks: LONGINT;	{counter for timing system task calls}
				dCtlWindow: Ptr;		{ptr to driver's window if any}
				dCtlDelay: INTEGER;		{number of ticks btwn sysTask calls}
				dCtlEMask: INTEGER;		{desk acessory event mask}
				dCtlMenu: INTEGER;		{menu ID of menu associated with driver}
		{extensions to original DCE record}
				dCtlSlot: Byte;			{Slot}
				dCtlSlotId: Byte;		{Slot ID}
				dCtlDevBase: LONGINT;	{Base address of card for driver}
				dCtlOwner: Ptr;			{Task control block for owner of device}
				dCtlExtDev: Byte;		{External device ID}
				fillByte: Byte;			{Reserved}
			END; {SlotDCE}
	AuxDCEPtr = ^AuxDCE;
	AuxDCEHandle = ^AuxDCEPtr;


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
				  driveChar: SignedByte; {230 ($E6) for HD20}
				  driveMisc: SignedByte) {0 -- reserved}
		   END;

	{for Time Manager}

	TMTask = RECORD
			 qLink: QElemPtr; {next queue entry}
			 qType: INTEGER; {queue type}
			 tmAddr: ProcPtr; {pointer to task}
			 tmCount: LONGINT; {reserved}
		   END;

{***** for 256K ROMs *****}

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
		spIOReserved: INTEGER;		{Reserved field of Slot Resource Table}
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

				{Start Manager}

DefStartType = (slotDev, scsiDev);

DefStartRec	=	RECORD
			CASE DefStartType OF
			  slotDev:
				(sdExtDevID: SignedByte;
				 sdPartition: SignedByte;
				 sdSlotNum: SignedByte;
				 sdSRsrcID: SignedByte);
			  scsiDev:
				(sdReserved1: SignedByte;
				 sdReserved2: SignedByte;
				 sdRefNum: INTEGER);
			END;	{ StartDevPBRec }
DefStartPtr = ^DefStartRec;


DefVideoRec	=	RECORD
				sdSlot:			SignedByte;
				sdSResource:	SignedByte;
			END;
DefVideoPtr = ^DefVideoRec;


DefOSRec	=	RECORD
				sdReserved:	SignedByte;
				sdOSType:	SignedByte;
			END;
DefOSPtr = ^DefOSRec;

{ SysEnvirons data structure }

SysEnvRec	  =	RECORD
				environsVersion:	INTEGER;
				machineType:		INTEGER;
				systemVersion:		INTEGER;
				processor:			INTEGER;
				hasFPU:				BOOLEAN;
				hasColorQD:			BOOLEAN;
				keyBoardType:		INTEGER;
				atDrvrVersNum:		INTEGER;
				sysVRefNum:			INTEGER;
				END;


PROCEDURE Debugger; INLINE $A9FF;

PROCEDURE DebugStr(aStr: Str255); INLINE $ABFF;

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

{ MultiFinder calls }

FUNCTION MFMaxMem(VAR grow: Size): Size;
	INLINE	$3F3C, $0015, $A88F;
FUNCTION MFFreeMem: LONGINT;
	INLINE	$3F3C, $0018, $A88F;
FUNCTION MFTempNewHandle(logicalSize: Size; VAR resultCode: OSErr): Handle;
	INLINE	$3F3C, $001D, $A88F;
PROCEDURE MFTempHLock(h: Handle; VAR resultCode: OSErr);
	INLINE	$3F3C, $001E, $A88F;
PROCEDURE MFTempHUnLock(h: Handle; VAR resultCode: OSErr);
	INLINE	$3F3C, $001F, $A88F;
PROCEDURE MFTempDisposHandle(h: Handle; VAR resultCode: OSErr);
	INLINE	$3F3C, $0020, $A88F;

{interface for core routines pertaining to the vertical retrace mgr}
{routines defined in VBLCORE.TEXT}

FUNCTION VInstall(vblTaskPtr: QElemPtr): OSErr;

FUNCTION VRemove(vblTaskPtr: QElemPtr): OSErr;

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

{FUNCTION PBSetPEOF(paramBlock: HParmBlkPtr; aSync: BOOLEAN): OSErr;}		

FUNCTION PBHGetVolParms(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHGetLogInInfo(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHGetDirAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHSetDirAccess(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHMapID(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHMapName(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHCopyFile(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHMoveRename(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHOpenDeny(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION PBHOpenRFDeny(paramBlock: HParmBlkPtr; async: BOOLEAN): OSErr;

FUNCTION FSOpen(fileName: Str255; vRefNum: INTEGER;
				VAR refNum: INTEGER): OSErr;

FUNCTION FSClose(refNum: INTEGER): OSErr;

FUNCTION FSRead(refNum: INTEGER; VAR count: LONGINT; buffPtr: Ptr): OSErr;

FUNCTION FSWrite(refNum: INTEGER; VAR count: LONGINT; buffPtr: Ptr): OSErr;

FUNCTION Control(refNum: INTEGER; csCode: INTEGER; csParamPtr: Ptr): OSErr;

FUNCTION Status(refNum: INTEGER; csCode: INTEGER; csParamPtr: Ptr): OSErr;

FUNCTION KillIO(refNum: INTEGER): OSErr;

{-volume level calls-}

FUNCTION GetVInfo(drvNum: INTEGER; volName: StringPtr; VAR vRefNum: INTEGER;
				  VAR freeBytes: LONGINT): OSErr;

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

FUNCTION GetFInfo(fileName: Str255; vRefNum: INTEGER;
				  VAR fndrInfo: FInfo): OSErr;

FUNCTION SetFInfo(fileName: Str255; vRefNum: INTEGER; fndrInfo: FInfo): OSErr;

FUNCTION SetFLock(fileName: Str255; vRefNum: INTEGER): OSErr;

FUNCTION RstFLock(fileName: Str255; vRefNum: INTEGER): OSErr;

{-file level calls for opened files-}

FUNCTION Allocate(refNum: INTEGER; VAR count: LONGINT): OSErr;

FUNCTION GetEOF(refNum: INTEGER; VAR logEOF: LONGINT): OSErr;

FUNCTION SetEOF(refNum: INTEGER; logEOF: LONGINT): OSErr;

FUNCTION GetFPos(refNum: INTEGER; VAR filePos: LONGINT): OSErr;

FUNCTION SetFPos(refNum: INTEGER; posMode: INTEGER; posOff: LONGINT): OSErr;

FUNCTION GetVRefNum(fileRefNum: INTEGER; VAR vRefNum: INTEGER): OSErr;

{Serial Driver Interface}

FUNCTION OpenDriver(name: Str255; VAR drvrRefNum: INTEGER): OSErr;

FUNCTION CloseDriver(refNum: INTEGER): OSErr;

FUNCTION SerReset(refNum: INTEGER; serConfig: INTEGER): OSErr;

FUNCTION SerSetBuf(refNum: INTEGER; serBPtr: Ptr; serBLen: INTEGER): OSErr;

FUNCTION SerHShake(refNum: INTEGER; flags: SerShk): OSErr;

FUNCTION SerSetBrk(refNum: INTEGER): OSErr;

FUNCTION SerClrBrk(refNum: INTEGER): OSErr;

FUNCTION SerGetBuf(refNum: INTEGER; VAR count: LONGINT): OSErr;

FUNCTION SerStatus(refNum: INTEGER; VAR serSta: SerStaRec): OSErr;

FUNCTION DiskEject(drvNum: INTEGER): OSErr;

FUNCTION SetTagBuffer(buffPtr: Ptr): OSErr;

FUNCTION DriveStatus(drvNum: INTEGER; VAR status: DrvSts): OSErr;

FUNCTION RamSDOpen(whichPort: SPortSel): OSErr;

PROCEDURE RamSDClose(whichPort: SPortSel);

{for Sound Driver}

PROCEDURE SetSoundVol(level: INTEGER);

PROCEDURE GetSoundVol(VAR level: INTEGER);

PROCEDURE StartSound(synthRec: Ptr; numBytes: LONGINT;
					 completionRtn: ProcPtr);

PROCEDURE StopSound;

FUNCTION SoundDone: BOOLEAN;

{for the system error handler}

PROCEDURE SysError(errorCode: INTEGER);
  INLINE $301F, $A9C9;

{for the Time Manager}

PROCEDURE InsTime(tmTaskPtr: QElemPtr);

PROCEDURE RmvTime(tmTaskPtr: QElemPtr);

PROCEDURE PrimeTime(tmTaskPtr: QElemPtr; count: LONGINT);

{ ShutDown is new, but works with all machines with new system. }
PROCEDURE ShutDwnPower;
	INLINE $3F3C,$0001,$A895;
PROCEDURE ShutDwnStart;
	INLINE $3F3C,$0002,$A895;
PROCEDURE ShutDwnInstall(shutDwnProc: ProcPtr; flags: INTEGER);
	INLINE $3F3C,$0003,$A895;
PROCEDURE ShutDwnRemove(shutDwnProc: ProcPtr);
	INLINE $3F3C,$0004,$A895;

{ for 128K ROMs }

FUNCTION RelString(aStr, bStr: Str255; caseSens, diacSens: BOOLEAN): INTEGER;

{interface for Operating System Dispatcher}
{routines defined in DISPATCH.TEXT}

FUNCTION GetTrapAddress(trapNum: INTEGER): LONGINT;

PROCEDURE SetTrapAddress(trapAddr: LONGINT; trapNum: INTEGER);

FUNCTION NGetTrapAddress(trapNum: INTEGER; tTyp: TrapType): LONGINT;

PROCEDURE NSetTrapAddress(trapAddr: LONGINT; trapNum: INTEGER;
						  tTyp: TrapType);

{***** for 256K ROMs *****}

{Device Manager Slot Support}

FUNCTION SIntInstall(sIntQElemPtr: SQElemPtr; theSlot: INTEGER ): OsErr;
FUNCTION SIntRemove(sIntQElemPtr: SQElemPtr; theSlot: INTEGER): OsErr;

FUNCTION SetChooserAlert(f: BOOLEAN): BOOLEAN;


{Slot Declaration Manager}
		{ Principle }
FUNCTION SReadByte(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadWord(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadLong(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SGetcString(spBlkPtr: SpBlockPtr): OSErr;
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
FUNCTION SCkCardStat(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadDrvrName(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SFindDevBase(spBlkPtr: SpBlockPtr): OSErr;

		{ Advanced }
FUNCTION InitSDeclMgr(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SPrimaryInit(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SCardChanged(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SExec(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SOffsetData(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SInitPRAMRecs(spBlkPtr: SpBlockPtr): OSErr;
FUNCTION SReadPBSize(spBlkPtr: SpBlockPtr): OSErr;
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

FUNCTION OpenSlot(paramBlock: ParmBlkPtr; aSync: BOOLEAN): OSErr;


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

FUNCTION StripAddress(theAddress: Ptr): Ptr;

{Start Manager}

PROCEDURE GetDefaultStartup(paramBlock: DefStartPtr);
PROCEDURE SetDefaultStartup(paramBlock: DefStartPtr);
PROCEDURE GetVideoDefault(paramBlock: DefVideoPtr);
PROCEDURE SetVideoDefault(paramBlock: DefVideoPtr);
PROCEDURE SetOSDefault(paramBlock: DefOSPtr);
PROCEDURE GetOSDefault(paramBlock: DefOSPtr);
PROCEDURE GetTimeout(VAR count: INTEGER);
PROCEDURE SetTimeout(count: INTEGER);

{OS Util}

FUNCTION DTInstall(dtTaskPtr: QElemPtr) : OSErr;

FUNCTION GetMMUMode: SignedByte;
PROCEDURE SwapMMUMode(VAR mode: SignedByte);

FUNCTION SysEnvirons(versionRequested: INTEGER; VAR theWorld: SysEnvRec): OSErr;


END.


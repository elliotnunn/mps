{
Created: Wednesday, September 7, 1988 at 4:03 PM
    Errors.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Errors;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingErrors}
{$SETC UsingErrors := 1}


CONST
qErr = -1;                  {queue element not found during deletion}
vTypErr = -2;               {invalid queue element}
corErr = -3;                {core routine number out of range}
unimpErr = -4;              {unimplemented core routine}
seNoDB = -8;                {no debugger installed to handle debugger command}
controlErr = -17;           {I/O System Errors}
statusErr = -18;            {I/O System Errors}
readErr = -19;              {I/O System Errors}
writErr = -20;              {I/O System Errors}
badUnitErr = -21;           {I/O System Errors}
unitEmptyErr = -22;         {I/O System Errors}
openErr = -23;              {I/O System Errors}
closErr = -24;              {I/O System Errors}
dRemovErr = -25;            {tried to remove an open driver}
dInstErr = -26;             {DrvrInstall couldn't find driver in resources }
abortErr = -27;             {IO call aborted by KillIO}
iIOAbortErr = -27;          {IO abort error (Printing Manager)}
notOpenErr = -28;           {Couldn't rd/wr/ctl/sts cause driver not opened}
dirFulErr = -33;            {Directory full}
dskFulErr = -34;            {disk full}
nsvErr = -35;               {no such volume}
ioErr = -36;                {I/O error (bummers)}
bdNamErr = -37;             {there may be no bad names in the final system!}
fnOpnErr = -38;             {File not open}
eofErr = -39;               {End of file}
posErr = -40;               {tried to position to before start of file (r/w)}
mFulErr = -41;              {memory full (open) or file won't fit (load)}
tmfoErr = -42;              {too many files open}
fnfErr = -43;               {File not found}
wPrErr = -44;               {diskette is write protected.}
fLckdErr = -45;             {file is locked}
vLckdErr = -46;             {volume is locked}
fBsyErr = -47;              {File is busy (delete)}
dupFNErr = -48;             {duplicate filename (rename)}
opWrErr = -49;              {file already open with with write permission}
paramErr = -50;             {error in user parameter list}
rfNumErr = -51;             {refnum error}
gfpErr = -52;               {get file position error}
volOffLinErr = -53;         {volume not on line error (was Ejected)}
permErr = -54;              {permissions error (on file open)}
volOnLinErr = -55;          {drive volume already on-line at MountVol}
nsDrvErr = -56;             {no such drive (tried to mount a bad drive num)}
noMacDskErr = -57;          {not a mac diskette (sig bytes are wrong)}
extFSErr = -58;             {volume in question belongs to an external fs}
fsRnErr = -59;              {file system internal error:during rename the old entry was deleted but could not be restored.}
badMDBErr = -60;            {bad master directory block}
wrPermErr = -61;            {write permissions error}
fontDecError = -64;         {error during font declaration}
lastDskErr = -64;           {I/O System Errors}
noDriveErr = -64;           {drive not installed}
offLinErr = -65;            {r/w requested for an off-line drive}
fontNotDeclared = -65;      {font not declared}
noNybErr = -66;             {couldn't find 5 nybbles in 200 tries}
fontSubErr = -66;           {font substitution occured}
noAdrMkErr = -67;           {couldn't find valid addr mark}
dataVerErr = -68;           {read verify compare failed}
badCksmErr = -69;           {addr mark checksum didn't check}
badBtSlpErr = -70;          {bad addr mark bit slip nibbles}
noDtaMkErr = -71;           {couldn't find a data mark header}
badDCksum = -72;            {bad data mark checksum}
badDBtSlp = -73;            {bad data mark bit slip nibbles}
wrUnderrun = -74;           {write underrun occurred}
cantStepErr = -75;          {step handshake failed}
tk0BadErr = -76;            {track 0 detect doesn't change}
initIWMErr = -77;           {unable to initialize IWM}
twoSideErr = -78;           {tried to read 2nd side on a 1-sided drive}
spdAdjErr = -79;            {unable to correctly adjust disk speed}
seekErr = -80;              {track number wrong on address mark}
sectNFErr = -81;            {sector number never found on a track}
fmt1Err = -82;              {can't find sector 0 after track format}
fmt2Err = -83;              {can't get enough sync}
verErr = -84;               {track failed to verify}
firstDskErr = -84;          {I/O System Errors}
clkRdErr = -85;             {unable to read same clock value twice}
clkWrErr = -86;             {time written did not verify}
prWrErr = -87;              {parameter ram written didn't read-verify}
prInitErr = -88;            {InitUtil found the parameter ram uninitialized}
rcvrErr = -89;              {SCC receiver error (framing; parity; OR)}
breakRecd = -90;            {Break received (SCC)}
ddpSktErr = -91;            {error in soket number}
ddpLenErr = -92;            {data length too big}
noBridgeErr = -93;          {no network bridge for non-local send}
lapProtErr = -94;           {error in attaching/detaching protocol}
excessCollsns = -95;        {excessive collisions on write}
portInUse = -97;            {driver Open error code (port is in use)}
portNotCf = -98;            {driver Open error code (parameter RAM not configured for this connection)}
memROZErr = -99;            {hard error in ROZ}
noScrapErr = -100;          {No scrap exists error}
noTypeErr = -102;           {No object of that type in scrap}
memFullErr = -108;          {Not enough room in heap zone}
nilHandleErr = -109;        {Master Pointer was NIL in HandleZone or other}
memAdrErr = -110;           {address was odd; or out of range}
memWZErr = -111;            {WhichZone failed (applied to free block)}
memPurErr = -112;           {trying to purge a locked or non-purgeable block}
memAZErr = -113;            {Address in zone check failed}
memPCErr = -114;            {Pointer Check failed}
memBCErr = -115;            {Block Check failed}
memSCErr = -116;            {Size Check failed}
memLockedErr = -117;        {trying to move a locked block (MoveHHi)}
dirNFErr = -120;            {Directory not found}
tmwdoErr = -121;            {No free WDCB available}
badMovErr = -122;           {Move into offspring error}
wrgVolTypErr = -123;        {Wrong volume type error [operation not supported for MFS]}
volGoneErr = -124;          {Server volume has been disconnected.}
fsDSIntErr = -127;          {Internal file system error}
resNotFound = -192;         {Resource not found}
resFNotFound = -193;        {Resource file not found}
addResFailed = -194;        {AddResource failed}
addRefFailed = -195;        {AddReference failed}
rmvResFailed = -196;        {RmveResource failed}
rmvRefFailed = -197;        {RmveReference failed}
resAttrErr = -198;          {attribute inconsistent with operation}
mapReadErr = -199;          {map inconsistent with operation}
nbpBuffOvr = -1024;         {Buffer overflow in LookupName}
nbpNoConfirm = -1025;
nbpConfDiff = -1026;        {Name confirmed at different socket}
nbpDuplicate = -1027;       {Duplicate name exists already}
nbpNotFound = -1028;        {Name not found on remove}
nbpNISErr = -1029;          {Error trying to open the NIS}
aspBadVersNum = -1066;      {Server cannot support this ASP version}
aspBufTooSmall = -1067;     {Buffer too small}
aspNoMoreSess = -1068;      {No more sessions on server}
aspNoServers = -1069;       {No servers at that address}
aspParamErr = -1070;        {Parameter error}
aspServerBusy = -1071;      {Server cannot open another session}
aspSessClosed = -1072;      {Session closed}
aspSizeErr = -1073;         {Command block too big}
aspTooMany = -1074;         {Too many clients (server error)}
aspNoAck = -1075;           {No ack on attention request (server err)}
reqFailed = -1096;
tooManyReqs = -1097;
tooManySkts = -1098;
badATPSkt = -1099;
badBuffNum = -1100;
noRelErr = -1101;
cbNotFound = -1102;
noSendResp = -1103;
noDataArea = -1104;
reqAborted = -1105;
buf2SmallErr = -3101;
noMPPErr = -3102;
ckSumErr = -3103;
extractErr = -3104;
readQErr = -3105;
atpLenErr = -3106;
atpBadRsp = -3107;
recNotFnd = -3108;
sktClosedErr = -3109;
afpAccessDenied = -5000;
afpAuthContinue = -5001;
afpBadUAM = -5002;
afpBadVersNum = -5003;
afpBitmapErr = -5004;
afpCantMove = -5005;
afpDenyConflict = -5006;
afpDirNotEmpty = -5007;
afpDiskFull = -5008;
afpEofError = -5009;
afpFileBusy = -5010;
afpFlatVol = -5011;
afpItemNotFound = -5012;
memROZWarn = -99;           {soft error in ROZ}
afpLockErr = -5013;
afpMiscErr = -5014;
afpNoMoreLocks = -5015;
afpNoServer = -5016;
afpObjectExists = -5017;
afpObjectNotFound = -5018;
afpParmErr = -5019;
afpRangeNotLocked = -5020;
afpRangeOverlap = -5021;
afpSessClosed = -5022;
afpUserNotAuth = -5023;
afpCallNotSupported = -5024;
afpObjectTypeErr = -5025;
afpTooManyFilesOpen = -5026;
afpServerGoingDown = -5027;
afpCantRename = -5028;
afpDirNotFound = -5029;
afpIconTypeError = -5030;
afpVolLocked = -5031;       {Volume is Read-Only}
afpObjectLocked = -5032;    {Object is M/R/D/W inhibited}
envNotPresent = -5500;      {returned by glue.}
envBadVers = -5501;         {Version non-positive}
envVersTooBig = -5502;      {Version bigger than call can handle}
evtNotEnb = 1;              {event not enabled at PostEvent}
dsSysErr = 32767;           {general system error}
dsBusError = 1;             {bus error }
dsAddressErr = 2;           {address error}
dsIllInstErr = 3;           {illegal instruction error}
dsZeroDivErr = 4;           {zero divide error}
dsChkErr = 5;               {check trap error}
dsOvflowErr = 6;            {overflow trap error}
dsPrivErr = 7;              {privilege violation error}
dsTraceErr = 8;             {trace mode error}
dsLineAErr = 9;             {line 1010 trap error}
dsLineFErr = 10;            {line 1111 trap error}
dsMiscErr = 11;             {miscellaneous hardware exception error}
dsCoreErr = 12;             {unimplemented core routine error}
dsIrqErr = 13;              {uninstalled interrupt error}
dsIOCoreErr = 14;           {IO Core Error}
dsLoadErr = 15;             {Segment Loader Error}
dsFPErr = 16;               {Floating point error}
dsNoPackErr = 17;           {package 0 not present}
dsNoPk1 = 18;               {package 1 not present}
dsNoPk2 = 19;               {package 2 not present}
dsNoPk3 = 20;               {package 3 not present}
dsNoPk4 = 21;               {package 4 not present}
dsNoPk5 = 22;               {package 5 not present}
dsNoPk6 = 23;               {package 6 not present}
dsNoPk7 = 24;               {package 7 not present}
dsMemFullErr = 25;          {out of memory!}
dsBadLaunch = 26;           {can't launch file}
dsFSErr = 27;               {file system map has been trashed}
dsStknHeap = 28;            {stack has moved into application heap}
dsReinsert = 30;            {request user to reinsert off-line volume}
dsNotThe1 = 31;             {not the disk I wanted}
negZcbFreeErr = 33;         {ZcbFree has gone negative}
dsGreeting = 40;            {welcome to Macintosh greeting}
dsFinderErr = 41;           {can't load the Finder error}
shutDownAlert = 42;         {handled like a shutdown error}
menuPrgErr = 84;            {happens when a menu is purged}
swOverrunErr = 1;           {serial driver error masks}
parityErr = 16;             {serial driver error masks}
hwOverrunErr = 32;          {serial driver error masks}
framingErr = 64;            {serial driver error masks}
cMatchErr = -150;           {Color2Index failed to find an index}
cTempMemErr = -151;         {failed to allocate memory for temporary structures}
cNoMemErr = -152;           {failed to allocate memory for structure}
cRangeErr = -153;           {range error on colorTable request}
cProtectErr = -154;         {colorTable entry protection violation}
cDevErr = -155;             {invalid type of graphics device}
cResErr = -156;             {invalid resolution for MakeITable}
unitTblFullErr = -29;       {unit table has no more entries}
dceExtErr = -30;            {dce extension error}
dsBadSlotInt = 51;          {unserviceable slot interrupt}
dsBadSANEopcode = 81;       {bad opcode given to SANE Pack4}
dsNoPatch = 98;             {Can't patch for particular Model Mac}
dsBadPatch = 99;            {Can't load patch resource}
updPixMemErr = -125;        {insufficient memory to update a pixmap}
mBarNFnd = -126;            {system error code for MBDF not found}
hMenuFindErr = -127;        {could not find HMenu's parent in MenuKey}
noHardware = -200;          {Sound Manager Error Returns}
notEnoughHardware = -201;   {Sound Manager Error Returns}
queueFull = -203;           {Sound Manager Error Returns}
resProblem = -204;          {Sound Manager Error Returns}
badChannel = -205;          {Sound Manager Error Returns}
badFormat = -206;           {Sound Manager Error Returns}
smSDMInitErr = -290;        {Error; SDM could not be initialized.}
smSRTInitErr = -291;        {Error; Slot Resource Table could not be initialized.}
smPRAMInitErr = -292;       {Error; Slot Resource Table could not be initialized.}
smPriInitErr = -293;        {Error; Cards could not be initialized.}
nmTypErr = -299;
smEmptySlot = -300;         {No card in slot}
smCRCFail = -301;           {CRC check failed for declaration data}
smFormatErr = -302;         {FHeader Format is not Apple's}
smRevisionErr = -303;       {Wrong revison level}
smNoDir = -304;             {Directory offset is Nil }
smLWTstBad = -305;          {Long Word test field <> $5A932BC7.}
smNosInfoArray = -306;      {No sInfoArray. Memory Mgr error.}
smResrvErr = -307;          {Fatal reserved error. Resreved field <> 0.}
smUnExBusErr = -308;        {Unexpected BusError}
smBLFieldBad = -309;        {ByteLanes field was bad.}
smFHBlockRdErr = -310;      {Error occured during _sGetFHeader.}
smDisposePErr = -312;       {_DisposePointer error}
smNoBoardsRsrc = -313;      {No Board sResource.}
smGetPRErr = -314;          {Error occured during _sGetPRAMRec (See SIMStatus).}
smNoBoardId = -315;         {No Board Id.}
smInitStatVErr = -316;      {The InitStatusV field was negative after primary or secondary init.}
smInitTblErr = -317;        {An error occured while trying to initialize the Slot Resource Table.}
smNoJmpTbl = -318;          {SDM jump table could not be created.}
smBadBoardId = -319;        {BoardId was wrong; re-init the PRAM record.}
smBusErrTO = -320;          {BusError time out.}
smBadRefId = -330;          {Reference Id not found in List}
smBadsList = -331;          {Bad sList: Id1 < Id2 < Id3 ...format is not followed.}
smReservedErr = -332;       {Reserved field not zero}
smCodeRevErr = -333;        {Code revision is wrong}
smCPUErr = -334;            {Code revision is wrong}
smsPointerNil = -335;       {LPointer is nil From sOffsetData. If this error occurs; check sInfo rec for more information.}
smNilsBlockErr = -336;      {Nil sBlock error (Dont allocate and try to use a nil sBlock)}
smSlotOOBErr = -337;        {Slot out of bounds error}
smSelOOBErr = -338;         {Selector out of bounds error}
smNewPErr = -339;           {_NewPtr error}
smBlkMoveErr = -340;        {_BlockMove error}
smCkStatusErr = -341;       {Status of slot = fail.}
smGetDrvrNamErr = -342;     {Error occured during _sGetDrvrName.}
smDisDrvrNamErr = -343;     {Error occured during _sDisDrvrName.}
smNoMoresRsrcs = -344;      {No more sResources}
smsGetDrvrErr = -345;       {Error occurred during _sGetDriver.}
smBadsPtrErr = -346;        {Bad pointer was passed to sCalcsPointer}
smByteLanesErr = -347;      {NumByteLanes was determined to be zero.}
smOffsetErr = -348;         {Offset was too big (temporary error}
smNoGoodOpens = -349;       {No opens were successfull in the loop.}
smSRTOvrFlErr = -350;       {SRT over flow.}
smRecNotFnd = -351;         {Record not found in the SRT.}
slotNumErr = -360;          {invalid slot # error}
gcrOnMFMErr = -400;         {gcr format on high density media error}
rgnTooBigErr = -500;
teScrapSizeErr = -501;      {scrap item too big for text edit record}
hwParamErr = -502;          {bad selector for _HWPriv}

{  The following errors are for primary or secondary init code.  The errors are logged in the
vendor status field of the sInfo record.  Normally the vendor error is not Apple's concern,
but a special error is needed to patch secondary inits.

 }

svTempDisable = -32768;     {Temporarily disable card but run primary init.}
svDisabled = -32640;        {Reserve range -32640 to -32768 for Apple temp disables.}
siInitSDTblErr = 1;         {slot int dispatch table could not be initialized.}
siInitVBLQsErr = 2;         {VBLqueues for all slots could not be initialized.}
siInitSPTblErr = 3;         {slot priority table could not be initialized.}
sdmJTInitErr = 10;          {SDM Jump Table could not be initialized.}
sdmInitErr = 11;            {SDM could not be initialized.}
sdmSRTInitErr = 12;         {Slot Resource Table could not be initialized.}
sdmPRAMInitErr = 13;        {Slot PRAM could not be initialized.}
sdmPriInitErr = 14;         {Cards could not be initialized.}
dsMBarNFnd = 85;            {Menu Manager Errors}
dsHMenuFindErr = 86;        {Menu Manager Errors}



PROCEDURE SysError(errorCode: INTEGER);
    INLINE $301F,$A9C9;

{$ENDC}    { UsingErrors }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


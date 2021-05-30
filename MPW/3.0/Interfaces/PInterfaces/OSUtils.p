{
Created: Tuesday, November 22, 1988 at 11:00 AM
    OSUtils.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved
    
    Dont use:
    -SetUpA5
    -RestoreA5
    Instead:
    SetUpA5 --> myA5 = SetCurrentA5();
    RestoreA5 --> oldA5 = SetA5(myA5);
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT OSUtils;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingOSUtils}
{$SETC UsingOSUtils := 1}

{$I+}
{$SETC OSUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := OSUtilsIncludes}

CONST
useFree = 0;
useATalk = 1;
useAsync = 2;
useExtClk = 3;                      {Externally clocked}
useMIDI = 4;
curSysEnvVers = 1;                  {Updated to equal latest SysEnvirons version}
macXLMachine = 0;
macMachine = 1;
envMac = -1;                        {Environs Equates}
envXL = -2;                         {Environs Equates}
envMachUnknown = 0;                 {Environs Equates}
env512KE = 1;                       {Environs Equates}
envMacPlus = 2;                     {Environs Equates}
envSE = 3;                          {Environs Equates}
envMacII = 4;                       {Environs Equates}
envMacIIx = 5;                      {Environs Equates}
envCPUUnknown = 0;                  {CPU types}
env68000 = 1;
env68010 = 2;
env68020 = 3;
env68030 = 4;
envUnknownKbd = 0;                  {Keyboard types}
envMacKbd = 1;
envMacAndPad = 2;
envMacPlusKbd = 3;
envAExtendKbd = 4;
envStandADBKbd = 5;
false32b = 0;                       {24 bit addressing error}
true32b = 1;                        {32 bit addressing error}

{ result types for RelString Call }

sortsBefore = -1;                   {first string < second string}
sortsEqual = 0;                     {first string = second string}
sortsAfter = 1;                     {first string > second string}


TYPE

QTypes = (dummyType,vType,ioQType,drvQType,evType,fsQType );

TrapType = (OSTrap,ToolTrap);

ParamBlkType = (IOParam,FileParam,VolumeParam,CntrlParam,SlotDevParam,MultiDevParam,
    AccessParam,ObjParam,CopyParam,WDParam);

SysPPtr = ^SysParmType;
SysParmType = PACKED RECORD
    valid: Byte;
    aTalkA: Byte;
    aTalkB: Byte;
    config: Byte;
    portA: INTEGER;
    portB: INTEGER;
    alarm: LONGINT;
    font: INTEGER;
    kbdPrint: INTEGER;
    volClik: INTEGER;
    misc: INTEGER;
    END;

QElemPtr = ^QElem;

FInfo = RECORD
    fdType: OSType;                     {the type of the file}
    fdCreator: OSType;                  {file's creator}
    fdFlags: INTEGER;                   {flags ex. hasbundle,invisible,locked, etc.}
    fdLocation: Point;                  {file's location in folder}
    fdFldr: INTEGER;                    {folder containing file}
    END;

VCB = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
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
    vcbClpSiz: LONGINT;
    vcbAlBlSt: INTEGER;
    vcbNxtCNID: LONGINT;
    vcbFreeBks: INTEGER;
    vcbVN: Str27;
    vcbDrvNum: INTEGER;
    vcbDRefNum: INTEGER;
    vcbFSID: INTEGER;
    vcbVRefNum: INTEGER;
    vcbMAdr: Ptr;
    vcbBufAdr: Ptr;
    vcbMLen: INTEGER;
    vcbDirIndex: INTEGER;
    vcbDirBlk: INTEGER;
    vcbVolBkUp: LONGINT;
    vcbVSeqNum: INTEGER;
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
    vcbXTAlBlks: INTEGER;
    vcbCTAlBlks: INTEGER;
    vcbXTRef: INTEGER;
    vcbCTRef: INTEGER;
    vcbCtlBuf: Ptr;
    vcbDirIDM: LONGINT;
    vcbOffsM: INTEGER;
    END;

DrvQElPtr = ^DrvQEl;
DrvQEl = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    dQDrive: INTEGER;
    dQRefNum: INTEGER;
    dQFSID: INTEGER;
    dQDrvSz: INTEGER;
    dQDrvSz2: INTEGER;
    END;

ParmBlkPtr = ^ParamBlockRec;
ParamBlockRec = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    ioTrap: INTEGER;
    ioCmdAddr: Ptr;
    ioCompletion: ProcPtr;
    ioResult: OSErr;
    ioNamePtr: StringPtr;
    ioVRefNum: INTEGER;
    CASE ParamBlkType OF
      IOParam:
        (ioRefNum: INTEGER;
        ioVersNum: SignedByte;
        ioPermssn: SignedByte;
        ioMisc: Ptr;
        ioBuffer: Ptr;
        ioReqCount: LONGINT;
        ioActCount: LONGINT;
        ioPosMode: INTEGER;
        ioPosOffset: LONGINT);
      FileParam:
        (ioFRefNum: INTEGER;
        ioFVersNum: SignedByte;
        filler1: SignedByte;
        ioFDirIndex: INTEGER;
        ioFlAttrib: SignedByte;
        ioFlVersNum: SignedByte;
        ioFlFndrInfo: FInfo;
        ioFlNum: LONGINT;
        ioFlStBlk: INTEGER;
        ioFlLgLen: LONGINT;
        ioFlPyLen: LONGINT;
        ioFlRStBlk: INTEGER;
        ioFlRLgLen: LONGINT;
        ioFlRPyLen: LONGINT;
        ioFlCrDat: LONGINT;
        ioFlMdDat: LONGINT);
      VolumeParam:
        (filler2: LONGINT;
        ioVolIndex: INTEGER;
        ioVCrDate: LONGINT;
        ioVLsBkUp: LONGINT;
        ioVAtrb: INTEGER;
        ioVNmFls: INTEGER;
        ioVDirSt: INTEGER;
        ioVBlLn: INTEGER;
        ioVNmAlBlks: INTEGER;
        ioVAlBlkSiz: LONGINT;
        ioVClpSiz: LONGINT;
        ioAlBlSt: INTEGER;
        ioVNxtFNum: LONGINT;
        ioVFrBlk: INTEGER);
      CntrlParam:
        (ioCRefNum: INTEGER;
        csCode: INTEGER;
        csParam: ARRAY [0..10] OF INTEGER);
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
    END;

EvQElPtr = ^EvQEl;
EvQEl = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    evtQWhat: INTEGER;      {this part is identical to the EventRecord as...}
    evtQMessage: LONGINT;   {defined in ToolIntf}
    evtQWhen: LONGINT;
    evtQWhere: Point;
    evtQModifiers: INTEGER;
    END;

VBLTask = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    vblAddr: ProcPtr;
    vblCount: INTEGER;
    vblPhase: INTEGER;
    END;

QElem = RECORD
    CASE QTypes OF
      vType:
        (vblQElem: VBLTask);        {vertical blanking}
      ioQType:
        (ioQElem: ParamBlockRec);   {I/O parameter block}
      drvQType:
        (drvQElem: DrvQEl);         {drive}
      evType:
        (evQElem: EvQEl);           {event}
      fsQType:
        (vcbQElem: VCB);            {volume control block}
    END;

QHdrPtr = ^QHdr;
QHdr = RECORD
    qFlags: INTEGER;
    qHead: QElemPtr;
    qTail: QElemPtr;
    END;

DateTimeRec = RECORD
    year: INTEGER;
    month: INTEGER;
    day: INTEGER;
    hour: INTEGER;
    minute: INTEGER;
    second: INTEGER;
    dayOfWeek: INTEGER;
    END;

SysEnvRec = RECORD
    environsVersion: INTEGER;
    machineType: INTEGER;
    systemVersion: INTEGER;
    processor: INTEGER;
    hasFPU: BOOLEAN;
    hasColorQD: BOOLEAN;
    keyBoardType: INTEGER;
    atDrvrVersNum: INTEGER;
    sysVRefNum: INTEGER;
    END;



FUNCTION GetSysPPtr: SysPPtr;
PROCEDURE SysBeep(duration: INTEGER);
    INLINE $A9C8;
FUNCTION KeyTrans(transData: Ptr;keycode: INTEGER;VAR state: LONGINT): LONGINT;
    INLINE $A9C3;
FUNCTION DTInstall(dtTaskPtr: QElemPtr): OSErr;
FUNCTION GetMMUMode: SignedByte;
PROCEDURE SwapMMUMode(VAR mode: SignedByte);
FUNCTION SysEnvirons(versionRequested: INTEGER;VAR theWorld: SysEnvRec): OSErr;
FUNCTION ReadDateTime(VAR time: LONGINT): OSErr;
PROCEDURE GetDateTime(VAR secs: LONGINT);
FUNCTION SetDateTime(time: LONGINT): OSErr;
PROCEDURE SetTime(d: DateTimeRec);
PROCEDURE GetTime(VAR d: DateTimeRec);
PROCEDURE Date2Secs(d: DateTimeRec;VAR s: LONGINT);
PROCEDURE Secs2Date(s: LONGINT;VAR d: DateTimeRec);
PROCEDURE Delay(numTicks: LONGINT;VAR finalTicks: LONGINT);
FUNCTION GetTrapAddress(trapNum: INTEGER): LONGINT;
PROCEDURE SetTrapAddress(trapAddr: LONGINT;trapNum: INTEGER);
FUNCTION NGetTrapAddress(trapNum: INTEGER;tTyp: TrapType): LONGINT;
PROCEDURE NSetTrapAddress(trapAddr: LONGINT;trapNum: INTEGER;tTyp: TrapType);
FUNCTION WriteParam: OSErr;
FUNCTION EqualString(str1: Str255;str2: Str255;caseSens: BOOLEAN;diacSens: BOOLEAN): BOOLEAN;
PROCEDURE UprString(VAR theString: Str255;diacSens: BOOLEAN);
PROCEDURE Enqueue(qElement: QElemPtr;qHeader: QHdrPtr);
FUNCTION Dequeue(qElement: QElemPtr;qHeader: QHdrPtr): OSErr;
FUNCTION SetCurrentA5: LONGINT;
    INLINE $2E8D,$2A78,$0904;
FUNCTION SetA5(newA5: LONGINT): LONGINT;
    INLINE $2F4D,$0004,$2A5F;
PROCEDURE SetUpA5;
    INLINE $2F0D,$2A78,$0904;
PROCEDURE RestoreA5;
    INLINE $2A5F;
PROCEDURE Environs(VAR rom: INTEGER;VAR machine: INTEGER);
PROCEDURE Restart;
FUNCTION RelString(str1: Str255;str2: Str255;caseSens: BOOLEAN;diacSens: BOOLEAN): INTEGER;
FUNCTION HandToHand(VAR theHndl: Handle): OSErr;
FUNCTION PtrToXHand(srcPtr: Ptr;dstHndl: Handle;size: LONGINT): OSErr;
FUNCTION PtrToHand(srcPtr: Ptr;VAR dstHndl: Handle;size: LONGINT): OSErr;
FUNCTION HandAndHand(hand1: Handle;hand2: Handle): OSErr;
FUNCTION PtrAndHand(ptr1: Ptr;hand2: Handle;size: LONGINT): OSErr;
FUNCTION InitUtil: OSErr;
    INLINE $A03F,$3E80;

{$ENDC}    { UsingOSUtils }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


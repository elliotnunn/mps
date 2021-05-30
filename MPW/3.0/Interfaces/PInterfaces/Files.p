{
Created: Thursday, October 27, 1988 at 8:02 PM
    Files.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Files;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingFiles}
{$SETC UsingFiles := 1}

{$I+}
{$SETC FilesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$IFC UNDEFINED UsingSegLoad}
{$I $$Shell(PInterfaces)SegLoad.p}
{$ENDC}
{$SETC UsingIncludes := FilesIncludes}

CONST

{ Finder Constants }

fsAtMark = 0;
fOnDesk = 1;
fsCurPerm = 0;
fHasBundle = 8192;
fsRdPerm = 1;
fInvisible = 16384;
fTrash = -3;
fsWrPerm = 2;
fDesktop = -2;
fsRdWrPerm = 3;
fDisk = 0;
fsRdWrShPerm = 4;
fsFromStart = 1;
fsFromLEOF = 2;
fsFromMark = 3;
rdVerify = 64;
ioDirFlg = 3;
ioDirMask = $10;
fsRtParID = 1;
fsRtDirID = 2;

{ Version Release Stage Codes }

developStage = $20;
alphaStage = $40;
betaStage = $60;
finalStage = $80;


TYPE

CInfoType = (hFileInfo,dirInfo);

FXInfo = RECORD
    fdIconID: INTEGER;                  {Icon ID}
    fdUnused: ARRAY [1..4] OF INTEGER;  {unused but reserved 8 bytes}
    fdComment: INTEGER;                 {Comment ID}
    fdPutAway: LONGINT;                 {Home Dir ID}
    END;

DInfo = RECORD
    frRect: Rect;                       {folder rect}
    frFlags: INTEGER;                   {Flags}
    frLocation: Point;                  {folder location}
    frView: INTEGER;                    {folder view}
    END;

DXInfo = RECORD
    frScroll: Point;                    {scroll position}
    frOpenChain: LONGINT;               {DirID chain of open folders}
    frUnused: INTEGER;                  {unused but reserved}
    frComment: INTEGER;                 {comment}
    frPutAway: LONGINT;                 {DirID}
    END;

CMovePBPtr = ^CMovePBRec;
CMovePBRec = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    ioTrap: INTEGER;
    ioCmdAddr: Ptr;
    ioCompletion: ProcPtr;
    ioResult: OSErr;
    ioNamePtr: StringPtr;
    ioVRefNum: INTEGER;
    filler1: LONGINT;
    ioNewName: StringPtr;
    filler2: LONGINT;
    ioNewDirID: LONGINT;
    filler3: ARRAY [1..2] OF LONGINT;
    ioDirID: LONGINT;
    END;

WDPBPtr = ^WDPBRec;
WDPBRec = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    ioTrap: INTEGER;
    ioCmdAddr: Ptr;
    ioCompletion: ProcPtr;
    ioResult: OSErr;
    ioNamePtr: StringPtr;
    ioVRefNum: INTEGER;
    filler1: INTEGER;
    ioWDIndex: INTEGER;
    ioWDProcID: LONGINT;
    ioWDVRefNum: INTEGER;
    filler2: ARRAY [1..7] OF INTEGER;
    ioWDDirID: LONGINT;
    END;

FCBPBPtr = ^FCBPBRec;
FCBPBRec = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    ioTrap: INTEGER;
    ioCmdAddr: Ptr;
    ioCompletion: ProcPtr;
    ioResult: OSErr;
    ioNamePtr: StringPtr;
    ioVRefNum: INTEGER;
    ioRefNum: INTEGER;
    filler: INTEGER;
    ioFCBIndx: INTEGER;
    filler1: INTEGER;
    ioFCBFlNm: LONGINT;
    ioFCBFlags: INTEGER;
    ioFCBStBlk: INTEGER;
    ioFCBEOF: LONGINT;
    ioFCBPLen: LONGINT;
    ioFCBCrPs: LONGINT;
    ioFCBVRefNum: INTEGER;
    ioFCBClpSiz: LONGINT;
    ioFCBParID: LONGINT;
    END;

HParmBlkPtr = ^HParamBlockRec;
HParamBlockRec = RECORD
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
        ioReqCount: LONGINT;            {size of buffer area}
        ioActCount: LONGINT;            {length of vol parms data}
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
        ioDirID: LONGINT;
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
        ioVLsMod: LONGINT;
        ioVAtrb: INTEGER;
        ioVNmFls: INTEGER;
        ioVBitMap: INTEGER;
        ioAllocPtr: INTEGER;
        ioVNmAlBlks: INTEGER;
        ioVAlBlkSiz: LONGINT;
        ioVClpSiz: LONGINT;
        ioAlBlSt: INTEGER;
        ioVNxtCNID: LONGINT;
        ioVFrBlk: INTEGER;
        ioVSigWord: INTEGER;
        ioVDrvInfo: INTEGER;
        ioVDRefNum: INTEGER;
        ioVFSID: INTEGER;
        ioVBkUp: LONGINT;
        ioVSeqNum: INTEGER;
        ioVWrCnt: LONGINT;
        ioVFilCnt: LONGINT;
        ioVDirCnt: LONGINT;
        ioVFndrInfo: ARRAY [1..8] OF LONGINT);
      AccessParam:
        (filler3: INTEGER;
        ioDenyModes: INTEGER;           {access rights data}
        filler4: INTEGER;
        filler5: SignedByte;
        ioACUser: SignedByte;           {access rights for directory only}
        filler6: LONGINT;
        ioACOwnerID: LONGINT;           {owner ID}
        ioACGroupID: LONGINT;           {group ID}
        ioACAccess: LONGINT);           {access rights}
      ObjParam:
        (filler7: INTEGER;
        ioObjType: INTEGER;             {function code}
        ioObjNamePtr: Ptr;              {ptr to returned creator/group name}
        ioObjID: LONGINT);              {creator/group ID}
      CopyParam:
        (ioDstVRefNum: INTEGER;         {destination vol identifier}
        filler8: INTEGER;
        ioNewName: Ptr;                 {ptr to destination pathname}
        ioCopyName: Ptr;                {ptr to optional name}
        ioNewDirID: LONGINT);           {destination directory ID}
      WDParam:
        (filler9: INTEGER;
        ioWDIndex: INTEGER;
        ioWDProcID: LONGINT;
        ioWDVRefNum: INTEGER;
        filler10: INTEGER;
        filler11: LONGINT;
        filler12: LONGINT;
        filler13: LONGINT;
        ioWDDirID: LONGINT);
    END;

CInfoPBPtr = ^CInfoPBRec;
CInfoPBRec = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    ioTrap: INTEGER;
    ioCmdAddr: Ptr;
    ioCompletion: ProcPtr;
    ioResult: OSErr;
    ioNamePtr: StringPtr;
    ioVRefNum: INTEGER;
    ioFRefNum: INTEGER;
    ioFVersNum: SignedByte;
    filler1: SignedByte;
    ioFDirIndex: INTEGER;
    ioFlAttrib: SignedByte;
    filler2: SignedByte;
    CASE CInfoType OF
      hFileInfo:
        (ioFlFndrInfo: FInfo;
        ioDirID: LONGINT;
        ioFlStBlk: INTEGER;
        ioFlLgLen: LONGINT;
        ioFlPyLen: LONGINT;
        ioFlRStBlk: INTEGER;
        ioFlRLgLen: LONGINT;
        ioFlRPyLen: LONGINT;
        ioFlCrDat: LONGINT;
        ioFlMdDat: LONGINT;
        ioFlBkDat: LONGINT;
        ioFlXFndrInfo: FXInfo;
        ioFlParID: LONGINT;
        ioFlClpSiz: LONGINT);
      dirInfo:
        (ioDrUsrWds: DInfo;
        ioDrDirID: LONGINT;
        ioDrNmFls: INTEGER;
        filler3: ARRAY [1..9] OF INTEGER;
        ioDrCrDat: LONGINT;
        ioDrMdDat: LONGINT;
        ioDrBkDat: LONGINT;
        ioDrFndrInfo: DXInfo;
        ioDrParID: LONGINT);
    END;

{ Numeric version part of 'vers' resource }

NumVersion = PACKED RECORD
    CASE INTEGER OF
      0:
        (majorRev: SignedByte;          {1st part of version number in BCD}
        minorRev: 0..9;                 {2nd part is 1 nibble in BCD}
        bugFixRev: 0..9;                {3rd part is 1 nibble in BCD}
        stage: SignedByte;              {stage code: dev, alpha, beta, final}
        nonRelRev: SignedByte);         {revision level of non-released version}
      1:
        (version: LONGINT);             {to use all 4 fields at one time}
    END;

{ 'vers' resource format }

VersRecPtr = ^VersRec;
VersRecHndl = ^VersRecPtr;
VersRec = RECORD
    numericVersion: NumVersion;         {encoded version number}
    countryCode: INTEGER;               {country code from intl utilities}
    shortVersion: Str255;               {version number string - worst case}
    reserved: Str255;                   {longMessage string packed after shortVersion}
    END;


FUNCTION PBHGetVolParms(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHGetLogInInfo(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHGetDirAccess(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHSetDirAccess(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHMapID(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHMapName(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHCopyFile(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHMoveRename(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHOpenDeny(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHOpenRFDeny(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBOpen(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBClose(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBRead(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBWrite(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetVInfo(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetVol(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetVol(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBFlushVol(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBCreate(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBDelete(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBOpenRF(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBRename(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetFInfo(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetFInfo(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetFLock(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBRstFLock(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetFVers(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBAllocate(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetEOF(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetEOF(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetFPos(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetFPos(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBFlushFile(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBMountVol(paramBlock: ParmBlkPtr): OSErr;
FUNCTION PBUnmountVol(paramBlock: ParmBlkPtr): OSErr;
FUNCTION PBEject(paramBlock: ParmBlkPtr): OSErr;
FUNCTION PBOffLine(paramBlock: ParmBlkPtr): OSErr;
PROCEDURE AddDrive(drvrRefNum: INTEGER;drvNum: INTEGER;qEl: DrvQElPtr);
FUNCTION FSOpen(fileName: Str255;vRefNum: INTEGER;VAR refNum: INTEGER): OSErr;
FUNCTION FSClose(refNum: INTEGER): OSErr;
FUNCTION FSRead(refNum: INTEGER;VAR count: LONGINT;buffPtr: Ptr): OSErr;
FUNCTION FSWrite(refNum: INTEGER;VAR count: LONGINT;buffPtr: Ptr): OSErr;
FUNCTION GetVInfo(drvNum: INTEGER;volName: StringPtr;VAR vRefNum: INTEGER;
    VAR freeBytes: LONGINT): OSErr;
FUNCTION GetFInfo(fileName: Str255;vRefNum: INTEGER;VAR fndrInfo: FInfo): OSErr;
FUNCTION GetVol(volName: StringPtr;VAR vRefNum: INTEGER): OSErr;
FUNCTION SetVol(volName: StringPtr;vRefNum: INTEGER): OSErr;
FUNCTION UnmountVol(volName: StringPtr;vRefNum: INTEGER): OSErr;
FUNCTION Eject(volName: StringPtr;vRefNum: INTEGER): OSErr;
FUNCTION FlushVol(volName: StringPtr;vRefNum: INTEGER): OSErr;
FUNCTION Create(fileName: Str255;vRefNum: INTEGER;creator: OSType;fileType: OSType): OSErr;
FUNCTION FSDelete(fileName: Str255;vRefNum: INTEGER): OSErr;
FUNCTION OpenRF(fileName: Str255;vRefNum: INTEGER;VAR refNum: INTEGER): OSErr;
FUNCTION Rename(oldName: Str255;vRefNum: INTEGER;newName: Str255): OSErr;
FUNCTION SetFInfo(fileName: Str255;vRefNum: INTEGER;fndrInfo: FInfo): OSErr;
FUNCTION SetFLock(fileName: Str255;vRefNum: INTEGER): OSErr;
FUNCTION RstFLock(fileName: Str255;vRefNum: INTEGER): OSErr;
FUNCTION Allocate(refNum: INTEGER;VAR count: LONGINT): OSErr;
FUNCTION GetEOF(refNum: INTEGER;VAR logEOF: LONGINT): OSErr;
FUNCTION SetEOF(refNum: INTEGER;logEOF: LONGINT): OSErr;
FUNCTION GetFPos(refNum: INTEGER;VAR filePos: LONGINT): OSErr;
FUNCTION SetFPos(refNum: INTEGER;posMode: INTEGER;posOff: LONGINT): OSErr;
FUNCTION GetVRefNum(fileRefNum: INTEGER;VAR vRefNum: INTEGER): OSErr;
FUNCTION PBOpenWD(paramBlock: WDPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBCloseWD(paramBlock: WDPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBHSetVol(paramBlock: WDPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBHGetVol(paramBlock: WDPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBCatMove(paramBlock: CMovePBPtr;async: BOOLEAN): OSErr;
FUNCTION PBDirCreate(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetWDInfo(paramBlock: WDPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetFCBInfo(paramBlock: FCBPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBGetCatInfo(paramBlock: CInfoPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetCatInfo(paramBlock: CInfoPBPtr;async: BOOLEAN): OSErr;
FUNCTION PBAllocContig(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBLockRange(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBUnlockRange(paramBlock: ParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBSetVInfo(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHGetVInfo(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHOpen(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHOpenRF(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHCreate(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHDelete(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHRename(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHRstFLock(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHSetFLock(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHGetFInfo(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
FUNCTION PBHSetFInfo(paramBlock: HParmBlkPtr;async: BOOLEAN): OSErr;
PROCEDURE FInitQueue;
    INLINE $A016;
FUNCTION GetFSQHdr: QHdrPtr;
FUNCTION GetDrvQHdr: QHdrPtr;
FUNCTION GetVCBQHdr: QHdrPtr;
FUNCTION HGetVol(volName: StringPtr;VAR vRefNum: INTEGER;VAR dirID: LONGINT): OSErr;
FUNCTION HSetVol(volName: StringPtr;vRefNum: INTEGER;dirID: LONGINT): OSErr;
FUNCTION HOpen(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255;permission: SignedByte;
    VAR refNum: INTEGER): OSErr;
FUNCTION HOpenRF(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255;permission: SignedByte;
    VAR refNum: INTEGER): OSErr;
FUNCTION AllocContig(refNum: INTEGER;VAR count: LONGINT): OSErr;
FUNCTION HCreate(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255;creator: OSType;
    fileType: OSType): OSErr;
FUNCTION DirCreate(vRefNum: INTEGER;parentDirID: LONGINT;directoryName: Str255;
    VAR createdDirID: LONGINT): OSErr;
FUNCTION HDelete(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255): OSErr;
FUNCTION HGetFInfo(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255;VAR fndrInfo: FInfo): OSErr;
FUNCTION HSetFInfo(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255;fndrInfo: FInfo): OSErr;
FUNCTION HSetFLock(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255): OSErr;
FUNCTION HRstFLock(vRefNum: INTEGER;dirID: LONGINT;fileName: Str255): OSErr;
FUNCTION HRename(vRefNum: INTEGER;dirID: LONGINT;oldName: Str255;newName: Str255): OSErr;
FUNCTION CatMove(vRefNum: INTEGER;dirID: LONGINT;oldName: Str255;newDirID: LONGINT;
    newName: Str255): OSErr;
FUNCTION OpenWD(vRefNum: INTEGER;dirID: LONGINT;procID: LONGINT;VAR wdRefNum: INTEGER): OSErr;
FUNCTION CloseWD(wdRefNum: INTEGER): OSErr;
FUNCTION GetWDInfo(wdRefNum: INTEGER;VAR vRefNum: INTEGER;VAR dirID: LONGINT;
    VAR procID: LONGINT): OSErr;

{$ENDC}    { UsingFiles }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


/************************************************************

Created: Thursday, October 27, 1988 at 9:37 PM
    Files.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved

************************************************************/


#ifndef __FILES__
#define __FILES__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __SEGLOAD__
#include <SegLoad.h>
#endif


/* Finder Constants */

#define fsAtMark 0
#define fOnDesk 1
#define fsCurPerm 0
#define fHasBundle 8192
#define fsRdPerm 1
#define fInvisible 16384
#define fTrash -3
#define fsWrPerm 2
#define fDesktop -2
#define fsRdWrPerm 3
#define fDisk 0
#define fsRdWrShPerm 4
#define fsFromStart 1
#define fsFromLEOF 2
#define fsFromMark 3
#define rdVerify 64
#define ioDirFlg 3
#define ioDirMask 0x10
#define fsRtParID 1
#define fsRtDirID 2

/* Version Release Stage Codes */

#define developStage 0x20
#define alphaStage 0x40
#define betaStage 0x60
#define finalStage 0x80

struct FInfo {
    OSType fdType;                  /*the type of the file*/
    OSType fdCreator;               /*file's creator*/
    unsigned short fdFlags;         /*flags ex. hasbundle,invisible,locked, etc.*/
    Point fdLocation;               /*file's location in folder*/
    short fdFldr;                   /*folder containing file*/
};

#ifndef __cplusplus
typedef struct FInfo FInfo;
#endif

struct FXInfo {
    short fdIconID;                 /*Icon ID*/
    short fdUnused[4];              /*unused but reserved 8 bytes*/
    short fdComment;                /*Comment ID*/
    long fdPutAway;                 /*Home Dir ID*/
};

#ifndef __cplusplus
typedef struct FXInfo FXInfo;
#endif

struct DInfo {
    Rect frRect;                    /*folder rect*/
    unsigned short frFlags;         /*Flags*/
    Point frLocation;               /*folder location*/
    short frView;                   /*folder view*/
};

#ifndef __cplusplus
typedef struct DInfo DInfo;
#endif

struct DXInfo {
    Point frScroll;                 /*scroll position*/
    long frOpenChain;               /*DirID chain of open folders*/
    short frUnused;                 /*unused but reserved*/
    short frComment;                /*comment*/
    long frPutAway;                 /*DirID*/
};

#ifndef __cplusplus
typedef struct DXInfo DXInfo;
#endif

#define ParamBlockHeader \
    QElemPtr qLink;                 /*queue link in header*/\
    short qType;                    /*type byte for safety check*/\
    short ioTrap;                   /*FS: the Trap*/\
    Ptr ioCmdAddr;                  /*FS: address to dispatch to*/\
    ProcPtr ioCompletion;           /*completion routine addr (0 for synch calls)*/\
    OSErr ioResult;                 /*result code*/\
    StringPtr ioNamePtr;            /*ptr to Vol:FileName string*/\
    short ioVRefNum;                /*volume refnum (DrvNum for Eject and MountVol)*/


struct IOParam {
    ParamBlockHeader 
    short ioRefNum;                 /*refNum for I/O operation*/
    char ioVersNum;                 /*version number*/
    char ioPermssn;                 /*Open: permissions (byte)*/
    Ptr ioMisc;                     /*Rename: new name (GetEOF,SetEOF: logical end of file) (Open: optional ptr to buffer) (SetFileType: new type)*/
    Ptr ioBuffer;                   /*data buffer Ptr*/
    long ioReqCount;                /*requested byte count; also = ioNewDirID*/
    long ioActCount;                /*actual byte count completed*/
    short ioPosMode;                /*initial file positioning*/
    long ioPosOffset;               /*file position offset*/
};

#ifndef __cplusplus
typedef struct IOParam IOParam;
#endif

struct FileParam {
    ParamBlockHeader 
    short ioFRefNum;                /*reference number*/
    char ioFVersNum;                /*version number*/
    char filler1;
    short ioFDirIndex;              /*GetFInfo directory index*/
    unsigned char ioFlAttrib;       /*GetFInfo: in-use bit=7, lock bit=0*/
    unsigned char ioFlVersNum;      /*file version number*/
    FInfo ioFlFndrInfo;             /*user info*/
    unsigned long ioFlNum;          /*GetFInfo: file number; TF- ioDirID*/
    unsigned short ioFlStBlk;       /*start file block (0 if none)*/
    long ioFlLgLen;                 /*logical length (EOF)*/
    long ioFlPyLen;                 /*physical length*/
    unsigned short ioFlRStBlk;      /*start block rsrc fork*/
    long ioFlRLgLen;                /*file logical length rsrc fork*/
    long ioFlRPyLen;                /*file physical length rsrc fork*/
    unsigned long ioFlCrDat;        /*file creation date& time (32 bits in secs)*/
    unsigned long ioFlMdDat;        /*last modified date and time*/
};

#ifndef __cplusplus
typedef struct FileParam FileParam;
#endif

struct VolumeParam {
    ParamBlockHeader 
    long filler2;
    short ioVolIndex;               /*volume index number*/
    unsigned long ioVCrDate;        /*creation date and time*/
    unsigned long ioVLsBkUp;        /*last backup date and time*/
    unsigned short ioVAtrb;         /*volume attrib*/
    unsigned short ioVNmFls;        /*number of files in directory*/
    unsigned short ioVDirSt;        /*start block of file directory*/
    short ioVBlLn;                  /*GetVolInfo: length of dir in blocks*/
    unsigned short ioVNmAlBlks;     /*GetVolInfo: num blks (of alloc size)*/
    long ioVAlBlkSiz;               /*GetVolInfo: alloc blk byte size*/
    long ioVClpSiz;                 /*GetVolInfo: bytes to allocate at a time*/
    unsigned short ioAlBlSt;        /*starting disk(512-byte) block in block map*/
    unsigned long ioVNxtFNum;       /*GetVolInfo: next free file number*/
    unsigned short ioVFrBlk;        /*GetVolInfo: # free alloc blks for this vol*/
};

#ifndef __cplusplus
typedef struct VolumeParam VolumeParam;
#endif

struct CntrlParam {
    QElem *qLink;                   /*queue link in header*/
    short qType;                    /*type byte for safety check*/
    short ioTrap;                   /*FS: the Trap*/
    Ptr ioCmdAddr;                  /*FS: address to dispatch to*/
    ProcPtr ioCompletion;           /*completion routine addr (0 for synch calls)*/
    OSErr ioResult;                 /*result code*/
    StringPtr ioNamePtr;            /*ptr to Vol:FileName string*/
    short ioVRefNum;                /*volume refnum (DrvNum for Eject and MountVol)*/
    short ioCRefNum;                /*refNum for I/O operation*/
    short csCode;                   /*word for control status code*/
    short csParam[11];              /*operation-defined parameters*/
};

#ifndef __cplusplus
typedef struct CntrlParam CntrlParam;
#endif

struct SlotDevParam {
    ParamBlockHeader 
    short ioRefNum;
    char ioVersNum;
    char ioPermssn;
    Ptr ioMix;
    short ioFlags;
    char ioSlot;
    char ioID;
};

#ifndef __cplusplus
typedef struct SlotDevParam SlotDevParam;
#endif

struct MultiDevParam {
    ParamBlockHeader 
    short ioRefNum;
    char ioVersNum;
    char ioPermssn;
    Ptr ioMix;
    short ioFlags;
    Ptr ioSEBlkPtr;
};

#ifndef __cplusplus
typedef struct MultiDevParam MultiDevParam;
#endif

union ParamBlockRec {
    IOParam ioParam;
    FileParam fileParam;
    VolumeParam volumeParam;
    CntrlParam cntrlParam;
    SlotDevParam slotDevParam;
    MultiDevParam multiDevParam;
};

#ifndef __cplusplus
typedef union ParamBlockRec ParamBlockRec;
#endif

typedef ParamBlockRec *ParmBlkPtr;

struct HIOParam {
    ParamBlockHeader 
    short ioRefNum;
    char ioVersNum;
    char ioPermssn;
    Ptr ioMisc;
    Ptr ioBuffer;
    long ioReqCount;
    long ioActCount;
    short ioPosMode;
    long ioPosOffset;
    short filler1;
};

#ifndef __cplusplus
typedef struct HIOParam HIOParam;
#endif

struct HFileParam {
    ParamBlockHeader 
    short ioFRefNum;
    char ioFVersNum;
    char filler1;
    short ioFDirIndex;
    char ioFlAttrib;
    char ioFlVersNum;
    FInfo ioFlFndrInfo;
    long ioDirID;
    unsigned short ioFlStBlk;
    long ioFlLgLen;
    long ioFlPyLen;
    unsigned short ioFlRStBlk;
    long ioFlRLgLen;
    long ioFlRPyLen;
    unsigned long ioFlCrDat;
    unsigned long ioFlMdDat;
};

#ifndef __cplusplus
typedef struct HFileParam HFileParam;
#endif

struct HVolumeParam {
    ParamBlockHeader 
    long filler2;
    short ioVolIndex;
    unsigned long ioVCrDate;
    unsigned long ioVLsMod;
    short ioVAtrb;
    unsigned short ioVNmFls;
    short ioVBitMap;
    short ioAllocPtr;
    unsigned short ioVNmAlBlks;
    long ioVAlBlkSiz;
    long ioVClpSiz;
    short ioAlBlSt;
    long ioVNxtCNID;
    unsigned short ioVFrBlk;
    unsigned short ioVSigWord;
    short ioVDrvInfo;
    short ioVDRefNum;
    short ioVFSID;
    unsigned long ioVBkUp;
    unsigned short ioVSeqNum;
    long ioVWrCnt;
    long ioVFilCnt;
    long ioVDirCnt;
    long ioVFndrInfo[8];
};

#ifndef __cplusplus
typedef struct HVolumeParam HVolumeParam;
#endif

struct AccessParam {
    ParamBlockHeader 
    short filler3;
    short ioDenyModes;              /*access rights data*/
    short filler4;
    char filler5;
    char ioACUser;                  /*access rights for directory only*/
    long filler6;
    long ioACOwnerID;               /*owner ID*/
    long ioACGroupID;               /*group ID*/
    long ioACAccess;                /*access rights*/
};

#ifndef __cplusplus
typedef struct AccessParam AccessParam;
#endif

struct ObjParam {
    ParamBlockHeader 
    short filler7;
    short ioObjType;                /*function code*/
    Ptr ioObjNamePtr;               /*ptr to returned creator/group name*/
    long ioObjID;                   /*creator/group ID*/
    long ioReqCount;                /*size of buffer area*/
    long ioActCount;                /*length of vol parms data*/
};

#ifndef __cplusplus
typedef struct ObjParam ObjParam;
#endif

struct CopyParam {
    ParamBlockHeader 
    short ioDstVRefNum;             /*destination vol identifier*/
    short filler8;
    Ptr ioNewName;                  /*ptr to destination pathname*/
    Ptr ioCopyName;                 /*ptr to optional name*/
    long ioNewDirID;                /*destination directory ID*/
    long filler14;
    long filler15;
    long ioDirID;                   /*same as in FileParam*/
};

#ifndef __cplusplus
typedef struct CopyParam CopyParam;
#endif

struct WDParam {
    ParamBlockHeader 
    short filler9;
    short ioWDIndex;
    long ioWDProcID;
    short ioWDVRefNum;
    short filler10;
    long filler11;
    long filler12;
    long filler13;
    long ioWDDirID;
};

#ifndef __cplusplus
typedef struct WDParam WDParam;
#endif

union HParamBlockRec {
    HIOParam ioParam;
    HFileParam fileParam;
    HVolumeParam volumeParam;
    AccessParam accessParam;
    ObjParam objParam;
    CopyParam copyParam;
    WDParam wdParam;
};

#ifndef __cplusplus
typedef union HParamBlockRec HParamBlockRec;
#endif

typedef HParamBlockRec *HParmBlkPtr;

struct HFileInfo {
    ParamBlockHeader 
    short ioFRefNum;
    char ioFVersNum;
    char filler1;
    short ioFDirIndex;
    char ioFlAttrib;
    char filler2;
    FInfo ioFlFndrInfo;
    long ioDirID;
    unsigned short ioFlStBlk;
    long ioFlLgLen;
    long ioFlPyLen;
    unsigned short ioFlRStBlk;
    long ioFlRLgLen;
    long ioFlRPyLen;
    unsigned long ioFlCrDat;
    unsigned long ioFlMdDat;
    unsigned long ioFlBkDat;
    FXInfo ioFlXFndrInfo;
    long ioFlParID;
    long ioFlClpSiz;
};

#ifndef __cplusplus
typedef struct HFileInfo HFileInfo;
#endif

struct DirInfo {
    ParamBlockHeader 
    short ioFRefNum;
    short filler1;
    short ioFDirIndex;
    char ioFlAttrib;
    char filler2;
    DInfo ioDrUsrWds;
    long ioDrDirID;
    unsigned short ioDrNmFls;
    short filler3[9];
    unsigned long ioDrCrDat;
    unsigned long ioDrMdDat;
    unsigned long ioDrBkDat;
    DXInfo ioDrFndrInfo;
    long ioDrParID;
};

#ifndef __cplusplus
typedef struct DirInfo DirInfo;
#endif

union CInfoPBRec {
    HFileInfo hfileInfo;
    DirInfo dirInfo;
};

#ifndef __cplusplus
typedef union CInfoPBRec CInfoPBRec;
#endif

typedef CInfoPBRec *CInfoPBPtr;

struct CMovePBRec {
    QElemPtr qLink;
    short qType;
    short ioTrap;
    Ptr ioCmdAddr;
    ProcPtr ioCompletion;
    OSErr ioResult;
    StringPtr ioNamePtr;
    short ioVRefNum;
    long filler1;
    StringPtr ioNewName;
    long filler2;
    long ioNewDirID;
    long filler3[2];
    long ioDirID;
};

#ifndef __cplusplus
typedef struct CMovePBRec CMovePBRec;
#endif

typedef CMovePBRec *CMovePBPtr;

struct WDPBRec {
    QElemPtr qLink;
    short qType;
    short ioTrap;
    Ptr ioCmdAddr;
    ProcPtr ioCompletion;
    OSErr ioResult;
    StringPtr ioNamePtr;
    short ioVRefNum;
    short filler1;
    short ioWDIndex;
    long ioWDProcID;
    short ioWDVRefNum;
    short filler2[7];
    long ioWDDirID;
};

#ifndef __cplusplus
typedef struct WDPBRec WDPBRec;
#endif

typedef WDPBRec *WDPBPtr;

struct FCBPBRec {
    QElemPtr qLink;
    short qType;
    short ioTrap;
    Ptr ioCmdAddr;
    ProcPtr ioCompletion;
    OSErr ioResult;
    StringPtr ioNamePtr;
    short ioVRefNum;
    short ioRefNum;
    short filler;
    short ioFCBIndx;
    short filler1;
    long ioFCBFlNm;
    short ioFCBFlags;
    unsigned short ioFCBStBlk;
    long ioFCBEOF;
    long ioFCBPLen;
    long ioFCBCrPs;
    short ioFCBVRefNum;
    long ioFCBClpSiz;
    long ioFCBParID;
};

#ifndef __cplusplus
typedef struct FCBPBRec FCBPBRec;
#endif

typedef FCBPBRec *FCBPBPtr;

struct VCB {
    QElemPtr qLink;
    short qType;
    short vcbFlags;
    unsigned short vcbSigWord;
    unsigned long vcbCrDate;
    unsigned long vcbLsMod;
    short vcbAtrb;
    unsigned short vcbNmFls;
    short vcbVBMSt;
    short vcbAllocPtr;
    unsigned short vcbNmAlBlks;
    long vcbAlBlkSiz;
    long vcbClpSiz;
    short vcbAlBlSt;
    long vcbNxtCNID;
    unsigned short vcbFreeBks;
    Str27 vcbVN;
    short vcbDrvNum;
    short vcbDRefNum;
    short vcbFSID;
    short vcbVRefNum;
    Ptr vcbMAdr;
    Ptr vcbBufAdr;
    short vcbMLen;
    short vcbDirIndex;
    short vcbDirBlk;
    unsigned long vcbVolBkUp;
    unsigned short vcbVSeqNum;
    long vcbWrCnt;
    long vcbXTClpSiz;
    long vcbCTClpSiz;
    unsigned short vcbNmRtDirs;
    long vcbFilCnt;
    long vcbDirCnt;
    long vcbFndrInfo[8];
    unsigned short vcbVCSize;
    unsigned short vcbVBMCSiz;
    unsigned short vcbCtlCSiz;
    unsigned short vcbXTAlBlks;
    unsigned short vcbCTAlBlks;
    short vcbXTRef;
    short vcbCTRef;
    Ptr vcbCtlBuf;
    long vcbDirIDM;
    short vcbOffsM;
};

#ifndef __cplusplus
typedef struct VCB VCB;
#endif

struct DrvQEl {
    QElemPtr qLink;
    short qType;
    short dQDrive;
    short dQRefNum;
    short dQFSID;
    unsigned short dQDrvSz;
    unsigned short dQDrvSz2;
};

#ifndef __cplusplus
typedef struct DrvQEl DrvQEl;
#endif

typedef DrvQEl *DrvQElPtr;

struct NumVersion {
    unsigned char majorRev;         /*1st part of version number in BCD*/
    unsigned int minorRev : 4;      /*2nd part is 1 nibble in BCD*/
    unsigned int bugFixRev : 4;     /*3rd part is 1 nibble in BCD*/
    unsigned char stage;            /*stage code: dev, alpha, beta, final*/
    unsigned char nonRelRev;        /*revision level of non-released version*/
};

#ifndef __cplusplus
typedef struct NumVersion NumVersion;
#endif

/* Numeric version part of 'vers' resource */
struct VersRec {
    NumVersion numericVersion;      /*encoded version number*/
    short countryCode;              /*country code from intl utilities*/
    Str255 shortVersion;            /*version number string - worst case*/
    Str255 reserved;                /*longMessage string packed after shortVersion*/
};

#ifndef __cplusplus
typedef struct VersRec VersRec;
#endif

typedef VersRec *VersRecPtr, **VersRecHndl;

/* 'vers' resource format */
#ifdef __safe_link
extern "C" {
#endif
pascal OSErr PBHGetVolParms(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHGetLogInInfo(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHGetDirAccess(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHSetDirAccess(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHMapID(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHMapName(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHCopyFile(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHMoveRename(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHOpenDeny(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHOpenRFDeny(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBOpen(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBClose(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBRead(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBWrite(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetVInfo(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetVol(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetVol(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBFlushVol(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBCreate(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBDelete(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBOpenRF(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBRename(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetFInfo(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetFInfo(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetFLock(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBRstFLock(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetFVers(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBAllocate(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetEOF(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetEOF(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetFPos(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetFPos(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBFlushFile(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBMountVol(ParmBlkPtr paramBlock); 
pascal OSErr PBUnmountVol(ParmBlkPtr paramBlock); 
pascal OSErr PBEject(ParmBlkPtr paramBlock); 
pascal OSErr PBOffLine(ParmBlkPtr paramBlock); 
pascal void AddDrive(short drvrRefNum,short drvNum,DrvQElPtr qEl); 
pascal OSErr FSOpen(const Str255 fileName,short vRefNum,short *refNum); 
OSErr fsopen(char *fileName,short vRefNum,short *refNum); 
pascal OSErr FSClose(short refNum); 
pascal OSErr FSRead(short refNum,long *count,Ptr buffPtr); 
pascal OSErr FSWrite(short refNum,long *count,Ptr buffPtr); 
pascal OSErr GetVInfo(short drvNum,StringPtr volName,short *vRefNum,long *freeBytes); 
OSErr getvinfo(short drvNum,char *volName,short *vRefNum,long *freeBytes); 
pascal OSErr GetFInfo(const Str255 fileName,short vRefNum,FInfo *fndrInfo); 
OSErr getfinfo(char *fileName,short vRefNum,FInfo *fndrInfo); 
pascal OSErr GetVol(StringPtr volName,short *vRefNum); 
OSErr getvol(char *volName,short *vRefNum); 
pascal OSErr SetVol(StringPtr volName,short vRefNum); 
OSErr setvol(char *volName,short vRefNum); 
pascal OSErr UnmountVol(StringPtr volName,short vRefNum); 
OSErr unmountvol(char *volName,short vRefNum); 
pascal OSErr Eject(StringPtr volName,short vRefNum); 
OSErr eject(char *volName,short vRefNum); 
pascal OSErr FlushVol(StringPtr volName,short vRefNum); 
OSErr flushvol(char *volName,short vRefNum); 
pascal OSErr Create(const Str255 fileName,short vRefNum,OSType creator,
    OSType fileType); 
OSErr create(char *fileName,short vRefNum,OSType creator,OSType fileType); 
pascal OSErr FSDelete(const Str255 fileName,short vRefNum); 
OSErr fsdelete(char *fileName,short vRefNum); 
pascal OSErr OpenRF(const Str255 fileName,short vRefNum,short *refNum); 
OSErr openrf(char *fileName,short vRefNum,short *refNum); 
pascal OSErr Rename(const Str255 oldName,short vRefNum,const Str255 newName); 
OSErr fsrename(char *oldName,short vRefNum,char *newName); 
pascal OSErr SetFInfo(const Str255 fileName,short vRefNum,const FInfo *fndrInfo); 
OSErr setfinfo(char *fileName,short vRefNum,FInfo *fndrInfo); 
pascal OSErr SetFLock(const Str255 fileName,short vRefNum); 
OSErr setflock(char *fileName,short vRefNum); 
pascal OSErr RstFLock(const Str255 fileName,short vRefNum); 
OSErr rstfLock(char *fileName,short vRefNum); 
pascal OSErr Allocate(short refNum,long *count); 
pascal OSErr GetEOF(short refNum,long *logEOF); 
pascal OSErr SetEOF(short refNum,long logEOF); 
pascal OSErr GetFPos(short refNum,long *filePos); 
pascal OSErr SetFPos(short refNum,short posMode,long posOff); 
pascal OSErr GetVRefNum(short fileRefNum,short *vRefNum); 
pascal OSErr PBOpenWD(WDPBPtr paramBlock,Boolean async); 
pascal OSErr PBCloseWD(WDPBPtr paramBlock,Boolean async); 
pascal OSErr PBHSetVol(WDPBPtr paramBlock,Boolean async); 
pascal OSErr PBHGetVol(WDPBPtr paramBlock,Boolean async); 
pascal OSErr PBCatMove(CMovePBPtr paramBlock,Boolean async); 
pascal OSErr PBDirCreate(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBGetWDInfo(WDPBPtr paramBlock,Boolean async); 
pascal OSErr PBGetFCBInfo(FCBPBPtr paramBlock,Boolean async); 
pascal OSErr PBGetCatInfo(CInfoPBPtr paramBlock,Boolean async); 
pascal OSErr PBSetCatInfo(CInfoPBPtr paramBlock,Boolean async); 
pascal OSErr PBAllocContig(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBLockRange(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBUnlockRange(ParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBSetVInfo(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHGetVInfo(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHOpen(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHOpenRF(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHCreate(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHDelete(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHRename(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHRstFLock(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHSetFLock(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHGetFInfo(HParmBlkPtr paramBlock,Boolean async); 
pascal OSErr PBHSetFInfo(HParmBlkPtr paramBlock,Boolean async); 
pascal void FInitQueue(void)
    = 0xA016; 
pascal QHdrPtr GetFSQHdr(void); 
pascal QHdrPtr GetDrvQHdr(void); 
pascal QHdrPtr GetVCBQHdr(void); 
pascal OSErr HGetVol(StringPtr volName,short *vRefNum,long *dirID); 
pascal OSErr HSetVol(StringPtr volName,short vRefNum,long dirID); 
pascal OSErr HOpen(short vRefNum,long dirID,const Str255 fileName,char permission,
    short *refNum); 
pascal OSErr HOpenRF(short vRefNum,long dirID,const Str255 fileName,char permission,
    short *refNum); 
pascal OSErr AllocContig(short refNum,long *count); 
pascal OSErr HCreate(short vRefNum,long dirID,const Str255 fileName,OSType creator,
    OSType fileType); 
pascal OSErr DirCreate(short vRefNum,long parentDirID,const Str255 directoryName,
    long *createdDirID); 
pascal OSErr HDelete(short vRefNum,long dirID,const Str255 fileName); 
pascal OSErr HGetFInfo(short vRefNum,long dirID,const Str255 fileName,FInfo *fndrInfo); 
pascal OSErr HSetFInfo(short vRefNum,long dirID,const Str255 fileName,const FInfo *fndrInfo); 
pascal OSErr HSetFLock(short vRefNum,long dirID,const Str255 fileName); 
pascal OSErr HRstFLock(short vRefNum,long dirID,const Str255 fileName); 
pascal OSErr HRename(short vRefNum,long dirID,const Str255 oldName,const Str255 newName); 
pascal OSErr CatMove(short vRefNum,long dirID,const Str255 oldName,long newDirID,
    const Str255 newName); 
pascal OSErr OpenWD(short vRefNum,long dirID,long procID,short *wdRefNum); 
pascal OSErr CloseWD(short wdRefNum); 
pascal OSErr GetWDInfo(short wdRefNum,short *vRefNum,long *dirID,long *procID); 
#ifdef __safe_link
}
#endif

#endif

/*
	Files.h -- File Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
	
modifications:
	7 Jan 87		KLH	DrvQElPtr missing, so restored.
*/

#ifndef __FILES__
#define __FILES__
#ifndef __TYPES__
#include <Types.h>
#endif

#define fOnDesk 1
#define fHasBundle 8192
#define fInvisible 16384
#define fTrash (-3)
#define fDesktop (-2)
#define fDisk 0
#define fsCurPerm 0
#define fsRdPerm 1
#define fsWrPerm 2
#define fsRdWrPerm 3
#define fsRdWrShPerm 4
#define fsAtMark 0
#define fsFromStart 1
#define fsFromLEOF 2
#define fsFromMark 3
#define rdVerify 64
#define ioDirFlg 3
#define ioDirMask (1 << 4)
#define fsRtParID 1
#define fsRtDirID 2
typedef struct FInfo {
	OSType fdType;
	OSType fdCreator;
	unsigned short fdFlags;
	Point fdLocation;
	short fdFldr;
} FInfo;
typedef struct FXInfo {
	short fdIconID;
	short fdUnused[4];
	short fdComment;
	long fdPutAway;
} FXInfo;
typedef struct DInfo {
	Rect frRect;
	unsigned short frFlags;
	Point frLocation;
	short frView;
} DInfo;
typedef struct DXInfo {
	Point frScroll;
	long frOpenChain;
	short frUnused;
	short frComment;
	long frPutAway;
} DXInfo;
#define ParamBlockHeader \
	struct QElem *qLink; \
	short qType; \
	short ioTrap; \
	Ptr ioCmdAddr; \
	ProcPtr ioCompletion; \
	OSErr ioResult; \
	StringPtr ioNamePtr; \
	short ioVRefNum
typedef struct IOParam {
	ParamBlockHeader;
	short ioRefNum;
	char ioVersNum;
	char ioPermssn;
	Ptr ioMisc;
	Ptr ioBuffer;
	long ioReqCount;
	long ioActCount;
	short ioPosMode;
	long ioPosOffset;
} IOParam;
typedef struct FileParam {
	ParamBlockHeader;
	short ioFRefNum;
	char ioFVersNum;
	char filler1;
	short ioFDirIndex;
	unsigned char ioFlAttrib;
	unsigned char ioFlVersNum;
	FInfo ioFlFndrInfo;
	unsigned long ioFlNum;
	unsigned short ioFlStBlk;
	long ioFlLgLen;
	long ioFlPyLen;
	unsigned short ioFlRStBlk;
	long ioFlRLgLen;
	long ioFlRPyLen;
	unsigned long ioFlCrDat;
	unsigned long ioFlMdDat;
} FileParam;
typedef struct VolumeParam {
	ParamBlockHeader;
	long filler2;
	short ioVolIndex;
	unsigned long ioVCrDate;
	unsigned long ioVLsBkUp;
	unsigned short ioVAtrb;
	unsigned short ioVNmFls;
	unsigned short ioVDirSt;
	short ioVBlLn;
	unsigned short ioVNmAlBlks;
	long ioVAlBlkSiz;
	long ioVClpSiz;
	unsigned short ioAlBlSt;
	unsigned long ioVNxtFNum;
	unsigned short ioVFrBlk;
} VolumeParam;
typedef union ParamBlockRec {
	struct IOParam ioParam;
	struct FileParam fileParam;
	struct VolumeParam volumeParam;
} ParamBlockRec, *ParmBlkPtr;
typedef struct HIOParam {
	ParamBlockHeader;
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
} HIOParam;
typedef struct HFileParam {
	ParamBlockHeader;
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
} HFileParam;
typedef struct HVolumeParam {
	ParamBlockHeader;
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
} HVolumeParam;
typedef union HParamBlockRec {
	struct HIOParam ioParam;
	struct HFileParam fileParam;
	struct HVolumeParam volumeParam;
} HParamBlockRec, *HParmBlkPtr;
typedef struct HFileInfo {
	ParamBlockHeader;
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
} HFileInfo;
typedef struct DirInfo {
	ParamBlockHeader;
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
} DirInfo;
typedef union CInfoPBRec {
	struct HFileInfo hfileInfo;
	struct DirInfo dirInfo;
} CInfoPBRec;
typedef struct CMovePBRec {
	ParamBlockHeader;
	long filler1;
	StringPtr ioNewName;
	long filler2;
	long ioNewDirID;
	long filler3[2];
	long ioDirID;
} CMovePBRec,*CMovePBPtr;
typedef struct WDPBRec {
	ParamBlockHeader;
	short filler1;
	short ioWDIndex;
	long ioWDProcID;
	short ioWDVRefNum;
	short filler2[7];
	long ioWDDirID;
} WDPBRec,*WDPBPtr;
typedef struct FCBPBRec {
	ParamBlockHeader;
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
} FCBPBRec,*FCBPBPtr;
typedef struct VCB {
	struct QElem *qLink;
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
	String(27) vcbVN;
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
} VCB;
typedef struct DrvQEl {
	struct QElem *qLink;
	short qType;
	short dQDrive;
	short dQRefNum;
	short dQFSID;
	unsigned short dQDrvSz;
	unsigned short dQDrvSz2;
} DrvQEl,*DrvQElPtr;
struct QHdr *GetFSQHdr();
struct QHdr *GetVCBQHdr();
struct QHdr *GetDrvQHdr();
#endif

/************************************************************

Created: Tuesday, October 4, 1988 at 7:39 PM
    PrintTraps.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __PRINTTRAPS__
#define __PRINTTRAPS__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#define bDraftLoop 0
#define bSpoolLoop 1
#define iPFMaxPgs 128               /*Max number of pages in a print file.*/
#define iPrPgFract 120
#define iPrPgFst 1                  /*Page range constants*/
#define iPrPgMax 9999
#define iPrRelease 2                /*Current version number of the code.*/
#define iPrSavPFil -1
#define iIOAbort -27
#define pPrGlobals 0x00000944
#define bUser1Loop 2
#define bUser2Loop 3
#define fNewRunBit 2                /*Bit 2 (3rd bit) in bDocLoop is new JobRun indicator.*/
#define fHiResOK 3                  /*Bit 3 (4th bit) in bDocLoop is hi res indicator for paint.*/
#define fWeOpenedRF 4               /*Bit 4 (5th bit) in bDocLoop is set if driver opened the pr res file.*/
#define iPrAbort 128
#define iPrDevCtl 7                 /*The PrDevCtl Proc's ctl number*/
#define lPrReset 0x00010000         /*The PrDevCtl Proc's CParam for reset*/
#define lPrLineFeed 0x00030000
#define lPrLFStd 0x0003FFFF         /*The PrDevCtl Proc's CParam for std paper advance*/
#define lPrLFSixth 0x0003FFFF
#define lPrPageEnd 0x00020000       /*The PrDevCtl Proc's CParam for end page*/
#define lPrDocOpen 0x00010000       /*note: same as lPrReset low order byte indicates number of copies to print*/
#define lPrPageOpen 0x00040000
#define lPrPageClose 0x00020000     /*note: same as lPrPageEnd*/
#define lPrDocClose 0x00050000
#define iFMgrCtl 8                  /*The FMgr's Tail-hook Proc's ctl number*/
#define iMscCtl 9                   /*Msc Text state / Drvr State ctl number*/
#define iPvtCtl 10                  /*Private ctls start here*/
#define iMemFullErr -108

/* 
Driver constants */

#define iPrBitsCtl 4                /*The Bitmap Print Proc's ctl number*/
#define lScreenBits 0               /*The Bitmap Print Proc's Screen Bitmap param*/
#define lPaintBits 1                /*The Bitmap Print Proc's Paint [sq pix] param*/
#define lHiScreenBits 0x00000002    /*The Bitmap Print Proc's Screen Bitmap param*/
#define lHiPaintBits 0x00000003     /*The Bitmap Print Proc's Paint [sq pix] param*/
#define iPrIOCtl 5                  /*The Raw Byte IO Proc's ctl number*/
#define iPrEvtCtl 6                 /*The PrEvent Proc's ctl number*/
#define lPrEvtAll 0x0002FFFD        /*The PrEvent Proc's CParam for the entire screen*/
#define lPrEvtTop 0x0001FFFD        /*The PrEvent Proc's CParam for the top folder*/
#define sPrDrvr ".Print"
#define iPrDrvrRef -3
#define getRslDataOp 4              /*PrGeneral Cs*/
#define setRslOp 5                  /*PrGeneral Cs*/
#define draftBitsOp 6               /*PrGeneral Cs*/
#define noDraftBitsOp 7             /*PrGeneral Cs*/
#define getRotnOp 8                 /*PrGeneral Cs*/
#define NoSuchRsl 1                 /*PrGeneral Cs*/
#define RgType1 1                   /*PrGeneral Cs*/

enum {feedCut,feedFanfold,feedMechCut,feedOther};
typedef unsigned char TFeed;

enum {scanTB,scanBT,scanLR,scanRL};
typedef unsigned char TScan;

typedef Rect *TPRect;

typedef pascal void (*PrIdleProcPtr)(void);
typedef pascal short (*PItemProcPtr)(DialogPtr theDialog, short item);

struct TPrPort {
    GrafPort gPort;                 /*The Printer's graf port.*/
    QDProcs gProcs;                 /*..and its procs*/
    long lGParam1;                  /*16 bytes for private parameter storage.*/
    long lGParam2;
    long lGParam3;
    long lGParam4;
    Boolean fOurPtr;                /*Whether the PrPort allocation was done by us.*/
    Boolean fOurBits;               /*Whether the BitMap allocation was done by us.*/
};

#ifndef __cplusplus
typedef struct TPrPort TPrPort;
#endif

typedef TPrPort *TPPrPort;

/* Printing Graf Port. All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.
This is the "PrPeek" record.
 */
struct TPrInfo {
    short iDev;                     /*Font mgr/QuickDraw device code*/
    short iVRes;                    /*Resolution of device, in device coordinates*/
    short iHRes;                    /*..note: V before H => compatable with Point.*/
    Rect rPage;                     /*The page (printable) rectangle in device coordinates.*/
};

#ifndef __cplusplus
typedef struct TPrInfo TPrInfo;
#endif

typedef TPrInfo *TPPrInfo;

/* Print Info Record: The parameters needed for page composition. */
struct TPrStl {
    short wDev;                     /*The device (driver) number. Hi byte=RefNum, Lo byte=variant. f0 = fHiRes f1 = fPortrait, f2 = fSqPix, f3 = f2xZoom, f4 = fScroll.*/
    short iPageV;                   /*paper size in units of 1/iPrPgFract*/
    short iPageH;                   /* ..note: V before H => compatable with Point.*/
    char bPort;                     /*The IO port number. Refnum?*/
    TFeed feed;                     /*paper feeder type.*/
};

#ifndef __cplusplus
typedef struct TPrStl TPrStl;
#endif

typedef TPrStl *TPPrStl;

/* Printer Style: The printer configuration and usage information. */
struct TPrXInfo {
    short iRowBytes;
    short iBandV;
    short iBandH;
    short iDevBytes;
    short iBands;
    char bPatScale;
    char bUlThick;
    char bUlOffset;
    char bUlShadow;
    TScan scan;
    char bXInfoX;
};

#ifndef __cplusplus
typedef struct TPrXInfo TPrXInfo;
#endif

typedef TPrXInfo *TPPrXInfo;

struct TPrJob {
    short iFstPage;
    short iLstPage;
    short iCopies;
    char bJDocLoop;
    Boolean fFromUsr;
    PrIdleProcPtr pIdleProc;
    StringPtr pFileName;
    short iFileVol;
    char bFileVers;
    char bJobX;
};

#ifndef __cplusplus
typedef struct TPrJob TPrJob;
#endif

typedef TPrJob *TPPrJob;

struct TPrint {
    short iPrVersion;               /*(2) Printing software version*/
    TPrInfo prInfo;                 /*(14) the PrInfo data associated with the current style.*/
    Rect rPaper;                    /*(8) The paper rectangle [offset from rPage]*/
    TPrStl prStl;                   /*(8)  This print request's style.*/
    TPrInfo prInfoPT;               /*(14)  Print Time Imaging metrics*/
    TPrXInfo prXInfo;               /*(16)  Print-time (expanded) Print info record.*/
    TPrJob prJob;                   /*(20) The Print Job request (82)  Total of the above; 120-82 = 38 bytes needed to fill 120*/
    short printX[19];               /*Spare to fill to 120 bytes!*/
};

#ifndef __cplusplus
typedef struct TPrint TPrint;
#endif

typedef TPrint *TPPrint, **THPrint;

/* The universal 120 byte printing record */
struct TPrStatus {
    short iTotPages;                /*Total pages in Print File.*/
    short iCurPage;                 /*Current page number*/
    short iTotCopies;               /*Total copies requested*/
    short iCurCopy;                 /*Current copy number*/
    short iTotBands;                /*Total bands per page.*/
    short iCurBand;                 /*Current band number*/
    Boolean fPgDirty;               /*True if current page has been written to.*/
    Boolean fImaging;               /*Set while in band's DrawPic call.*/
    THPrint hPrint;                 /*Handle to the active Printer record*/
    TPPrPort pPrPort;               /*Ptr to the active PrPort*/
    PicHandle hPic;                 /*Handle to the active Picture*/
};

#ifndef __cplusplus
typedef struct TPrStatus TPrStatus;
#endif

typedef TPrStatus *TPPrStatus;

/* Print Status: Print information during printing. */
struct TPfPgDir {
    short iPages;
    long iPgPos[129];               /*ARRAY [0..iPfMaxPgs] OF LONGINT*/
};

#ifndef __cplusplus
typedef struct TPfPgDir TPfPgDir;
#endif

typedef TPfPgDir *TPPfPgDir, **THPfPgDir;

/* PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!) */
struct TPrDlg {
    DialogRecord Dlg;               /*The Dialog window*/
    ModalFilterProcPtr pFltrProc;   /*The Filter Proc.*/
    PItemProcPtr pItemProc;         /*The Item evaluating proc.*/
    THPrint hPrintUsr;              /*The user's print record.*/
    Boolean fDoIt;
    Boolean fDone;
    long lUser1;                    /*Four longs for user's to hang global data.*/
    long lUser2;                    /*...Plus more stuff needed by the particular printing dialog.*/
    long lUser3;
    long lUser4;
};

#ifndef __cplusplus
typedef struct TPrDlg TPrDlg;
#endif

typedef TPrDlg *TPPrDlg;

typedef pascal TPPrDlg (*PDlgInitProcPtr)(THPrint hPrint);

/* This is the Printing Dialog Record. Only used by folks appending their own dialogs.
Print Dialog: The Dialog Stream object. */


struct TGnlData {
    short iOpCode;
    short iError;
    long lReserved;                 /*more fields here depending on call*/
};

#ifndef __cplusplus
typedef struct TGnlData TGnlData;
#endif

struct TRslRg {
    short iMin;
    short iMax;
};

#ifndef __cplusplus
typedef struct TRslRg TRslRg;
#endif

struct TRslRec {
    short iXRsl;
    short iYRsl;
};

#ifndef __cplusplus
typedef struct TRslRec TRslRec;
#endif

struct TGetRslBlk {
    short iOpCode;
    short iError;
    long lReserved;
    short iRgType;
    TRslRg xRslRg;
    TRslRg yRslRg;
    short iRslRecCnt;
    TRslRec rgRslRec[27];
};

#ifndef __cplusplus
typedef struct TGetRslBlk TGetRslBlk;
#endif

struct TSetRslBlk {
    short iOpCode;
    short iError;
    long lReserved;
    THPrint hPrint;
    short iXRsl;
    short iYRsl;
};

#ifndef __cplusplus
typedef struct TSetRslBlk TSetRslBlk;
#endif

struct TDftBitsBlk {
    short iOpCode;
    short iError;
    long lReserved;
    THPrint hPrint;
};

#ifndef __cplusplus
typedef struct TDftBitsBlk TDftBitsBlk;
#endif

struct TGetRotnBlk {
    short iOpCode;
    short iError;
    long lReserved;
    THPrint hPrint;
    Boolean fLandscape;
    char bXtra;
};

#ifndef __cplusplus
typedef struct TGetRotnBlk TGetRotnBlk;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void PrPurge(void)
    = {0x2F3C,0xA800,0x0000,0xA8FD}; 
pascal void PrNoPurge(void)
    = {0x2F3C,0xB000,0x0000,0xA8FD}; 
pascal Handle PrDrvrDCE(void)
    = {0x2F3C,0x9400,0x0000,0xA8FD}; 
pascal short PrDrvrVers(void)
    = {0x2F3C,0x9A00,0x0000,0xA8FD}; 
pascal void PrOpen(void)
    = {0x2F3C,0xC800,0x0000,0xA8FD}; 
pascal void PrClose(void)
    = {0x2F3C,0xD000,0x0000,0xA8FD}; 
pascal void PrintDefault(THPrint hPrint)
    = {0x2F3C,0x2004,0x0480,0xA8FD}; 
pascal Boolean PrValidate(THPrint hPrint)
    = {0x2F3C,0x5204,0x0498,0xA8FD}; 
pascal Boolean PrStlDialog(THPrint hPrint)
    = {0x2F3C,0x2A04,0x0484,0xA8FD}; 
pascal Boolean PrJobDialog(THPrint hPrint)
    = {0x2F3C,0x3204,0x0488,0xA8FD}; 
pascal void PrJobMerge(THPrint hPrintSrc,THPrint hPrintDst)
    = {0x2F3C,0x5804,0x089C,0xA8FD}; 
pascal TPPrPort PrOpenDoc(THPrint hPrint,TPPrPort pPrPort,Ptr pIOBuf)
    = {0x2F3C,0x0400,0x0C00,0xA8FD}; 
pascal void PrCloseDoc(TPPrPort pPrPort)
    = {0x2F3C,0x0800,0x0484,0xA8FD}; 
pascal void PrOpenPage(TPPrPort pPrPort,TPRect pPageFrame)
    = {0x2F3C,0x1000,0x0808,0xA8FD}; 
pascal void PrClosePage(TPPrPort pPrPort)
    = {0x2F3C,0x1800,0x040C,0xA8FD}; 
pascal void PrPicFile(THPrint hPrint,TPPrPort pPrPort,Ptr pIOBuf,Ptr pDevBuf,
    TPrStatus *prStatus)
    = {0x2F3C,0x6005,0x1480,0xA8FD}; 
pascal short PrError(void)
    = {0x2F3C,0xBA00,0x0000,0xA8FD}; 
pascal void PrSetError(short iErr)
    = {0x2F3C,0xC000,0x0200,0xA8FD}; 
pascal void PrGeneral(Ptr pData)
    = {0x2F3C,0x7007,0x0480,0xA8FD}; 
pascal void PrDrvrOpen(void)
    = {0x2F3C,0x8000,0x0000,0xA8FD}; 
pascal Boolean PrDlgMain(THPrint hPrint,PDlgInitProcPtr pDlgInit)
    = {0x2F3C,0x4A04,0x0894,0xA8FD}; 
pascal void PrDrvrClose(void)
    = {0x2F3C,0x8800,0x0000,0xA8FD}; 
pascal TPPrDlg PrJobInit(THPrint hPrint)
    = {0x2F3C,0x4404,0x0410,0xA8FD}; 
pascal void PrCtlCall(short iWhichCtl,long lParam1,long lParam2,long lParam3)
    = {0x2F3C,0xA000,0x0E00,0xA8FD}; 
pascal TPPrDlg PrStlInit(THPrint hPrint)
    = {0x2F3C,0x3C04,0x040C,0xA8FD}; 
#ifdef __safe_link
}
#endif

#endif

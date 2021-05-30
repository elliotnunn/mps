/************************************************************

Created: Tuesday, October 4, 1988 at 7:29 PM
    Printing.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __PRINTING__
#define __PRINTING__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#define iPFMaxPgs 128
#define iPrPgFract 120              /*Page scale factor. ptPgSize (below) is in units of 1/iPrPgFract*/
#define iPrPgFst 1                  /*Page range constants*/
#define iPrPgMax 9999
#define iPrRelease 3                /*Current version number of the code.*/
#define iPrSavPFil -1
#define iPrAbort 0x0080
#define iPrDevCtl 7                 /*The PrDevCtl Proc's ctl number*/
#define lPrReset 0x00010000         /*The PrDevCtl Proc's CParam for reset*/
#define lPrLineFeed 0x00030000
#define lPrLFStd 0x0003FFFF         /*The PrDevCtl Proc's CParam for std paper advance*/
#define lPrLFSixth 0x0003FFFF
#define lPrPageEnd 0x00020000       /*The PrDevCtl Proc's CParam for end page*/
#define lPrDocOpen 0x00010000
#define lPrPageOpen 0x00040000
#define lPrPageClose 0x00020000
#define lPrDocClose 0x00050000
#define iFMgrCtl 8                  /*The FMgr's Tail-hook Proc's ctl number*/
#define iMemFullErr -108
#define iIOAbort -27
#define pPrGlobals 0x00000944       /*The PrVars lo mem area:*/
#define bDraftLoop 0
#define bSpoolLoop 1
#define bUser1Loop 2
#define bUser2Loop 3
#define iPrBitsCtl 4
#define lScreenBits 0
#define lPaintBits 1
#define lHiScreenBits 0x00000002    /*The Bitmap Print Proc's Screen Bitmap param*/
#define lHiPaintBits 0x00000003     /*The Bitmap Print Proc's Paint [sq pix] param*/
#define iPrIOCtl 5
#define iPrEvtCtl 6                 /*The PrEvent Proc's ctl number*/
#define lPrEvtAll 0x0002FFFD        /*The PrEvent Proc's CParam for the entire screen*/
#define lPrEvtTop 0x0001FFFD        /*The PrEvent Proc's CParam for the top folder*/
#define sPrDrvr ".Print"
#define iPrDrvrRef -3
#define getRslDataOp 4
#define setRslOp 5
#define draftBitsOp 6
#define noDraftBitsOp 7
#define getRotnOp 8
#define NoSuchRsl 1
#define RgType1 1

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
    short wDev;
    short iPageV;
    short iPageH;
    char bPort;
    TFeed feed;
};

#ifndef __cplusplus
typedef struct TPrStl TPrStl;
#endif

typedef TPrStl *TPPrStl;

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
    short iFstPage;                 /*Page Range.*/
    short iLstPage;
    short iCopies;                  /*No. copies.*/
    char bJDocLoop;                 /*The Doc style: Draft, Spool, .., and ..*/
    Boolean fFromUsr;               /*Printing from an User's App (not PrApp) flag*/
    PrIdleProcPtr pIdleProc;        /*The Proc called while waiting on IO etc.*/
    StringPtr pFileName;            /*Spool File Name: NIL for default.*/
    short iFileVol;                 /*Spool File vol, set to 0 initially*/
    char bFileVers;                 /*Spool File version, set to 0 initially*/
    char bJobX;                     /*An eXtra byte.*/
};

#ifndef __cplusplus
typedef struct TPrJob TPrJob;
#endif

typedef TPrJob *TPPrJob;

/* Print Job: Print "form" for a single print request. */
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
pascal void PrPurge(void); 
pascal void PrNoPurge(void); 
pascal void PrOpen(void); 
pascal void PrClose(void); 
pascal void PrintDefault(THPrint hPrint); 
pascal Boolean PrValidate(THPrint hPrint); 
pascal Boolean PrStlDialog(THPrint hPrint); 
pascal Boolean PrJobDialog(THPrint hPrint); 
pascal TPPrDlg PrStlInit(THPrint hPrint); 
pascal TPPrDlg PrJobInit(THPrint hPrint); 
pascal void PrJobMerge(THPrint hPrintSrc,THPrint hPrintDst); 
pascal Boolean PrDlgMain(THPrint hPrint,PDlgInitProcPtr pDlgInit); 
pascal TPPrPort PrOpenDoc(THPrint hPrint,TPPrPort pPrPort,Ptr pIOBuf); 
pascal void PrCloseDoc(TPPrPort pPrPort); 
pascal void PrOpenPage(TPPrPort pPrPort,TPRect pPageFrame); 
pascal void PrClosePage(TPPrPort pPrPort); 
pascal void PrPicFile(THPrint hPrint,TPPrPort pPrPort,Ptr pIOBuf,Ptr pDevBuf,
    TPrStatus *prStatus); 
pascal short PrError(void); 
pascal void PrSetError(short iErr); 
pascal void PrGeneral(Ptr pData); 
pascal void PrDrvrOpen(void); 
pascal void PrDrvrClose(void); 
pascal void PrCtlCall(short iWhichCtl,long lParam1,long lParam2,long lParam3); 
pascal Handle PrDrvrDCE(void); 
pascal short PrDrvrVers(void); 
#ifdef __safe_link
}
#endif

#endif

/*
	Printing.h -- Printing Manager

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __PRINTING__
#define __PRINTING__
#ifndef __QUICKDRAW__
#include <QuickDraw.h>
#endif
#ifndef __DIALOGS__
#include <Dialogs.h>
#endif


#define bDraftLoop 	0
#define bSpoolLoop 	1
#define bDevCItoh 	1
#define bDevLaser 	3
#define iPFMaxPgs 	128
#define iPrPgFract 	120
#define iPrSavPFil 	(-1)
#define iPrAbort 		128
#define iPrDevCtl 	7
#define lPrReset 		0x00010000
#define lPrLineFeed 	0x00030000
#define lPrLFSixth 	0x0003FFFF
#define lPrPageEnd 	0x00020000

/* new control codes for the low level driver */
#define lPrDocOpen 	0x00010000		/* note: same as lPrReset */
											/* low order byte indicates number of */
										   /* copies to print */
#define lPrPageOpen 	0x00040000
#define lPrPageClose 0x00020000	/* note: same as lPrPageEnd */
#define lPrDocClose 	0x00050000

#define iPrBitsCtl 	4
#define lScreenBits	0
#define lPaintBits 	1
#define iPrIOCtl 		5
#define sPrDrvr 		".Print"
#define iPrDrvrRef 	(-3)
#define bDevCItoh 	1
#define iDevCItoh 	(bDevCItoh << 8)
#define bDevDaisy 	2
#define iDevDaisy 	(bDevDaisy << 8)
#define bDevLaser 	3
#define iDevLaser 	(bDevLaser << 8)
/* PrGeneral constants */
#define getRslDataOp	 4
#define setRslOp		 5
#define draftBitsOp	 6
#define noDraftBitsOp 7
#define getRotnOp		 8
#define NoSuchRsl		 1
#define RgType1		 1


typedef Rect *TPRect;
typedef struct TPrPort {
	GrafPort gPort;
	QDProcs gProcs;
	long lGParam1;
	long lGParam2;
	long lGParam3;
	long lGParam4;
	Boolean fOurPtr;
	Boolean fOurBits;
} TPrPort,*TPPrPort;
typedef struct TPrInfo {
	short iDev;
	short iVRes;
	short iHRes;
	Rect rPage;
} TPrInfo;
typedef enum {feedCut,feedFanfold,feedMechCut,feedOther} TFeed;
typedef struct TPrStl {
	short wDev;
	short iPageV;
	short iPageH;
	char bPort;
	TFeed feed;
} TPrStl;
typedef enum {scanTB,scanBT,scanLR,scanRL} TScan;
typedef struct TPrXInfo {
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
} TPrXInfo;
typedef struct TPrJob {
	short iFstPage;
	short iLstPage;
	short iCopies;
	char bJDocLoop;
	Boolean fFromUsr;
	ProcPtr pIdleProc;
	StringPtr pFileName;
	short iFileVol;
	char bFileVers;
	char bJobX;
} TPrJob;
typedef struct TPrint {
	short iPrVersion;
	TPrInfo prInfo;
	Rect rPaper;
	TPrStl prStl;
	TPrInfo prInfoPT;
	TPrXInfo prXInfo;
	TPrJob prJob;
	short printX[19]
} TPrint,*TPPrint,**THPrint;
typedef struct TPrStatus {
	short iTotPages;
	short iCurPage;
	short iTotCopies;
	short iCurCopy;
	short iTotBands;
	short iCurBand;
	Boolean fPgDirty;
	Boolean fImaging;
	THPrint hPrint;
	TPPrPort pPrPort;
	PicHandle hPic;
} TPrStatus;
typedef struct TPrDlg {
	DialogRecord	Dlg;
	ProcPtr			pFltrProc;
	ProcPtr			pItemProc;
	THPrint			hPrintUsr;
	Boolean			fDoIt;
	Boolean			fDone;
	long				lUser1;
	long				lUser2;
	long				lUser3;
	long				lUser4;
} TPrDlg,*TPPrDlg;
/* typedefs useful for PRGeneral */
typedef struct TGnlData {
	int		iOpCode;
	int		iError;
	long		lReserved;
	/* more fields here, depending on particular call */
} TGnlData;
typedef struct TRslRg {
	int		iMin;
	int		iMax;
} TRslRg;
typedef struct TRslRec {
	int		iXRsl;
	int		iYRsl;
} TRslRec;
typedef struct TGetRslBlk {
	int		iOpCode;
	int		iError;
	long		lReserved;
	int		iRgType;
	TRslRg	XRslRg;
	TRslRg	YRslRg;
	int		iRslRecCnt;
	TRslRec	rgRslRec[27];
} TGetRslBlk;
typedef struct TSetRslBk {
	int		iOpCode;
	int		iError;
	long		lReserved;
	THPrint	hPrint;
	int		iRgType;
	int		iXRsl;
	int		iYRsl;
} TSetRslBlk;
typedef struct TDftBitsBlk {
	int		iOpCode;
	int		iError;
	long		lReserved;
	THPrint	hPrint;
} TDftBitsBlk;
typedef struct TGetRotnBlk {
	int		iOpCode;
	int		iError;
	long		lReserved;
	THPrint	hPrint;
	Boolean	fLandscape;
	char		bXtra;
} TGetRotnBlk;


pascal void PrPurge()
	extern;
pascal void PrNoPurge()
	extern;
pascal void PrOpen()
	extern;
pascal void PrClose()
	extern;
pascal void PrintDefault(hPrint)
	THPrint hPrint;
	extern;
pascal Boolean PrValidate(hPrint)
	THPrint hPrint;
	extern;
pascal Boolean PrStlDialog(hPrint)
	THPrint hPrint;
	extern;
pascal Boolean PrJobDialog(hPrint)
	THPrint hPrint;
	extern;
pascal TPPrDlg PrStlInit(hPrint)
	THPrint hPrint;
	extern;
pascal TPPrDlg PrJobInit(hPrint)
	THPrint hPrint;
	extern;
pascal Boolean PrDlgMain(hPrint,pDlgInit)
	THPrint hPrint;
	ProcPtr pDlgInit;
	extern;
pascal void PrJobMerge(hPrintSrc,hPrintDst)
	THPrint hPrintSrc,hPrintDst;
	extern;
pascal TPPrPort PrOpenDoc(hPrint,pPrPort,pIOBuf)
	THPrint hPrint;
	TPPrPort pPrPort;
	Ptr pIOBuf;
	extern;
pascal void PrCloseDoc(pPrPort)
	TPPrPort pPrPort;
	extern;
pascal void PrOpenPage(pPrPort,pPageFrame)
	TPPrPort pPrPort;
	TPRect pPageFrame;
	extern;
pascal void PrClosePage(pPrPort)
	TPPrPort pPrPort;
	extern;
pascal void PrPicFile(hPrint,pPrPort,pIOBuf,pDevBuf,prStatus)
	THPrint hPrint;
	TPPrPort pPrPort;
	Ptr pIOBuf,pDevBuf;
	TPrStatus *prStatus;
	extern;
pascal short PrError()
	extern;
pascal void PrSetError(iErr)
	short iErr;
	extern;
pascal void PrGeneral(pData)
	Ptr pData;
	extern;
	
pascal void PrDrvrOpen()
	extern;
pascal void PrDrvrClose()
	extern;
pascal void PrCtlCall(iWhichCtl,lParam1,lParam2,lParam3)
	short iWhichCtl;
	long lParam1,lParam2,lParam3;
	extern;
pascal Handle PrDrvrDCE()
	extern;
pascal short PrDrvrVers()
	extern;
#endif

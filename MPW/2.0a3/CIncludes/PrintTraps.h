/*
	PrintTraps.h -- Printing Manager interface 

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
#define lPrDocOpen 	0x00010000	/* note: same as lPrReset */
											/* low order byte indicates number of */
										   /* copies to print */
#define lPrPageOpen 	0x00040000
#define lPrPageClose 0x00020000	/* note: same as lPrPageEnd */
#define lPrDocClose 	0x00050000

#define iPrBitsCtl 	4
#define lScreenBits 	0
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

/* Since we don't have the INLINE facility available in C,
 * we do the following. 
 * 
 * For a Print Manager call Prx(a,b) - 
 * 
 *		#define Prx(a,b)	cPrx(a,b,ALongControlWord)
 *		Where cPrx(a,b,ALongControlWord) is
 *			Pascal void cPrx(a,b,ALongControlWord)
 *				TypeOfa	a;
 *				TypeOfb	b;
 *				long		ALongControlWord;
 *				extern	0xA8FD;
 *
 *	This will correctly push the Long control word 
 * before generating the trap.
 *
 */

/* define longwords (control words) for Prxxx calls */


#define	PrOpenDocLW		0x04000C00	
#define	PrCloseDocLW	0x08000484	
#define	PrOpenPageLW	0x10000808	
#define	PrClosePageLW	0x1800040C	
#define	PrintDefaultLW	0x20040480	
#define	PrStlDialogLW	0x2A040484	
#define	PrJobDialogLW	0x32040488	
#define	PrStlInitLW		0x3C04040C	
#define	PrJobInitLW		0x44040410	
#define	PrDlgMainLW		0x4A040894	
#define	PrValidateLW	0x52040498	
#define	PrJobMergeLW	0x5804089C	
#define	PrPicFileLW		0x60051480	
#define	PrHackLW			0x6C070C80	
#define	PrGeneralLW		0x70070480	
#define	PrDrvrOpenLW	0x80000000	
#define	PrDrvrCloseLW	0x88000C00	
#define	PrDrvrDCELW		0x94000000	
#define	PrDrvrVersLW	0x9A000000	
#define	PrCtlCallLW		0xA0000E00	
#define	PrPurgeLW		0xA8000000	
#define	PrNoPurgeLW		0xB0000000	
#define	PrErrorLW		0xBA000000	
#define	PrSetErrorLW	0xC0000200	
#define	PrOpenLW			0xC8000000	
#define	PrCloseLW		0xD0000000

/* Now declare routines that will cause the print trap */
pascal void cPrPurge(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrNoPurge(LW)
	long	LW;
	extern 0xA8FD;
pascal Handle cPrDrvrDCE(LW)
	long	LW;
	extern 0xA8FD;
pascal short cPrDrvrVers(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrOpen(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrClose(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrintDefault(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal Boolean cPrValidate(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal Boolean cPrStlDialog(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal Boolean cPrJobDialog(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal TPPrDlg PrStlInit(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal TPPrDlg PrJobInit(hPrint,LW)
	THPrint hPrint;
	long	LW;
	extern 0xA8FD;
pascal Boolean PrDlgMain(hPrint,pDlgInit,LW)
	THPrint hPrint;
	ProcPtr pDlgInit;
	long	LW;
	extern 0xA8FD;
pascal void cPrJobMerge(hPrintSrc,hPrintDst,LW)
	THPrint hPrintSrc,hPrintDst;
	long	LW;
	extern 0xA8FD;
pascal TPPrPort cPrOpenDoc(hPrint,pPrPort,pIOBuf,LW)
	THPrint hPrint;
	TPPrPort pPrPort;
	Ptr pIOBuf;
	long	LW;
	extern 0xA8FD;
pascal void cPrCloseDoc(pPrPort,LW)
	TPPrPort pPrPort;
	long	LW;
	extern 0xA8FD;
pascal void cPrOpenPage(pPrPort,pPageFrame,LW)
	TPPrPort pPrPort;
	TPRect pPageFrame;
	long	LW;
	extern 0xA8FD;
pascal void cPrClosePage(pPrPort,LW)
	TPPrPort pPrPort;
	long	LW;
	extern 0xA8FD;
pascal void cPrPicFile(hPrint,pPrPort,pIOBuf,pDevBuf,prStatus,LW)
	THPrint hPrint;
	TPPrPort pPrPort;
	Ptr pIOBuf,pDevBuf;
	TPrStatus *prStatus;
	long	LW;
	extern 0xA8FD;
pascal short cPrError(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrSetError(iErr,LW)
	short iErr;
	long	LW;
	extern 0xA8FD;
pascal void cPrGeneral(pData,LW)
	Ptr	pData;
	long	LW;
	extern 0xA8FD;
pascal void cPrDrvrOpen(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrDrvrClose(LW)
	long	LW;
	extern 0xA8FD;
pascal void cPrCtlCall(iWhichCtl,lParam1,lParam2,lParam3,LW)
	short iWhichCtl;
	long lParam1,lParam2,lParam3;
	long	LW;
	extern 0xA8FD;
pascal Handle cPrDrvrDCE(LW)
	long	LW;
	extern 0xA8FD;
pascal short cPrDrvrVers(LW)
	long	LW;
	extern 0xA8FD;

/* define Prxxx to be cPrxxx with an additional parameter */

#define 	PrPurge()				cPrPurge(PrPurgeLW)
#define 	PrNoPurge()				cPrNoPurge(PrNoPurgeLW)
#define 	PrDrvrDCE()				cPrDrvrDCE(PrDrvrDCELW)
#define 	PrDrvrVers()			cPrDrvrVers(PrDrvrVersLW)
#define	PrOpen() 				cPrOpen(PrOpenLW)
#define	PrClose() 				cPrClose(PrCloseLW)
#define	PrintDefault(hPrint) cPrintDefault(hPrint,PrintDefaultLW)
#define	PrValidate(hPrint) 	cPrValidate(hPrint,PrValidateLW)
#define	PrStlDialog(hPrint) 	cPrStlDialog(hPrint,PrStlDialogLW)
#define	PrJobDialog(hPrint) 	cPrJobDialog(hPrint,PrJobDialogLW)
#define  PrStlInit(hPrint)		cPrStlInit(hPrint,PrStlInitLW)
#define  PrJobInit(hPrint)		cPrJobInit(hPrint,PrJobInitLW)
#define  PrDlgMain(hPrint,pDlgInit)			cPrDlgMain(hPrint,pDlgInit,PrDlgMainLW)
#define	PrJobMerge(hPrintSrc,hPrintDst) 	cPrJobMerge(hPrintSrc,hPrintDst,PrJobMergeLW)
#define	PrOpenDoc(hPrint,pPrPort,pIOBuf) cPrOpenDoc(hPrint,pPrPort,pIOBuf,PrOpenDocLW)
#define	PrCloseDoc(pPrPort) 					cPrCloseDoc(pPrPort,PrCloseDocLW)
#define	PrOpenPage(pPrPort,pPageFrame) 	cPrOpenPage(pPrPort,pPageFrame,PrOpenPageLW)
#define	PrClosePage(pPrPort) 				cPrClosePage(pPrPort,PrClosePageLW)
#define	PrPicFile(hPrint,pPrPort,pIOBuf,pDevBuf,prStatus) 	cPrPicFile(hPrint,pPrPort,pIOBuf,pDevBuf,prStatus,PrPicFileLW)
#define	PrError() 				cPrError(PrErrorLW)
#define	PrSetError(iErr) 		cPrSetError(iErr,PrSetErrorLW)
#define	PrGeneral(pData) 		cPrGeneral(pData,PrGeneralLW)
#define	PrDrvrOpen() 			cPrDrvrOpen(PrDrvrOpenLW)
#define	PrDrvrClose() 			cPrDrvrClose(PrDrvrCloseLW)
#define	PrCtlCall(iWhichCtl,lParam1,lParam2,lParam3) 		cPrCtlCall(iWhichCtl,lParam1,lParam2,lParam3,PrCtlCallLW)
#define	PrDrvrDCE() 			cPrDrvrDCE(PrDrvrDCELW)
#define	PrDrvrVers() 			cPrDrvrVers(PrDrvrVersLW)


#endif

/*
 	File:		Printing.h
 
 	Contains:	Print Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __PRINTING__
#define __PRINTING__


#ifndef __ERRORS__
#include <Errors.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <Types.h>											*/
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Memory.h>											*/
/*	#include <Menus.h>											*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	iPFMaxPgs					= 128,
	iPrPgFract					= 120,							/*Page scale factor. ptPgSize (below) is in units of 1/iPrPgFract*/
	iPrPgFst					= 1,							/*Page range constants*/
	iPrPgMax					= 9999,
	iPrRelease					= 3,							/*Current version number of the code.*/
	iPrSavPFil					= -1,
	iPrAbort					= 0x0080,
	iPrDevCtl					= 7,							/*The PrDevCtl Proc's ctl number*/
	lPrReset					= 0x00010000,					/*The PrDevCtl Proc's CParam for reset*/
	lPrLineFeed					= 0x00030000,
	lPrLFStd					= 0x0003FFFF,					/*The PrDevCtl Proc's CParam for std paper advance*/
	lPrLFSixth					= 0x0003FFFF,
	lPrPageEnd					= 0x00020000,					/*The PrDevCtl Proc's CParam for end page*/
	lPrDocOpen					= 0x00010000,
	lPrPageOpen					= 0x00040000,
	lPrPageClose				= 0x00020000,
	lPrDocClose					= 0x00050000,
	iFMgrCtl					= 8,							/*The FMgr's Tail-hook Proc's ctl number*/
	iMscCtl						= 9,							/*The FMgr's Tail-hook Proc's ctl number*/
	iPvtCtl						= 10							/*The FMgr's Tail-hook Proc's ctl number*/
};

#define sPrDrvr ".Print"
enum {
	pPrGlobals					= 0x00000944,					/*The PrVars lo mem area:*/
	bDraftLoop					= 0,
	bSpoolLoop					= 1,
	bUser1Loop					= 2,
	bUser2Loop					= 3,
	fNewRunBit					= 2,
	fHiResOK					= 3,
	fWeOpenedRF					= 4,
/*Driver constants */
	iPrBitsCtl					= 4,
	lScreenBits					= 0,
	lPaintBits					= 1,
	lHiScreenBits				= 0x00000002,					/*The Bitmap Print Proc's Screen Bitmap param*/
	lHiPaintBits				= 0x00000003,					/*The Bitmap Print Proc's Paint [sq pix] param*/
	iPrIOCtl					= 5,
	iPrEvtCtl					= 6,							/*The PrEvent Proc's ctl number*/
	lPrEvtAll					= 0x0002FFFD,					/*The PrEvent Proc's CParam for the entire screen*/
	lPrEvtTop					= 0x0001FFFD,					/*The PrEvent Proc's CParam for the top folder*/
	iPrDrvrRef					= -3
};

enum {
	getRslDataOp				= 4,
	setRslOp					= 5,
	draftBitsOp					= 6,
	noDraftBitsOp				= 7,
	getRotnOp					= 8,
	NoSuchRsl					= 1,
	OpNotImpl					= 2,							/*the driver doesn't support this opcode*/
	RgType1						= 1
};

enum {
	feedCut,
	feedFanfold,
	feedMechCut,
	feedOther
};

typedef SInt8 TFeed;


enum {
	scanTB,
	scanBT,
	scanLR,
	scanRL
};

typedef SInt8 TScan;

/* A Rect Ptr */
typedef Rect *TPRect;

typedef pascal void (*PrIdleProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr PrIdleUPP;
#else
typedef PrIdleProcPtr PrIdleUPP;
#endif

enum {
	uppPrIdleProcInfo = kPascalStackBased
};

#if GENERATINGCFM
#define NewPrIdleProc(userRoutine)		\
		(PrIdleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPrIdleProcInfo, GetCurrentArchitecture())
#else
#define NewPrIdleProc(userRoutine)		\
		((PrIdleUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallPrIdleProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPrIdleProcInfo)
#else
#define CallPrIdleProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef pascal void (*PItemProcPtr)(DialogPtr theDialog, short item);

#if GENERATINGCFM
typedef UniversalProcPtr PItemUPP;
#else
typedef PItemProcPtr PItemUPP;
#endif

enum {
	uppPItemProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewPItemProc(userRoutine)		\
		(PItemUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPItemProcInfo, GetCurrentArchitecture())
#else
#define NewPItemProc(userRoutine)		\
		((PItemUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallPItemProc(userRoutine, theDialog, item)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPItemProcInfo, (theDialog), (item))
#else
#define CallPItemProc(userRoutine, theDialog, item)		\
		(*(userRoutine))((theDialog), (item))
#endif

struct TPrPort {
	GrafPort						gPort;						/*The Printer's graf port.*/
	QDProcs							gProcs;						/*..and its procs*/
	long							lGParam1;					/*16 bytes for private parameter storage.*/
	long							lGParam2;
	long							lGParam3;
	long							lGParam4;
	Boolean							fOurPtr;					/*Whether the PrPort allocation was done by us.*/
	Boolean							fOurBits;					/*Whether the BitMap allocation was done by us.*/
};
typedef struct TPrPort TPrPort, *TPPrPort;

/* Printing Graf Port. All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.
  This is the "PrPeek" record. */
struct TPrInfo {
	short							iDev;						/*Font mgr/QuickDraw device code*/
	short							iVRes;						/*Resolution of device, in device coordinates*/
	short							iHRes;						/*..note: V before H => compatable with Point.*/
	Rect							rPage;						/*The page (printable) rectangle in device coordinates.*/
};
typedef struct TPrInfo TPrInfo, *TPPrInfo;

/* Print Info Record: The parameters needed for page composition. */
struct TPrStl {
	short							wDev;
	short							iPageV;
	short							iPageH;
	SInt8							bPort;
	TFeed							feed;
};
typedef struct TPrStl TPrStl, *TPPrStl;

struct TPrXInfo {
	short							iRowBytes;
	short							iBandV;
	short							iBandH;
	short							iDevBytes;
	short							iBands;
	SInt8							bPatScale;
	SInt8							bUlThick;
	SInt8							bUlOffset;
	SInt8							bUlShadow;
	TScan							scan;
	SInt8							bXInfoX;
};
typedef struct TPrXInfo TPrXInfo, *TPPrXInfo;

struct TPrJob {
	short							iFstPage;					/*Page Range.*/
	short							iLstPage;
	short							iCopies;					/*No. copies.*/
	SInt8							bJDocLoop;					/*The Doc style: Draft, Spool, .., and ..*/
	Boolean							fFromUsr;					/*Printing from an User's App (not PrApp) flag*/
	PrIdleUPP						pIdleProc;					/*The Proc called while waiting on IO etc.*/
	StringPtr						pFileName;					/*Spool File Name: NIL for default.*/
	short							iFileVol;					/*Spool File vol, set to 0 initially*/
	SInt8							bFileVers;					/*Spool File version, set to 0 initially*/
	SInt8							bJobX;						/*An eXtra byte.*/
};
typedef struct TPrJob TPrJob, *TPPrJob;

/* Print Job: Print "form" for a single print request. */
struct TPrint {
	short							iPrVersion;					/*(2) Printing software version*/
	TPrInfo							prInfo;						/*(14) the PrInfo data associated with the current style.*/
	Rect							rPaper;						/*(8) The paper rectangle [offset from rPage]*/
	TPrStl							prStl;						/*(8)  This print request's style.*/
	TPrInfo							prInfoPT;					/*(14)  Print Time Imaging metrics*/
	TPrXInfo						prXInfo;					/*(16)  Print-time (expanded) Print info record.*/
	TPrJob							prJob;						/*(20) The Print Job request (82)  Total of the above; 120-82 = 38 bytes needed to fill 120*/
	short							printX[19];					/*Spare to fill to 120 bytes!*/
};
typedef struct TPrint TPrint, *TPPrint, **THPrint;

/* The universal 120 byte printing record */
struct TPrStatus {
	short							iTotPages;					/*Total pages in Print File.*/
	short							iCurPage;					/*Current page number*/
	short							iTotCopies;					/*Total copies requested*/
	short							iCurCopy;					/*Current copy number*/
	short							iTotBands;					/*Total bands per page.*/
	short							iCurBand;					/*Current band number*/
	Boolean							fPgDirty;					/*True if current page has been written to.*/
	Boolean							fImaging;					/*Set while in band's DrawPic call.*/
	THPrint							hPrint;						/*Handle to the active Printer record*/
	TPPrPort						pPrPort;					/*Ptr to the active PrPort*/
	PicHandle						hPic;						/*Handle to the active Picture*/
};
typedef struct TPrStatus TPrStatus, *TPPrStatus;

/* Print Status: Print information during printing. */
struct TPfPgDir {
	short							iPages;
	long							iPgPos[129];				/*ARRAY [0..iPfMaxPgs] OF LONGINT*/
};
typedef struct TPfPgDir TPfPgDir, *TPPfPgDir, **THPfPgDir;

/* PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!) */
/* This is the Printing Dialog Record. Only used by folks appending their own
   DITLs to the print dialogs.	Print Dialog: The Dialog Stream object. */
struct TPrDlg {
	DialogRecord					Dlg;						/*The Dialog window*/
	ModalFilterUPP					pFltrProc;					/*The Filter Proc.*/
	PItemUPP						pItemProc;					/*The Item evaluating proc.*/
	THPrint							hPrintUsr;					/*The user's print record.*/
	Boolean							fDoIt;
	Boolean							fDone;
	long							lUser1;						/*Four longs for apps to hang global data.*/
	long							lUser2;						/*Plus more stuff needed by the particular*/
	long							lUser3;						/*printing dialog.*/
	long							lUser4;
};
typedef struct TPrDlg TPrDlg;

typedef TPrDlg *TPPrDlg;

typedef TPrDlg *TPPrDlgRef;


typedef pascal TPPrDlgRef (*PDlgInitProcPtr)(THPrint hPrint);

#if GENERATINGCFM
typedef UniversalProcPtr PDlgInitUPP;
#else
typedef PDlgInitProcPtr PDlgInitUPP;
#endif

enum {
	uppPDlgInitProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(TPPrDlgRef)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(THPrint)))
};

#if GENERATINGCFM
#define NewPDlgInitProc(userRoutine)		\
		(PDlgInitUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPDlgInitProcInfo, GetCurrentArchitecture())
#else
#define NewPDlgInitProc(userRoutine)		\
		((PDlgInitUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallPDlgInitProc(userRoutine, hPrint)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPDlgInitProcInfo, (hPrint))
#else
#define CallPDlgInitProc(userRoutine, hPrint)		\
		(*(userRoutine))((hPrint))
#endif

struct TGnlData {
	short							iOpCode;
	short							iError;
	long							lReserved;					/*more fields here depending on call*/
};
typedef struct TGnlData TGnlData;

struct TRslRg {
	short							iMin;
	short							iMax;
};
typedef struct TRslRg TRslRg;

struct TRslRec {
	short							iXRsl;
	short							iYRsl;
};
typedef struct TRslRec TRslRec;

struct TGetRslBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	short							iRgType;
	TRslRg							xRslRg;
	TRslRg							yRslRg;
	short							iRslRecCnt;
	TRslRec							rgRslRec[27];
};
typedef struct TGetRslBlk TGetRslBlk;

struct TSetRslBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	THPrint							hPrint;
	short							iXRsl;
	short							iYRsl;
};
typedef struct TSetRslBlk TSetRslBlk;

struct TDftBitsBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	THPrint							hPrint;
};
typedef struct TDftBitsBlk TDftBitsBlk;

struct TGetRotnBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	THPrint							hPrint;
	Boolean							fLandscape;
	SInt8							bXtra;
};
typedef struct TGetRotnBlk TGetRotnBlk;

extern pascal void PrPurge(void)
 FOURWORDINLINE(0x2F3C, 0xA800, 0x0000, 0xA8FD);
extern pascal void PrNoPurge(void)
 FOURWORDINLINE(0x2F3C, 0xB000, 0x0000, 0xA8FD);
extern pascal void PrOpen(void)
 FOURWORDINLINE(0x2F3C, 0xC800, 0x0000, 0xA8FD);
extern pascal void PrClose(void)
 FOURWORDINLINE(0x2F3C, 0xD000, 0x0000, 0xA8FD);
extern pascal void PrintDefault(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x2004, 0x0480, 0xA8FD);
extern pascal Boolean PrValidate(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x5204, 0x0498, 0xA8FD);
extern pascal Boolean PrStlDialog(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x2A04, 0x0484, 0xA8FD);
extern pascal Boolean PrJobDialog(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x3204, 0x0488, 0xA8FD);
extern pascal TPPrDlgRef PrStlInit(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x3C04, 0x040C, 0xA8FD);
extern pascal TPPrDlgRef PrJobInit(THPrint hPrint)
 FOURWORDINLINE(0x2F3C, 0x4404, 0x0410, 0xA8FD);
extern pascal void PrJobMerge(THPrint hPrintSrc, THPrint hPrintDst)
 FOURWORDINLINE(0x2F3C, 0x5804, 0x089C, 0xA8FD);
extern pascal Boolean PrDlgMain(THPrint hPrint, PDlgInitUPP pDlgInit)
 FOURWORDINLINE(0x2F3C, 0x4A04, 0x0894, 0xA8FD);
extern pascal TPPrPort PrOpenDoc(THPrint hPrint, TPPrPort pPrPort, Ptr pIOBuf)
 FOURWORDINLINE(0x2F3C, 0x0400, 0x0C00, 0xA8FD);
extern pascal void PrCloseDoc(TPPrPort pPrPort)
 FOURWORDINLINE(0x2F3C, 0x0800, 0x0484, 0xA8FD);
extern pascal void PrOpenPage(TPPrPort pPrPort, TPRect pPageFrame)
 FOURWORDINLINE(0x2F3C, 0x1000, 0x0808, 0xA8FD);
extern pascal void PrClosePage(TPPrPort pPrPort)
 FOURWORDINLINE(0x2F3C, 0x1800, 0x040C, 0xA8FD);
extern pascal void PrPicFile(THPrint hPrint, TPPrPort pPrPort, Ptr pIOBuf, Ptr pDevBuf, TPrStatus *prStatus)
 FOURWORDINLINE(0x2F3C, 0x6005, 0x1480, 0xA8FD);
extern pascal short PrError(void)
 FOURWORDINLINE(0x2F3C, 0xBA00, 0x0000, 0xA8FD);
extern pascal void PrSetError(short iErr)
 FOURWORDINLINE(0x2F3C, 0xC000, 0x0200, 0xA8FD);
extern pascal void PrGeneral(Ptr pData)
 FOURWORDINLINE(0x2F3C, 0x7007, 0x0480, 0xA8FD);
extern pascal void PrDrvrOpen(void)
 FOURWORDINLINE(0x2F3C, 0x8000, 0x0000, 0xA8FD);
extern pascal void PrDrvrClose(void)
 FOURWORDINLINE(0x2F3C, 0x8800, 0x0000, 0xA8FD);
extern pascal void PrCtlCall(short iWhichCtl, long lParam1, long lParam2, long lParam3)
 FOURWORDINLINE(0x2F3C, 0xA000, 0x0E00, 0xA8FD);
extern pascal Handle PrDrvrDCE(void)
 FOURWORDINLINE(0x2F3C, 0x9400, 0x0000, 0xA8FD);
extern pascal short PrDrvrVers(void)
 FOURWORDINLINE(0x2F3C, 0x9A00, 0x0000, 0xA8FD);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __PRINTING__ */

{
  File: MacPrint.p

 Version: 1.0

 Copyright Apple Computer, Inc. 1984, 1985, 1986
 All Rights Reserved

}

UNIT MacPrint;

  INTERFACE

	{ ---------------------------------------------------------------------- }

	USES {$U MemTypes.p } MemTypes,
	  {$U QuickDraw.p } QuickDraw,
	  {$U OSIntf.p	  } OSIntf,
	  {$U ToolIntf.p  } ToolIntf;

	  { ---------------------------------------------------------------------- }
	  { 	   This is the Public interface to MacPrint    }
	  { ---------------------------------------------------------------------- }

	CONST
	  iPrPgFract = 120; {Page scale factor. ptPgSize (below) is in units of
						 1/iPrPgFract }

	  iPrPgFst = 1; {Page range constants}
	  iPrPgMax = 9999;

	  iPrRelease = 3; {Current version number of the code.} {DC 7/23/84}
	  iPfMaxPgs = 128; {Max number of pages in a print file.}

	  {Driver constants}
	  iPrBitsCtl = 4; {The Bitmap Print Proc's ctl number}
	  lScreenBits = $00000000; {The Bitmap Print Proc's Screen Bitmap param}
	  lPaintBits = $00000001; {The Bitmap Print Proc's Paint [sq pix] param}
	  lHiScreenBits = $00000010; {The Bitmap Print Proc's Screen Bitmap param}
	  lHiPaintBits = $00000011; {The Bitmap Print Proc's Paint [sq pix] param}
	  iPrIOCtl = 5; {The Raw Byte IO Proc's ctl number}
	  iPrEvtCtl = 6; {The PrEvent Proc's ctl number}
	  lPrEvtAll = $0002FFFD; {The PrEvent Proc's CParam for the entire screen}
	  lPrEvtTop = $0001FFFD; {The PrEvent Proc's CParam for the top folder}
	  iPrDevCtl = 7; {The PrDevCtl Proc's ctl number}
	  lPrReset = $00010000; {The PrDevCtl Proc's CParam for reset}
	  lPrPageEnd = $00020000; {The PrDevCtl Proc's CParam for end page}
	  lPrLineFeed = $00030000; {The PrDevCtl Proc's CParam for paper advance}
	  lPrLFSixth = $0003FFFF; {The PrDevCtl Proc's CParam for 1/6 th inch paper
							   advance}
	  lPrLFEighth = $0003FFFE; {The PrDevCtl Proc's CParam for 1/8 th inch paper
								advance}
	  iFMgrCtl = 8; {The FMgr's Tail-hook Proc's ctl number}
	  { [The Pre-Hook is the status call] }

	  {Error Constants:}
	  iMemFullErr = - 108;
	  iPrAbort = 128;
	  iIOAbort = - 27;

	  {The PrVars lo mem area:}
	  pPrGlobals = $00000944;
	  bDraftLoop = 0;
	  bSpoolLoop = 1;
	  bUser1Loop = 2;
	  bUser2Loop = 3;

	  {The Currently supported printers:}
	  bDevCItoh = 1;
	  iDevCItoh = $0100; {CItoh}
	  bDevDaisy = 2;
	  iDevDaisy = $0200; {Daisy}
	  bDevLaser = 3;
	  iDevLaser = $0300; {Laser}

	  { ---------------------------------------------------------------------- }

	TYPE

	  TPRect = ^Rect; {A Rect Ptr}
	  TPBitMap = ^BitMap; {A BitMap Ptr}

	  {NOTE: Changes will also affect: PrEqu, TCiVars & TPfVars}
	  TPrVars = RECORD {4 longs for printing, see SysEqu for location.}
				  iPrErr: Integer; {Current print error. Set to iPrAbort to abort
									printing.}
				  bDocLoop: SignedByte; {The Doc style: Draft, Spool, .., and ..}
						  {Currently use low 2 bits; the upper 6 are for flags.}
				  bUser1: SignedByte; {Spares used by the print code}
				  lUser1: LongInt;
				  lUser2: LongInt;
				  lUser3: LongInt;
				END;
	  TPPrVars = ^TPrVars;

	  TPrInfo = RECORD {Print Info Record: The parameters needed for page
						composition.}
				  iDev: Integer; {Font mgr/QuickDraw device code}
				  iVRes: Integer; {Resolution of device, in device coordinates}
				  iHRes: Integer; { ..note: V before H => compatable with Point.}
				  rPage: Rect; {The page (printable) rectangle in device
								coordinates.}
				END;
	  TPPrInfo = ^TPrInfo;

	  {These are types of paper feeders.}
	  TFeed = (feedCut, feedFanfold, feedMechCut, feedOther);

	  TPrStl = RECORD {Printer Style: The printer configuration and usage
					   information.}
				 wDev: Integer; {The device (driver) number. Hi byte=RefNum, Lo
								 byte=variant.}
		   {f0 = fHiRes, f1 = fPortrait, f2 = fSqPix, f3 = f2xZoom, f4 = fScroll.}
				 iPageV: Integer; {paper size in units of 1/iPrPgFract}
				 iPageH: Integer; { ..note: V before H => compatable with Point.}
				 bPort: SignedByte; {The IO port number. Refnum?}
				 feed: TFeed; {paper feeder type.}
			   END;
	  TPPrStl = ^TPrStl;

	  {Banding data structures.  Not of general interest to Apps.}
	  TScan = {Band Scan direction Top-Bottom, Left-Right, etc.}
	  (scanTB, scanBT, scanLR, scanRL);

	  TPrXInfo = RECORD {The print time eXtra information.}
				   iRowBytes: Integer; {The Band's rowBytes.}
				   iBandV: Integer; {Size of band, in device coordinates}
				   iBandH: Integer; { ..note: V before H => compatable with
									 Point.}
				   iDevBytes: Integer; {Size for allocation. May be more than
										rBounds size!}
				   iBands: Integer; {Number of bands per page.}

				   bPatScale: SignedByte; {Pattern scaling}
				   bULThick: SignedByte; {3 Underscoring parameters}
				   bULOffset: SignedByte;
				   bULShadow: SignedByte;

				   scan: TScan; {Band scan direction}
				   bXInfoX: SignedByte; {An eXtra byte.}
				 END;
	  TPPrXInfo = ^TPrXInfo;

	  TPrJob = RECORD {Print Job: Print "form" for a single print request.}
				 iFstPage: Integer; {Page Range.}
				 iLstPage: Integer;
				 iCopies: Integer; {No. copies.}
				 bJDocLoop: SignedByte; {The Doc style: Draft, Spool, .., and ..}
				 fFromUsr: Boolean; {Printing from an User's App (not PrApp) flag}
				 pIdleProc: ProcPtr; {The Proc called while waiting on IO etc.}
				 pFileName: StringPtr; {Spool File Name: NIL for default.}
				 iFileVol: Integer; {Spool File vol, set to 0 initially}
				 bFileVers: SignedByte; {Spool File version, set to 0 initially}
				 bJobX: SignedByte; {An eXtra byte.}
			   END;
	  TPPrJob = ^TPrJob;

	  TPrint = RECORD {The universal 120 byte printing record}
				 iPrVersion: Integer; {2} {Printing software version}
				 PrInfo: TPrInfo; {14} {the PrInfo data associated with the
										current style.}
				 rPaper: Rect; {8} {The paper rectangle [offset from rPage].}
				 PrStl: TPrStl; {8} {This print request's style.}
				 PrInfoPT: TPrInfo; {14} {Print Time Imaging metrics}
				 PrXInfo: TPrXInfo; {16} {Print-time (expanded) Print info
										  record.}
				 PrJob: TPrJob; {20} {The Print Job request}
					  {82} {Total of the above; 120-82 = 38 bytes needed to fill
							120}
				 PrintX: ARRAY [1..19] OF Integer; {Spare to fill to 120 bytes!}
			   END;
	  TPPrint = ^TPrint;
	  THPrint = ^TPPrint;

{Printing Graf Port.  All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.}
	  TPrPort = RECORD {This is the "PrPeek" record.}
				  GPort: GrafPort; {The Printer's graf port.}
				  GProcs: QDProcs; {..and its procs}

				  lGParam1: LongInt; {16 bytes for private parameter storage.}
				  lGParam2: LongInt;
				  lGParam3: LongInt;
				  lGParam4: LongInt;

				  fOurPtr: Boolean; {Whether the PrPort allocation was done by
									 us.}
				  fOurBits: Boolean; {Whether the BitMap allocation was done by
									  us.}
				END;
	  TPPrPort = ^TPrPort;

	  TPrStatus = RECORD {Print Status: Print information during printing.}
					iTotPages: Integer; {Total pages in Print File.}
					iCurPage: Integer; {Current page number}
					iTotCopies: Integer; {Total copies requested}
					iCurCopy: Integer; {Current copy number}
					iTotBands: Integer; {Total bands per page.}
					iCurBand: Integer; {Current band number}
					fPgDirty: Boolean; {True if current page has been written to.}
					fImaging: Boolean; {Set while in band's DrawPic call.}
					hPrint: THPrint; {Handle to the active Printer record}
					pPrPort: TPPrPort; {Ptr to the active PrPort}
					hPic: PicHandle; {Handle to the active Picture}
				  END;
	  TPPrStatus = ^TPrStatus;

  {PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!)}
	  TPfPgDir = RECORD
				   iPages: Integer;
				   lPgPos: ARRAY [0..iPfMaxPgs] OF LongInt;
				 END;
	  TPPfPgDir = ^TPfPgDir;
	  THPfPgDir = ^TPPfPgDir;

	  TPfHeader = RECORD {Print File header.}
					Print: TPrint;
					PfPgDir: TPfPgDir;
				  END;
	  TPPfHeader = ^TPfHeader;
	  THPfHeader = ^TPPfHeader; {Note: Type compatable with an hPrint.}

{ This is the Printing Dialog Record. Only used by folks appending their own dialogs. }
	  TPrDlg = RECORD {Print Dialog: The Dialog Stream object.}
				 Dlg: DialogRecord; {The Dialog window}
				 pFltrProc: ProcPtr; {The Filter Proc.}
				 pItemProc: ProcPtr; {The Item evaluating proc.}
				 hPrintUsr: THPrint; {The user's print record.}
				 fDoIt: Boolean;
				 fDone: Boolean;
				 lUser1: LongInt; {Four longs for user's to hang global data.}
				 lUser2: LongInt;
				 lUser3: LongInt;
				 lUser4: LongInt;
				  {  ...Plus more stuff needed by the particular printing dialog.}
			   END;
	  TPPrDlg = ^TPrDlg; {== a dialog ptr}

	  { ---------------------------------------------------------------------- }

	  {  --Init--  }

	PROCEDURE PrOpen;
   { Open the .Print driver, get the Current Printer's Rsrc file
	 name from SysRes, open the resource file, and open the .Print driver
	 living in SysRes.
	 PrOpen MUST be called during init time. }

	PROCEDURE PrClose;
	{Closes JUST the print rsrc file.  Leaves the .Print driver in SysRes open.}

	{  --Print Dialogs & Default--	}

	PROCEDURE PrintDefault(hPrint: THPrint);
   { Defaults a handle to a Default Print record.
	 Note: You allocate (or fetch from file's resources..) the handle,
		   I fill it.  Also, I may invoke this at odd times whenever
		   I think you have an invalid Print record! }

	FUNCTION PrValidate(hPrint: THPrint): Boolean;
   { Checks the hPrint.  Fixes it if there has been a change in SW
	 version or in the current printer. Returns fChanged.
	 Note: Also updates the various parameters within the Print
		   record to match the current values of the PrStl & PrJob.
		   It does NOT set the fChanged result if these
		   parameters changed as a result of this update. }

	FUNCTION PrStlDialog(hPrint: THPrint): Boolean;

	FUNCTION PrJobDialog(hPrint: THPrint): Boolean;
   { The Dialog returns the fDoIt flag:
		 IF PrJobDialog(..) THEN BEGIN
			PrintMyDoc (..);
			SaveMyStl (..)
		 END
			 OR
		 IF PrStlDialog(..) THEN SaveMyStl (..)
	  NOTE: These may change the hPrint^^ if the version number
			is old or the printer is not the current one.  }

	PROCEDURE PrJobMerge(hPrintSrc, hPrintDst: THPrint);
   { Merges hPrintSrc's PrJob into hPrintDst [Source/Destination].
	 Allows one job dialog being applied to several docs [Finder printing] }

	{  --The Document printing procs: These spool a print file.--  }

	FUNCTION PrOpenDoc(hPrint: THPrint; pPrPort: TPPrPort; pIOBuf: Ptr): TPPrPort;
   { Set up a graf port for Pic streaming and make it the current port.
	 Init the print file page directory.
	 Create and open the print file.
	 hPrint: The print info.
	 pPrPort: the storage to use for the TPrPort.  If NIL we allocate.
	 pIOBuf: an IO buf; if NIL, file sys uses volume buf.
	 returns TPPrPort: The TPPrPort (graf port) used to spool thru. }

	PROCEDURE PrCloseDoc(pPrPort: TPPrPort);
   { Write the print file page directory.
	 Close the print file. }

	PROCEDURE PrOpenPage(pPrPort: TPPrPort; pPageFrame: TPRect);
   { If current page is in the range of printed pages:
	   Open a picture for the page
	   Otherwise set a null port for absorbing an image.
	 pPageFrame := PrInfo.rPage, unless you're scaling.
	 Set pPageFrame to NIL unless you want to perform PicScaling on the printer.
	 [The printing procs will call OpenPicture (pPageFrame^) and DrawPicture (hPic, rPage);]
	 Note: Use of QuickDraw may now cause File IO errors due to our Pic spooling! }

	PROCEDURE PrClosePage(pPrPort: TPPrPort);
   { Close & kill the page picture.
	 Update the file page directory.
	 If we allocated the TPrPort then de-allocate it. }

	{  --The "Printing Application" proc: Read and band the spooled PicFile.--	}

	PROCEDURE PrPicFile(hPrint: THPrint; pPrPort: TPPrPort; pIOBuf: Ptr;
						pDevBuf: Ptr; VAR PrStatus: TPrStatus);
   { Read and print the spooled print file.
	 The idle proc is run during Imaging and Printing. }
	{  --Get/Set the current Print Error--	}

	FUNCTION PrError: Integer;

	PROCEDURE PrSetError(iErr: Integer);

	{  --The .Print driver calls.--  }

	PROCEDURE PrDrvrOpen;

	PROCEDURE PrDrvrClose;
   { Open/Close the .Print driver in SysRes.  Make it purgable or not.
	 ONLY used by folks doing low level stuff, not full document printing. }

	PROCEDURE PrCtlCall(iWhichCtl: Integer; lParam1, lParam2, lParam3: LongInt);
   { A generalized Control proc for the Printer driver.
	 The main use is for bitmap printing:
		 PrCtlCall (iPrBitsCtl, pBitMap, pPortRect, lControl);
		 ==
		 PROCEDURE PrBits  (  pBitMap:	Ptr;	   --QuickDraw bitmap
							  pPortRect: TPRect;	  --a portrect. use bounds for whole bitmap
							  lControl:  LongInt );   --0=>Screen resolution/Portrait
	 This dumps a bitmap/portrect to the printer.
	 lControl is a device dep param; use 0 for screen res/portrait/etc.
	 Each different printer will use lControl parameter differently.
	 Thus PrCtlCall (iPrBitsCtl, @MyPort^.ScreenBits, @MyPort^.PortRect.Bounds,0)
	 performs a screen dump of just my port's data.

	 Two special control calls are included in the driver for Screen printing from the
	 key board:
			PrCtlCall (iPrEvtCtl, lPrEvtAll, 0, 0);  Prints the screen
			PrCtlCall (iPrEvtCtl, lPrEvtTop, 0, 0);  Prints the top folder
	 These are handled by the system for key board access but can be called by anyone
	 at any time.  They can be very cheap printing for ornaments, for example!

	 Another useful call is used for sending raw data to the printer:
		 PrCtlCall (iPrIOCtl, pBuf, lBufCount, pIdleProc); }

	{ These .Print driver calls are only available in the PrScreen module. }

	PROCEDURE PrPurge;

	PROCEDURE PrNoPurge;

	FUNCTION PrDrvrDCE: Handle;

	FUNCTION PrDrvrVers: Integer;

	{ --Semi private stuff-- }

	FUNCTION PrStlInit(hPrint: THPrint): TPPrDlg;

	FUNCTION PrJobInit(hPrint: THPrint): TPPrDlg;

	FUNCTION PrDlgMain(hPrint: THPrint; pDlgInit: ProcPtr): Boolean;

	PROCEDURE PrCfgDialog;

	PROCEDURE PrHack(lParam1, lParam2, lParam3: LongInt);

	{ ---------------------------------------------------------------------- }
	{		 This is the Private interface to MacPrint	 }
	{ ---------------------------------------------------------------------- }

	CONST

	  iIOBufBytes = 522; {Size of file sys buf.}
	  iIOBlkBytes = 512; {Size of disk block}

	  {The TPrint Resource type & ID's}
	  lPStrType = $53545220; {"STR ": Res type for the Pr Rsrc file name}
	  iPStrRFil = $E000; {-8192} {Str $E000 [in SysRes] is the current printer's
								  rsrc file}
	  iPStrPFil = $E001; {-8191} {Str $E001 is the default print file name}

	  lPrintType = $50524543; {"PREC": Res type for the hPrint records}
	  iPrintDef = 0; {Default hPrint }
	  iPrintLst = 1; {Last used hPrint}
	  iPrintDrvr = 2; {.Print's parameter record; not a Print rec}
	  iPrintPSiz = 3; {Paper size button definitions} {DC 7/30/84}
	  iMyPrDrvr = $E000; {-8192} {My copy of the above.}

	  {PicFile constants}
	  lPfType = $5046494C; {"PFIL"}
	  lPfSig = $50535953; {"PSYS"}
	  iPfIcon = 140;

	  lPrType = $4150504C; {"APPL"}
	  lPrSig = $50535953; {"PSYS"}
	  iPrIcon = 138;

	  {Driver constants}
	  sPrDrvr = '.Print';
	  iPrDrvrID = 2; {Driver's ResID}
	  iPrDrvrRef = $FFFD; {Driver's RefNum = NOT ResID}
	  iPrDrvrDev = $FD00; {Driver's QD Dev num = RefNum in Hi Byte, variant in lo}

	  {General Dlg/Alert[=Ax] Constants:}
	  iOK = 1;
	  iCancel = 2;
	  iPrStlDlg = $E000; {-8192}
	  iPrJobDlg = $E001; {-8191}
	  iPrCfgDlg = $E002; {-8190}
	  iPgFeedAx = $E00A; {-8182}
	  iPicSizAx = $E00B; {-8181}
	  iIOAbrtAx = $E00C; {-8180}

	  {Convenient non-characters; note Etx is Enter key}
	  bETX = 3;
	  bBS = 8;
	  bHTab = 9;
	  bLF = 10;
	  bCR = 13;
	  bSO = 14;
	  bSI = 15;
	  bESC = 27;

(*
   iPicLim	   = 129;
   iPicMax	   = 130;
   iPrDeapShit = 29;
*)
	  { ---------------------------------------------------------------------- }

	TYPE

	  TN = 0..15; {A Nibble}
	  TWord = PACKED RECORD {General purpose "alias" record for a word & long.}
				CASE Integer OF
				  0:
					(c1, c0: Char);
				  1:
					(b1, b0: SignedByte);
				  2:
					(usb1, usb0: Byte);
				  3:
					(n3, n2, n1, n0: TN);
				  4:
					(f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2,
					 f1, f0: Boolean);
				  5:
					(i0: Integer);
			  END;
	  TLong = RECORD
				CASE Integer OF
				  0:
					(w1, w0: TWord);
				  1:
					(l0: LongInt);
				  2:
					(p0: Ptr);
				  3:
					(h0: Handle);
				  4:
					(pt: Point);
			  END;

	  { ---------------------------------------------------------------------- }

	  {File Utilities: IO68K}
	  {FUNCTION PrStr80Ptr	(sName:TStr80): TPStr80;}

	FUNCTION PrCreateFile(pName: StringPtr; iVol: Integer;
						  bVersion: SignedByte): Integer;

	FUNCTION PrDeleteFile(pName: StringPtr; iVol: Integer;
						  bVersion: SignedByte): Integer;

	FUNCTION PrOpenFile(pName: StringPtr; iVol: Integer; bVersion: SignedByte;
						fTrunc: Boolean; pBuf: Ptr;
						VAR iRefNum: Integer): Integer;

	FUNCTION PrWriteBlk(iRefNum, iMode: Integer; lPos: LongInt; p: Ptr;
						lBytes: LongInt): Integer;

	FUNCTION PrReadBlk(iRefNum, iMode: Integer; lPos: LongInt; p: Ptr;
					   lBytes: LongInt): Integer;

	FUNCTION PrCloseFile(iRefNum: Integer): Integer;

	{Scc utilitys: Scc68k}

	FUNCTION PrSCCInit(iBaudEtc: Integer; lHndShk: LongInt): Integer;

	FUNCTION PrBlockOut(pIdleProc: ProcPtr; pData: Ptr; lBytes: LongInt): Integer;
(*FUNCTION	PrIOCheck  (lTimeOut:  LongInt; pData: Ptr; lBytes: LongInt): Integer;*)

	PROCEDURE XPrIdle(pIdleProc: ProcPtr);

	PROCEDURE PrAbortCheck;

	{Other Utilities: PrMacMisc}

	FUNCTION lPrMul(i1, i0: Integer): LongInt;

	FUNCTION lPrDiv(lTop: LongInt; iBot: Integer): LongInt;

	{Performance tool}

	PROCEDURE SpyInit;

	PROCEDURE SpyClose;

	PROCEDURE Spy(iBucket: Integer);

END.

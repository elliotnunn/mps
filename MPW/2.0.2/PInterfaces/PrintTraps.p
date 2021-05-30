{
 File: PrintTraps.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved
}

UNIT PrintTraps;

  INTERFACE

{ ---------------------------------------------------------------------- }

		USES	{$U MemTypes.p } MemTypes,
				{$U QuickDraw.p} QuickDraw,
				{$U OSIntf.p   } OSIntf,
				{$U ToolIntf.p } ToolIntf;


{ ---------------------------------------------------------------------- }
{			 This is the Public interface to PrintTraps					 }
{ ---------------------------------------------------------------------- }

CONST
   iPrPgFract  = 120;		{Page scale factor. ptPgSize (below) is in units of 1/iPrPgFract }

   iPrPgFst = 1;				 {Page range constants}
   iPrPgMax = 9999;

   iPrRelease = 2;				 {Current version number of the code.}
   iPfMaxPgs  = 128;			 {Max number of pages in a print file.}

{Driver constants}
   iPrBitsCtl	= 4;			 {The Bitmap Print Proc's ctl number}
   lScreenBits	= $00000000;	 {The Bitmap Print Proc's Screen Bitmap param}
   lPaintBits	= $00000001;	 {The Bitmap Print Proc's Paint [sq pix] param}
   lHiScreenBits = $00000002;	 {The Bitmap Print Proc's Screen Bitmap param}
   lHiPaintBits = $00000003;	 {The Bitmap Print Proc's Paint [sq pix] param}
   iPrIOCtl 	= 5;			 {The Raw Byte IO Proc's ctl number}
   iPrEvtCtl	= 6;			 {The PrEvent Proc's ctl number}
   lPrEvtAll	= $0002FFFD;	 {The PrEvent Proc's CParam for the entire screen}
   lPrEvtTop	= $0001FFFD;	 {The PrEvent Proc's CParam for the top folder}
   iPrDevCtl	= 7;			 {The PrDevCtl Proc's ctl number}
   lPrReset 	= $00010000;	 {The PrDevCtl Proc's CParam for reset}
   lPrDocOpen	= $00010000;	 {alias for reset}
   lPrPageEnd	= $00020000;	 {The PrDevCtl Proc's CParam for end page}
   lPrPageClose = $00020000;	 {alias for end page}
   lPrLineFeed	= $00030000;	 {The PrDevCtl Proc's CParam for paper advance}
   lPrLFStd 	= $0003FFFF;	 {The PrDevCtl Proc's CParam for std paper advance}
   lPrPageOpen	= $00040000;	 {The PrDevCtl Proc's CParam for PageOpen}
   lPrDocClose	= $00050000;	 {The PrDevCtl Proc's CParam for DocClose}
   iFMgrCtl 	= 8;			 {The FMgr's Tail-hook Proc's ctl number}
								 { [The Pre-Hook is the status call] }
   iMscCtl		= 9;			 {Msc Text state / Drvr State ctl number}
(* iMscCtl		= 10;    *)	 {Last Print Shop ctl call}
   iPvtCtl		= 10; 		 {Private ctls start here}

{Error Constants:}
   iMemFullErr = -108;
   iPrAbort    = 128;
   iPrSavPFil  = -1;
   iIOAbort    = -27;

{The PrVars lo mem area:}
   pPrGlobals  = $00000944;
   bDraftLoop  = 0;
   bSpoolLoop  = 1;
   bUser1Loop  = 2;
   bUser2Loop  = 3;

   fNewRunBit  = 2;  {Bit 2 (3rd bit) in bDocLoop is new JobRun indicator.}
   fHiResOK    = 3;  {Bit 3 (4th bit) in bDocLoop is hi res indicator for paint.}
   fWeOpenedRF = 4;  {Bit 4 (5th bit) in bDocLoop is set if driver opened the pr res file.}


{PrGeneral constants}

		getRslDataOp	= 4;
		setRslOp		= 5;
		draftBitsOp 	= 6;
		noDraftBitsOp	= 7;
		getRotnOp		= 8;
		
		NoSuchRsl		= 1;
		
		RgType1 		= 1;

{ ---------------------------------------------------------------------- }

TYPE

   TPRect	=  ^Rect;			 {A Rect Ptr}
   TPBitMap =  ^BitMap; 		 {A BitMap Ptr}

					 {NOTE: Changes will also affect: PrEqu, TCiVars & TPfVars}
   TPrVars = RECORD  {4 longs for printing, see SysEqu for location.}
	iPrErr:	Integer;			{Current print error.  Set to iPrAbort to abort printing.}
	bDocLoop:   SignedByte;		{The Doc style: Draft, Spool, .., and ..}
								{Currently use low 2 bits; the upper 6 are for flags.}
	bUser1:	SignedByte;			{Spares used by the print code}
	lUser1:	LongInt;
	lUser2:	LongInt;
	lUser3:	LongInt;
   END;
   TPPrVars = ^TPrVars;

   TPrInfo = RECORD 	{Print Info Record: The parameters needed for page composition.}
	iDev: 	Integer;		{Font mgr/QuickDraw device code}
	iVRes:	Integer;		{Resolution of device, in device coordinates}
	iHRes:	Integer;		{   ..note: V before H => compatable with Point.}
	rPage:	Rect; 			{The page (printable) rectangle in device coordinates.}
   END;
   TPPrInfo = ^TPrInfo;

{These are types of paper feeders.}
   TFeed = ( feedCut, feedFanfold, feedMechCut, feedOther );

   TPrStl = RECORD		{Printer Style: The printer configuration and usage information.}
	wDev: 	Integer;	{The device (driver) number.  Hi byte=RefNum, Lo byte=variant.}
	iPageV:	Integer;	{paper size in units of 1/iPrPgFract}
	iPageH:	Integer;	{	 ..note: V before H => compatable with Point.}
	bPort:	SignedByte;	{The IO port number. Refnum?}
	feed: 	TFeed;		{paper feeder type.}
   END;
   TPPrStl = ^TPrStl;

{Banding data structures.  Not of general interest to Apps.}
   TScan =				{Band Scan direction Top-Bottom, Left-Right, etc.}
	( scanTB,  scanBT, scanLR, scanRL );

   TPrXInfo = RECORD		{The print time eXtra information.}
	iRowBytes:  Integer;	{The Band's rowBytes; 0 => the other band info avail as parameters.}
	iBandV:	Integer;		{Size of band, in device coordinates}
	iBandH:	Integer;		{	 ..note: V before H => compatible with Point.}
	iDevBytes:  Integer;	{Size for allocation.	May be more than rBounds size!}
	iBands:	Integer;		{Number of bands per page.}

	bPatScale:  SignedByte;	{Pattern scaling}
	bULThick:   SignedByte;	{3 Underscoring parameters}
	bULOffset:  SignedByte;
	bULShadow:  SignedByte;

	scan: 	TScan;		 	{Band scan direction}
	bXInfoX:	SignedByte;	{An eXtra byte.}
   END;
   TPPrXInfo = ^TPrXInfo;

   TPrJob = RECORD		{Print Job: Print "form" for a single print request.}
	iFstPage:   Integer;	{Page Range.}
	iLstPage:   Integer;
	iCopies:	Integer;	{No. copies.}
	bJDocLoop:  SignedByte;	{The Doc style: Draft, Spool, .., and ..}
	fFromUsr:   Boolean;	{Printing from an User's App (not PrApp) flag}
	pIdleProc:  ProcPtr;	{The Proc called while waiting on IO etc.}
	pFileName:  StringPtr;	{Spool File Name: NIL for default.}
	iFileVol:   Integer;	{Spool File vol, set to 0 initially}
	bFileVers:  SignedByte;	{Spool File version, set to 0 initially}
	bJobX:	SignedByte;		{An eXtra byte.}
   END;
   TPPrJob = ^TPrJob;

   TPrFlag1 = PACKED RECORD 	 {The first printer flag word.}
	f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, fLstPgFst, fUserScale: Boolean;
   END;

   TPrint = RECORD		{The universal 120 byte printing record}
	iPrVersion: Integer;	{Printing software version}
	PrInfo:	TPrInfo;		{the PrInfo data associated with the current style.}
	rPaper:	Rect; 			{The paper rectangle [offset from rPage].}
	PrStl:	TPrStl;			{This print request's style.}
	PrInfoPT:   TPrInfo;	{Print Time Imaging metrics}
	PrXInfo:	TPrXInfo; 	{Print-time (expanded) Print info record.}
	PrJob:	TPrJob;			{The Print Job request}
	Case Integer Of
		 0:(PrintX: 	Array[1..19] of integer);  {Spare to fill to 120 bytes!}
		 1:(PrFlag1:	TPrFlag1;	 {A word of flags}
			iZoomMin:	Integer;
			iZoomMax:	Integer;
			hDocName:	StringHandle;  {The current doc's name; defaulted [nil] to FrontWindow}
		 );
   END;
   TPPrint = ^TPrint;
   THPrint = ^TPPrint;

{Printing Graf Port.  All printer imaging, whether spooling, banding, etc, happens "thru" a GrafPort.}
   TPrPort =  RECORD	{This is the "PrPeek" record.}
	GPort:	GrafPort; 		{The Printer's graf port.}
	GProcs:	QDProcs;		{..and its procs}

	lGParam1:   LongInt;	{16 bytes for private parameter storage.}
	lGParam2:   LongInt;
	lGParam3:   LongInt;
	lGParam4:   LongInt;

	fOurPtr:	Boolean;	{Whether the PrPort allocation was done by us.}
	fOurBits:   Boolean;	{Whether the BitMap allocation was done by us.}
   END;
   TPPrPort = ^TPrPort;

   TPrStatus = RECORD	 {Print Status: Print information during printing.}
	iTotPages:  Integer;		{Total pages in Print File.}
	iCurPage:   Integer;		{Current page number}
	iTotCopies: Integer;		{Total copies requested}
	iCurCopy:   Integer;		{Current copy number}
	iTotBands:  Integer;		{Total bands per page.}
	iCurBand:   Integer;		{Current band number}
	fPgDirty:   Boolean;		{True if current page has been written to.}
	fImaging:   Boolean;		{Set while in band's DrawPic call.}
	hPrint:	THPrint;			{Handle to the active Printer record}
	pPrPort:	TPPrPort; 		{Ptr to the active PrPort}
	hPic: 	PicHandle;		 	{Handle to the active Picture}
   END;
   TPPrStatus = ^TPrStatus;

{PicFile = a TPfHeader followed by n QuickDraw Pics (whose PicSize is invalid!)}
   TPfPgDir =  RECORD
	iPages:	Integer;
	lPgPos:	ARRAY [0..iPfMaxPgs] OF LongInt;
   END;
   TPPfPgDir = ^TPfPgDir;
   THPfPgDir = ^TPPfPgDir;

   TPfHeader =	RECORD	 {Print File header.}
	Print:	TPrint;
	PfPgDir:	TPfPgDir;
   END;
   TPPfHeader = ^TPfHeader;
   THPfHeader = ^TPPfHeader;  {Note: Type compatable with an hPrint.}

{ This is the Printing Dialog Record. Only used by folks appending their own dialogs. }
   TPrDlg = RECORD		{Print Dialog: The Dialog Stream object.}
	Dlg:		DialogRecord;	{The Dialog window}
	pFltrProc:  ProcPtr;		{The Filter Proc.}
	pItemProc:  ProcPtr;		{The Item evaluating proc.}
	hPrintUsr:  THPrint;		{The user's print record.}
	fDoIt:	Boolean;
	fDone:	Boolean;
	lUser1:	LongInt;		 {Four longs for dialogs to hang global data.}
	lUser2:	LongInt;
	lUser3:	LongInt;
	lUser4:	LongInt;
   {  ...Plus more stuff needed by the particular printing dialog.}
	iNumFst:	Integer;		{numeric edit items for std filter.}
	iNumLst:	Integer;		{numeric edit items for std filter.}
   END;
   TPPrDlg = ^TPrDlg;	 {== a dialog ptr}

   TN	 =	0..15;			{A Nibble}
   TWord = PACKED RECORD	{General purpose "alias" record for a word & long.}
	CASE Integer OF
		 0: ( c1, c0: Char );
		 1: ( b1, b0: SignedByte );
		 2: ( usb1, usb0: Byte );
		 3: ( n3, n2, n1, n0: TN );
		 4: ( f15, f14, f13, f12, f11, f10, f9, f8, f7, f6, f5, f4, f3, f2, f1, f0: Boolean );
		 5: ( i0: Integer );
   END;
   TPWord = ^TWord;
   THWord = ^TPWord;

   TLong = RECORD
	CASE Integer OF
		 0: ( b3, b2, b1, b0: SignedByte );
		 1: ( i1, i0: Integer );
		 2: ( w1, w0: TWord );
		 3: ( l0: LongInt );
		 4: ( p0: Ptr );
		 5: ( h0: Handle );
		 6: ( pt: Point );
   END;
   TPLong = ^TLong;
   THLong = ^TPLong;

{Convenient type declarations for use by applications that call PrGeneral.}

		TGnlData = RECORD		{1st 8 bytes are common for all PrGeneral calls);
				iOpCode:		Integer;		{input}
				iError: 		Integer;		{output}
				lReserved:		LongInt;		{reserved for future use}
				{more fields here, depending
				 on particular call}
		END;
		
		TRslRg = RECORD {used in TGetRslBlk}
				iMin:	Integer;	{0 if printer only supports discrete resolutions}
				iMax:	Integer;	{0 if printer only supports discrete resolutions}
		END;
												
		TRslRec = RECORD		{used in TGetRslBlk}
				iXRsl:	Integer;	{a discrete, physical X resolution}
				iYRsl:	Integer;	{a discrete, physical Y resolution}
		END;
		
		TGetRslBlk = RECORD 	{data block for GetRslData call}
				iOpCode:		Integer;	{input; = getRslDataOp}
				iError: 		Integer;	{output}
				lReserved:		LongInt;	{reserved for future use}
				iRgType:		Integer;	{output; this declaration is for RgType1}
				XRslRg: 		TRslRg; 	{output; range of X resolutions}
				YRslRg: 		TRslRg; 	{output; range of Y resolutions}
				iRslRecCnt: 	Integer;	{output; how many RslRec's follow}
				rgRslRec:		ARRAY[1..27]
								OF TRslRec; {output; number used depends on printer type}
		END;
		
		TSetRslBlk =	RECORD	{data block for SetRsl call}
				iOpCode:		Integer;	{input; = setRslOp}
				iError: 		Integer;	{output}
				lReserved:		LongInt;	{reserved for future use}
				hPrint: 		THPrint;	{input; handle to a valid print record}
				iXRsl:			Integer;	{input; desired X resolution}
				iYRsl:			Integer;	{input; desired Y resolution}
		END;

		TDftBitsBlk =	RECORD	{data block for DraftBits and NoDraftBits calls}
				iOpCode:		Integer;	{input; = draftBitsOp or noDraftBitsOp}
				iError: 		Integer;	{output}
				lReserved:		LongInt;	{reserved for future use}
				hPrint: 		THPrint;	{input; handle to a valid print record}
		END;

		TGetRotnBlk =	RECORD	{data block for GetRotn call}
				iOpCode:		Integer;	{input; = getRotnOp}
				iError: 		Integer;	{output}
				lReserved:		LongInt;	{reserved for future use}
				hPrint: 		THPrint;	{input; handle to a valid print record}
				fLandscape: 	Boolean;	{output; Boolean flag}
				bXtra:			SignedByte; {not used}
		END;


{ ---------------------------------------------------------------------- }

{  --Init--  }
PROCEDURE PrOpen;					 INLINE $2F3C,$C800,$0000,$A8FD;
   { Open the .Print driver, get the Current Printer's Rsrc file
	 name from SysRes, open the resource file, and open the .Print driver
	 living in SysRes.
	 PrOpen MUST be called during init time. }
PROCEDURE PrClose;					 INLINE $2F3C,$D000,$0000,$A8FD;
   {Closes JUST the print rsrc file.  Leaves the .Print driver in SysRes open.}

{  --Print Dialogs & Default--	}
PROCEDURE PrintDefault	( hPrint: THPrint );	
		INLINE $2F3C,$2004,$0480,$A8FD;
   { Defaults a handle to a Default Print record.
	 Note: You allocate (or fetch from file's resources..) the handle,
		 I fill it.  Also, I may invoke this at odd times whenever
		 I think you have an invalid Print record! }

FUNCTION  PrValidate ( hPrint: THPrint ): Boolean;
		INLINE $2F3C,$5204,$0498,$A8FD;
   { Checks the hPrint.  Fixes it if there has been a change in SW
	 version or in the current printer. Returns fChanged.
	 Note: Also updates the various parameters within the Print
		 record to match the current values of the PrStl & PrJob.
		 It does NOT set the fChanged result if these
		 parameters changed as a result of this update. }

FUNCTION  PrStlDialog  ( hPrint: THPrint ): Boolean;
		INLINE $2F3C,$2A04,$0484,$A8FD;
FUNCTION  PrJobDialog  ( hPrint: THPrint ): Boolean;
		INLINE $2F3C,$3204,$0488,$A8FD;
   { The Dialog returns the fDoIt flag:
		 IF PrJobDialog(..) THEN BEGIN
			PrintMyDoc (..);
			SaveMyStl (..)
		 END
			 OR
		 IF PrStlDialog(..) THEN SaveMyStl (..)
	NOTE: These may change the hPrint^^ if the version number
			is old or the printer is not the current one.  }
PROCEDURE PrJobMerge (hPrintSrc, hPrintDst: THPrint);
		INLINE $2F3C,$5804,$089C,$A8FD;
   { Merges hPrintSrc's PrJob into hPrintDst [Source/Destination].
	 Allows one job dialog being applied to several docs [Finder printing] }

{  --The Document printing procs: These spool a print file.--  }
FUNCTION PrOpenDoc ( hPrint:	 THPrint;
					 pPrPort:	 TPPrPort;
					 pIOBuf:	 Ptr ): TPPrPort;
		INLINE $2F3C,$0400,$0C00,$A8FD;
   { Set up a graf port for Pic streaming and make it the current port.
	 Init the print file page directory.
	 Create and open the print file.
	 hPrint: The print info.
	 pPrPort: the storage to use for the TPrPort.  If NIL we allocate.
	 pIOBuf: an IO buf; if NIL, file sys uses volume buf.
	 returns TPPrPort: The TPPrPort (graf port) used to spool thru. }

PROCEDURE PrCloseDoc ( pPrPort: TPPrPort );
		INLINE $2F3C,$0800,$0484,$A8FD;
   { Write the print file page directory.
	 Close the print file. }

PROCEDURE PrOpenPage ( pPrPort: TPPrPort; pPageFrame: TPRect );
		INLINE $2F3C,$1000,$0808,$A8FD;
   { If current page is in the range of printed pages:
	 Open a picture for the page
	 Otherwise set a null port for absorbing an image.
	 pPageFrame := PrInfo.rPage, unless you're scaling.
	 Set pPageFrame to NIL unless you want to perform PicScaling on the printer.
	 [The printing procs will call OpenPicture (pPageFrame^) and DrawPicture (hPic, rPage);]
	 Note: Use of QuickDraw may now cause File IO errors due to our Pic spooling! }

PROCEDURE PrClosePage( pPrPort: TPPrPort );
		INLINE $2F3C,$1800,$040C,$A8FD;
   { Close & kill the page picture.
	 Update the file page directory.
	 If we allocated the TPrPort then de-allocate it. }

{  --The "Printing Application" proc: Read and band the spooled PicFile.--	}
PROCEDURE PrPicFile( hPrint:		THPrint;
					 pPrPort:		TPPrPort;
					 pIOBuf:		Ptr;
					 pDevBuf:		Ptr;
					 VAR PrStatus:	TPrStatus );
		INLINE $2F3C,$6005,$1480,$A8FD;
   { Read and print the spooled print file.
	 The idle proc is run during Imaging and Printing. }
{  --Get/Set the current Print Error--	}
FUNCTION  PrError: Integer;
		INLINE $2F3C,$BA00,$0000,$A8FD;
PROCEDURE PrSetError ( iErr: Integer );
		INLINE $2F3C,$C000,$0200,$A8FD;
PROCEDURE PrGeneral (pData: Ptr);
		INLINE $2F3C,$7007,$0480,$A8FD;
		
{  --The .Print driver calls.--  }
PROCEDURE PrDrvrOpen;
		INLINE $2F3C,$8000,$0000,$A8FD;
PROCEDURE PrDrvrClose;
		INLINE $2F3C,$8800,$0000,$A8FD;
   { Open/Close the .Print driver in SysRes.  Make it purgable or not.
	 ONLY used by folks doing low level stuff, not full document printing. }

PROCEDURE PrCtlCall (iWhichCtl: Integer; lParam1, lParam2, lParam3: LongInt);
		INLINE $2F3C,$A000,$0E00,$A8FD;
   { A generalized Control proc for the Printer driver.
	 The main use is for bitmap printing:
		 PrCtlCall (iPrBitsCtl, pBitMap, pPortRect, lControl);
		 ==
		 PROCEDURE PrBits  (  pBitMap:	 Ptr;		--QuickDraw bitmap
							pPortRect: TPRect;	--a portrect. use bounds for whole bitmap
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

PROCEDURE PrPurge;						INLINE $2F3C,$A800,$0000,$A8FD;
PROCEDURE PrNoPurge;					INLINE $2F3C,$B000,$0000,$A8FD;
FUNCTION  PrDrvrDCE:  Handle;			INLINE $2F3C,$9400,$0000,$A8FD;
FUNCTION  PrDrvrVers: Integer;			INLINE $2F3C,$9A00,$0000,$A8FD;

{ Exported by XxDlgs }
FUNCTION  PrStlInit ( hPrint: THPrint ): TPPrDlg;
		INLINE $2F3C,$3C04,$040C,$A8FD;
FUNCTION  PrJobInit ( hPrint: THPrint ): TPPrDlg;
		INLINE $2F3C,$4404,$0410,$A8FD;
FUNCTION  PrDlgMain ( hPrint: THPrint; pDlgInit: ProcPtr ): Boolean;
		INLINE $2F3C,$4A04,$0894,$A8FD;


{ ---------------------------------------------------------------------- }


END.

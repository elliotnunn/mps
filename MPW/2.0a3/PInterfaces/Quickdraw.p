{
	File: Quickdraw.p
	
	Version: 2.0a3.1
	
	Copyright Apple Computer, Inc.	1984-1987
	All Rights Reserved
}

{	modifications:
	01/22/87	KLH	added CQDProcs record instead of lengthening existing
						QDProcs.
	01/26/87	KLH	gdPMap previously changed from handle to PixMapHandle,
						but misspelled as gdDPMap.
	15Dec86		DAF 	added gamma table format
	16Feb87		KLH	OpenCPicture changed to agree with OpenPicture.
	19feb87		KLH	SetEntries parameters corrected.
	9MAR87		KLH removed UpdatePixMap until finished
					updated Color2Index & Index2Color.
}

UNIT QuickDraw;

  INTERFACE

	USES {$U MemTypes.p } MemTypes;

	CONST
	  srcCopy = 0; { the 16 transfer modes }
	  srcOr = 1;
	  srcXor = 2;
	  srcBic = 3;
	  notSrcCopy = 4;
	  notSrcOr = 5;
	  notSrcXor = 6;
	  notSrcBic = 7;
	  patCopy = 8;
	  patOr = 9;
	  patXor = 10;
	  patBic = 11;
	  notPatCopy = 12;
	  notPatOr = 13;
	  notPatXor = 14;
	  notPatBic = 15;

	  { QuickDraw color separation constants }

	  normalBit = 0; { normal screen mapping }
	  inverseBit = 1; { inverse screen mapping }
	  redBit = 4; { RGB additive mapping }
	  greenBit = 3;
	  blueBit = 2;
	  cyanBit = 8; { CMYBk subtractive mapping }
	  magentaBit = 7;
	  yellowBit = 6;
	  blackBit = 5;

	  blackColor = 33; { colors expressed in these mappings }
	  whiteColor = 30;
	  redColor = 205;
	  greenColor = 341;
	  blueColor = 409;
	  cyanColor = 273;
	  magentaColor = 137;
	  yellowColor = 69;

	  picLParen = 0; { standard picture comments }
	  picRParen = 1;

{ THE FOLLOWING CONSTANTS WHERE ADDED FOR COLOR QUICKDRAW. }

	invalColReq		=	-1;				{ invalid color table request }

{ VALUES FOR GDType }

	clutType		=	0;				{ 0 if lookup table }
	fixedType		=	1;				{ 1 if fixed table }
	directType		=	2;				{ 2 if direct values }

{ BIT ASSIGNMENTS FOR GDFlags }

	gdDevType		=	0;				{ 0 = monochrome; 1 = color }
	ramInit			=	10;				{ 1 if initialized from 'scrn' resource }
	mainScrn		=	11;				{ 1 if main screen }
	allInit			=	12;				{ 1 if all devices initialized }
	screenDevice	=	13;				{ 1 if screen device [not used] }
	noDriver		=	14;				{ 1 if no driver for this GDevice }
	scrnActive		=	15;				{ 1 if in use }

	hiliteBit		=	7;				{ flag bit in HiliteMode (lowMem flag) }

	defQDColors     =	127;			{ resource ID of clut for default QDColors }


TYPE
	  QDByte = SignedByte;
	  QDPtr = Ptr; { blind pointer }
	  QDHandle = Handle; { blind handle }
	  Pattern = PACKED ARRAY [0..7] OF 0..255;
	  Bits16 = ARRAY [0..15] OF INTEGER;
	  VHSelect = (v, h);
	  GrafVerb = (frame, paint, erase, invert, fill);
	  StyleItem = (bold, italic, underline, outline, shadow, condense, extend);
	  Style = SET OF StyleItem;

	  FontInfo = RECORD
				   ascent: INTEGER;
				   descent: INTEGER;
				   widMax: INTEGER;
				   leading: INTEGER;
				 END;

	  Point = RECORD
				CASE INTEGER OF

				  0:
					(v: INTEGER;
					 h: INTEGER);
				  1:
					(vh: ARRAY [VHSelect] OF INTEGER);

			  END;

	  Rect = RECORD
			   CASE INTEGER OF

				 0:
				   (top: INTEGER;
					left: INTEGER;
					bottom: INTEGER;
					right: INTEGER);
				 1:
				   (topLeft: Point;
					botRight: Point);
			 END;

	  BitMap = RECORD
				 baseAddr: Ptr;
				 rowBytes: INTEGER;
				 bounds: Rect;
			   END;

	  Cursor = RECORD
				 data: Bits16;
				 mask: Bits16;
				 hotSpot: Point;
			   END;

	  PenState = RECORD
				   pnLoc: Point;
				   pnSize: Point;
				   pnMode: INTEGER;
				   pnPat: Pattern;
				 END;

	  PolyHandle = ^PolyPtr;
	  PolyPtr = ^Polygon;
	  Polygon = RECORD
				  polySize: INTEGER;
				  polyBBox: Rect;
				  polyPoints: ARRAY [0..0] OF Point;
				END;

	  RgnHandle = ^RgnPtr;
	  RgnPtr = ^Region;
	  Region = RECORD
				 rgnSize: INTEGER; { rgnSize = 10 for rectangular }
				 rgnBBox: Rect;
						{ plus more data if not rectangular }
			   END;

	  PicHandle = ^PicPtr;
	  PicPtr = ^Picture;
	  Picture = RECORD
				  picSize: INTEGER;
				  picFrame: Rect;
						  { plus byte codes for picture content }
				END;

	  QDProcsPtr = ^QDProcs;
	  QDProcs = RECORD
				  textProc: Ptr;
				  lineProc: Ptr;
				  rectProc: Ptr;
				  rRectProc: Ptr;
				  ovalProc: Ptr;
				  arcProc: Ptr;
				  polyProc: Ptr;
				  rgnProc: Ptr;
				  bitsProc: Ptr;
				  commentProc: Ptr;
				  txMeasProc: Ptr;
				  getPicProc: Ptr;
				  putPicProc: Ptr;
				END;

	  GrafPtr = ^GrafPort;
	  GrafPort = RECORD
				   device: INTEGER;
				   portBits: BitMap;
				   portRect: Rect;
				   visRgn: RgnHandle;
				   clipRgn: RgnHandle;
				   bkPat: Pattern;
				   fillPat: Pattern;
				   pnLoc: Point;
				   pnSize: Point;
				   pnMode: INTEGER;
				   pnPat: Pattern;
				   pnVis: INTEGER;
				   txFont: INTEGER;
				   txFace: Style;
				   txMode: INTEGER;
				   txSize: INTEGER;
				   spExtra: Fixed;
				   fgColor: LongInt;
				   bkColor: LongInt;
				   colrBit: INTEGER;
				   patStretch: INTEGER;
				   picSave: Handle;
				   rgnSave: Handle;
				   polySave: Handle;
				   grafProcs: QDProcsPtr;
				 END;

{ THE FOLLOWING TYPES WHERE ADDED FOR COLOR QUICKDRAW. }

	RGBColor	= RECORD
					red:	INTEGER;		{ magnitude of red component	}
					green:	INTEGER;		{ magnitude of green component	}
					blue:	INTEGER;		{ magnitude of blue component	}
				  END;
					  
	ColorSpec	= RECORD
					value:	INTEGER;		{ index or other value	}
					RGB:	RGBColor;		{ true color			}
				  END;

	CSpecArray	=	ARRAY [0..0] of ColorSpec;
					  
	CTabHandle	= ^CTabPtr;					{ handle to a color table	}
	CTabPtr		= ^ColorTable;
	ColorTable	= RECORD
					ctSeed:		LONGINT;	{ unique identifier for table	}
					transIndex:	INTEGER;	{ index of transparent pixel	}
					ctSize:		INTEGER;	{ number of entries in CTTable	}
					ctTable:	CSpecArray;
				  END;
					  
	PixMapHandle = ^PixMapPtr;				{ handle to a pixel map	}
	PixMapPtr	= ^PixMap;
	PixMap		= RECORD
					baseAddr:	Ptr;		{ pointer to pixels		}
					rowBytes:	INTEGER;	{ offset to next line	}
					bounds:		Rect;		{ encloses bitmap		}
					pmVersion:	INTEGER;	{ pixMap version number	}
					packType:	INTEGER;	{ defines packing format	}
					packSize:	LONGINT;	{ length of pixel data	}
					hRes:		Fixed;		{ horiz. resolution (ppi)	}
					vRes:		Fixed;		{ vert. resolution (ppi)	}
					pixelType:	INTEGER;	{ defines pixel type	}
					pixelSize:	INTEGER;	{ # bits in pixel		}
					cmpCount:	INTEGER;	{ # components in pixel	}
					cmpSize:	INTEGER;	{ # bits per component	}
					planeBytes:	LONGINT;	{ offset to next plane	}
					pmTable:	CTabHandle;	{ color map for this pixMap	}
					pmReserved:	LONGINT;	{ for future use. MUST BE 0	}
				  END;
					  
	PatXMapHandle = ^PatXMapPtr;				{ handle to expanded pattern }
	PatXMapPtr	= ^PatXMap;
	PatXMap		= RECORD
					patXRow:	INTEGER;	{ rowbytes of expanded pattern }
					patXHMask:	INTEGER;	{ horizontal mask }
					patXVMask:	INTEGER;	{ vertical mask }
					lastCTable:	LONGINT;	{ seed value for last color table }
					lastOfst:	INTEGER;	{ last global-local offset }
					lastInvert:	LONGINT;	{ last invert value }
					lastAlign:	LONGINT;	{ last horizontal align }
					lastStretch: INTEGER;	{ last stretch }
				  END;
					  
					  
	PixPatHandle = ^PixPatPtr;				{ handle to a pattern	}
	PixPatPtr	= ^PixPat;
	PixPat		= RECORD
					patType:	INTEGER;	{ type of pattern		}
					patMap:		PixMapHandle;	{ the pattern's pixMap	}
					patData:	Handle;		{ pixmap's data			}
					patXData:	Handle;		{ expanded pattern data	}
					patXValid:	INTEGER;	{ [word] flags whether expanded pattern valid }
					patXMap:	PatXMapHandle;	{ [long] handle to expanded pattern data }
					pat1Data:	Pattern;	{old-style pattern/RGB color }
				  END;


	CCrsrHandle	= ^CCrsrPtr;
	CCrsrPtr	= ^CCrsr;
	CCrsr		= RECORD
					crsrType: 	INTEGER;	{ type of cursor		}
					crsrMap:	PixMapHandle; { the cursor's pixmap	}
					crsrData: 	Handle;		{ cursor's data			}
					crsrXData:	Handle;		{ expanded cursor data	}
					crsrXValid:	INTEGER;	{ depth of expanded data (0 if none) }
					crsrXHandle: Handle;	{ future use			}
					crsr1Data:	Bits16;		{ one-bit cursor		}
					crsrMask:	Bits16;		{ cursor's mask			}
					crsrHotSpot: Point;		{ cursor's hotspot		}
					crsrXTable:	LONGINT;	{ private				}
					crsrID:		LONGINT;	{ private				}
				  END;
			  
			  
	CIconHandle	= ^CIconPtr;
	CIconPtr	= ^CIcon;
	CIcon		= RECORD
					iconPMap:	PixMap;		{ the icon's pixMap		}
					iconMask: 	BitMap;		{ the icon's mask		}
					iconBMap:	BitMap;		{ the icon's bitMap		}
					iconData:	Handle;		{ the icon's data		}
					iconMaskData: ARRAY[0..0] OF INTEGER; { icon's mask and bitmap data	}
				END;
			  
	GammaTblHandle	= ^GammaTblPtr;
	GammaTblPtr		= ^GammaTbl;
	GammaTbl		= RECORD
					gVersion:		INTEGER;		{ gamma version number }	
					gType:			INTEGER;		{ gamma data type }
					gFormulaSize:	INTEGER;		{ Formula data size }
					gChanCnt:		INTEGER;		{ number of channels of data }
					gDataCnt:		INTEGER;		{ number of values/channel }
					gDataWidth:		INTEGER;		{ bits/corrected value (data packed to next larger byte size) }
					gFormulaData:	ARRAY[0..0] OF INTEGER;	{ data for formulas, followed by gamma values }
				END;

	ITabHandle	= ^ITabPtr;					{ handle to inverse table }
	ITabPtr		= ^ITab;
	ITab		= RECORD
					iTabSeed:	LONGINT;				{copy of CTSeed from source CTable}
					iTabRes:	INTEGER;				{bits/channel resolution of iTable}
					iTTable: 	ARRAY[0..0] OF BYTE;	{byte colortable index values}						
				  END;

	GDHandle	= ^GDPtr;					{ one grafDevice per device	}
	GDPtr		= ^gDevice;
	GDevice		= RECORD
					gdRefNum:	INTEGER;	{ driver's unit number	}
					gdID:		INTEGER;	{ client ID for search procs		}
					gdType:		INTEGER;	{ fixed/CLUT/direct		}
					gdITable:	ITabHandle; { handle to inverse lookup table 	}
					gdResPref:	INTEGER;    { preferred resolution of GDITable 	}
					gdSearchProc: ProcPtr;	{ search proc list head	}
					gdCompProc:	ProcPtr;	{ complement proc list	}
					gdFlags:	INTEGER;	{ grafDevice flags word }
					gdPMap:		PixMapHandle; { handle to pixMap describing device	}
					gdRefCon:	LONGINT;	{ reference value }
					gdNextGD:	GDHandle;	{ handle of next gDevice }
					gdRect:		Rect;		{ device's bounds in global coordinates }
					gdMode:		LONGINT;	{ device's current mode }
					gdCCBytes:	INTEGER;	{ depth of expanded cursor data }
					gdCCDepth:	INTEGER;	{ depth of expanded cursor data }
					gdCCXData:	Handle;		{ handle to cursor's expanded data }
					gdCCXMask:	Handle;		{ handle to cursor's expanded mask }
					gdReserved:	LONGINT;	{ future use. MUST BE 0	}
				END;
					  
	 CQDProcsPtr = ^CQDProcs;
	 CQDProcs = RECORD
					textProc:	Ptr;
					lineProc:	Ptr;
					rectProc:	Ptr;
					rRectProc:	Ptr;
					ovalProc:	Ptr;
					arcProc:	Ptr;
					polyProc:	Ptr;
					rgnProc:	Ptr;
					bitsProc:	Ptr;
					commentProc: Ptr;
					txMeasProc: Ptr;
					getPicProc: Ptr;
					putPicProc: Ptr;
					opcodeProc: Ptr;			{fields added to QDProcs}
					newProc1:	Ptr;
					newProc2:	Ptr;
					newProc3:	Ptr;
					newProc4:	Ptr;
					newProc5:	Ptr;
					newProc6:	Ptr;
				END;

	CGrafPtr	= ^CGrafPort;					{ Color GrafPort		}
	CGrafPort	= RECORD						{ SIZE Notes			}
					device:		INTEGER;
					portPixMap:	PixMapHandle;	{ port's pixel map		}
					portVersion: INTEGER;		{ high 2 bits always set}
					grafVars:	Handle;			{ handle to more fields }
					chExtra :	INTEGER;		{ character extra }
					pnLocHFrac:	INTEGER;		{ pen fraction }
					portRect:	Rect;
					visRgn:		RgnHandle;
					clipRgn:	RgnHandle;
					bkPixPat:	PixPatHandle;	{ background pattern	}
					RGBFgColor:	RGBColor;		{ RGB components of fg	}
					RGBBkColor:	RGBColor;		{ RGB components of bk	}
					pnLoc:		Point;
					pnSize:		Point;
					pnMode:		INTEGER;
					pnPixPat:	PixPatHandle;	{ pen's pattern		}
					fillPixPat:	PixPatHandle;	{ fill pattern		}
					pnVis:		INTEGER;
					txFont:		INTEGER;
					txFace:		Style;
					txMode:		INTEGER;
					txSize:		INTEGER;
					spExtra:	Fixed;
					fgColor:	LONGINT;
					bkColor:	LONGINT;
					colrBit:	INTEGER;
					patStretch:	INTEGER;
					picSave:	QDHandle;
					rgnSave:	QDHandle;
					polySave:	QDHandle;
					grafProcs:	QDProcsPtr;
				END;
					  
	GrafVars	= RECORD
					rgbOpColor:		RGBColor; 	{color for addPin, subPin and average}
					rgbHiliteColor:	RGBColor; 	{color for hiliting}
					pmFgColor:		Handle;		{palette handle for foreground color}
					pmFgIndex:		INTEGER; 	{index value for foreground}
					pmBkColor:		Handle;		{palette handle for background color}
					pmBkIndex:		INTEGER;	{index value for background}
					pmFlags:		INTEGER;	{flags for Palette Manager}
				END;

	SProcHndl	= ^SProcPtr;
	SProcPtr	= ^SProcRec;
	SProcRec	= RECORD
					nxtSrch:		SProcHndl;	{handle to next SProcRec}
					srchProc:		ProcPtr;	{pointer to search procedure}
				END;
			
	CProcHndl	= ^CProcPtr;
	CProcPtr	= ^CProcRec;
	CProcRec	= RECORD
					nxtComp:		CProcHndl;	{handle to next CProcRec}
					compProc:		ProcPtr;	{pointer to complement procedure}
				END;
			
	QDErr = INTEGER;
		
{request List structure}

	ReqListRec	= RECORD
					reqLSize: INTEGER;  			    {request list size}
					reqLData: ARRAY [0..0] OF INTEGER;  {request list data}
				END;

	VAR
	  thePort: GrafPtr;
	  white: Pattern;
	  black: Pattern;
	  gray: Pattern;
	  ltGray: Pattern;
	  dkGray: Pattern;
	  arrow: Cursor;
	  screenBits: BitMap;
	  randSeed: LongInt;

	  { GrafPort Routines }

	PROCEDURE InitGraf(globalPtr: Ptr);
	  INLINE $A86E;

	PROCEDURE OpenPort(port: GrafPtr);
	  INLINE $A86F;

	PROCEDURE InitPort(port: GrafPtr);
	  INLINE $A86D;

	PROCEDURE ClosePort(port: GrafPtr);
	  INLINE $A87D;

	PROCEDURE SetPort(port: GrafPtr);
	  INLINE $A873;

	PROCEDURE GetPort(VAR port: GrafPtr);
	  INLINE $A874;

	PROCEDURE GrafDevice(device: INTEGER);
	  INLINE $A872;

	PROCEDURE SetPortBits(bm: BitMap);
	  INLINE $A875;

	PROCEDURE PortSize(width, height: INTEGER);
	  INLINE $A876;

	PROCEDURE MovePortTo(leftGlobal, topGlobal: INTEGER);
	  INLINE $A877;

	PROCEDURE SetOrigin(h, v: INTEGER);
	  INLINE $A878;

	PROCEDURE SetClip(rgn: RgnHandle);
	  INLINE $A879;

	PROCEDURE GetClip(rgn: RgnHandle);
	  INLINE $A87A;

	PROCEDURE ClipRect(r: Rect);
	  INLINE $A87B;

	PROCEDURE BackPat(pat: Pattern);
	  INLINE $A87C;

	{ Cursor Routines }

	PROCEDURE InitCursor;
	  INLINE $A850;

	PROCEDURE SetCursor(crsr: Cursor);
	  INLINE $A851;

	PROCEDURE HideCursor;
	  INLINE $A852;

	PROCEDURE ShowCursor;
	  INLINE $A853;

	PROCEDURE ObscureCursor;
	  INLINE $A856;

	{ Line Routines }

	PROCEDURE HidePen;
	  INLINE $A896;

	PROCEDURE ShowPen;
	  INLINE $A897;

	PROCEDURE GetPen(VAR pt: Point);
	  INLINE $A89A;

	PROCEDURE GetPenState(VAR pnState: PenState);
	  INLINE $A898;

	PROCEDURE SetPenState(pnState: PenState);
	  INLINE $A899;

	PROCEDURE PenSize(width, height: INTEGER);
	  INLINE $A89B;

	PROCEDURE PenMode(mode: INTEGER);
	  INLINE $A89C;

	PROCEDURE PenPat(pat: Pattern);
	  INLINE $A89D;

	PROCEDURE PenNormal;
	  INLINE $A89E;

	PROCEDURE MoveTo(h, v: INTEGER);
	  INLINE $A893;

	PROCEDURE Move(dh, dv: INTEGER);
	  INLINE $A894;

	PROCEDURE LineTo(h, v: INTEGER);
	  INLINE $A891;

	PROCEDURE Line(dh, dv: INTEGER);
	  INLINE $A892;

	{ Text Routines }

	PROCEDURE TextFont(font: INTEGER);
	  INLINE $A887;

	PROCEDURE TextFace(face: Style);
	  INLINE $A888;

	PROCEDURE TextMode(mode: INTEGER);
	  INLINE $A889;

	PROCEDURE TextSize(size: INTEGER);
	  INLINE $A88A;

	PROCEDURE SpaceExtra(extra: Fixed);
	  INLINE $A88E;

	PROCEDURE DrawChar(ch: char);
	  INLINE $A883;

	PROCEDURE DrawString(s: Str255);
	  INLINE $A884;

	PROCEDURE DrawText(textBuf: Ptr; firstByte, byteCount: INTEGER);
	  INLINE $A885;

	FUNCTION CharWidth(ch: char): INTEGER;
	  INLINE $A88D;

	FUNCTION StringWidth(s: Str255): INTEGER;
	  INLINE $A88C;

	FUNCTION TextWidth(textBuf: Ptr; firstByte, byteCount: INTEGER): INTEGER;
	  INLINE $A886;

	PROCEDURE GetFontInfo(VAR info: FontInfo);
	  INLINE $A88B;

	PROCEDURE MeasureText(count: INTEGER; textAddr, charLocs: Ptr);
	  INLINE $A837;

	{ Point Calculations }

	PROCEDURE AddPt(src: Point; VAR dst: Point);
	  INLINE $A87E;

	PROCEDURE SubPt(src: Point; VAR dst: Point);
	  INLINE $A87F;

	PROCEDURE SetPt(VAR pt: Point; h, v: INTEGER);
	  INLINE $A880;

	FUNCTION EqualPt(pt1, pt2: Point): BOOLEAN;
	  INLINE $A881;

	PROCEDURE ScalePt(VAR pt: Point; fromRect, toRect: Rect);
	  INLINE $A8F8;

	PROCEDURE MapPt(VAR pt: Point; fromRect, toRect: Rect);
	  INLINE $A8F9;

	PROCEDURE LocalToGlobal(VAR pt: Point);
	  INLINE $A870;

	PROCEDURE GlobalToLocal(VAR pt: Point);
	  INLINE $A871;

	{ Rectangle Calculations }

	PROCEDURE SetRect(VAR r: Rect; left, top, right, bottom: INTEGER);
	  INLINE $A8A7;

	FUNCTION EqualRect(rect1, rect2: Rect): BOOLEAN;
	  INLINE $A8A6;

	FUNCTION EmptyRect(r: Rect): BOOLEAN;
	  INLINE $A8AE;

	PROCEDURE OffsetRect(VAR r: Rect; dh, dv: INTEGER);
	  INLINE $A8A8;

	PROCEDURE MapRect(VAR r: Rect; fromRect, toRect: Rect);
	  INLINE $A8FA;

	PROCEDURE InsetRect(VAR r: Rect; dh, dv: INTEGER);
	  INLINE $A8A9;

	FUNCTION SectRect(src1, src2: Rect; VAR dstRect: Rect): BOOLEAN;
	  INLINE $A8AA;

	PROCEDURE UnionRect(src1, src2: Rect; VAR dstRect: Rect);
	  INLINE $A8AB;

	FUNCTION PtInRect(pt: Point; r: Rect): BOOLEAN;
	  INLINE $A8AD;

	PROCEDURE Pt2Rect(pt1, pt2: Point; VAR dstRect: Rect);
	  INLINE $A8AC;

	{ Graphical Operations on Rectangles }

	PROCEDURE FrameRect(r: Rect);
	  INLINE $A8A1;

	PROCEDURE PaintRect(r: Rect);
	  INLINE $A8A2;

	PROCEDURE EraseRect(r: Rect);
	  INLINE $A8A3;

	PROCEDURE InvertRect(r: Rect);
	  INLINE $A8A4;

	PROCEDURE FillRect(r: Rect; pat: Pattern);
	  INLINE $A8A5;

	{ RoundRect Routines }

	PROCEDURE FrameRoundRect(r: Rect; ovWd, ovHt: INTEGER);
	  INLINE $A8B0;

	PROCEDURE PaintRoundRect(r: Rect; ovWd, ovHt: INTEGER);
	  INLINE $A8B1;

	PROCEDURE EraseRoundRect(r: Rect; ovWd, ovHt: INTEGER);
	  INLINE $A8B2;

	PROCEDURE InvertRoundRect(r: Rect; ovWd, ovHt: INTEGER);
	  INLINE $A8B3;

	PROCEDURE FillRoundRect(r: Rect; ovWd, ovHt: INTEGER; pat: Pattern);
	  INLINE $A8B4;

	{ Oval Routines }

	PROCEDURE FrameOval(r: Rect);
	  INLINE $A8B7;

	PROCEDURE PaintOval(r: Rect);
	  INLINE $A8B8;

	PROCEDURE EraseOval(r: Rect);
	  INLINE $A8B9;

	PROCEDURE InvertOval(r: Rect);
	  INLINE $A8BA;

	PROCEDURE FillOval(r: Rect; pat: Pattern);
	  INLINE $A8BB;

	{ Arc Routines }

	PROCEDURE FrameArc(r: Rect; startAngle, arcAngle: INTEGER);
	  INLINE $A8BE;

	PROCEDURE PaintArc(r: Rect; startAngle, arcAngle: INTEGER);
	  INLINE $A8BF;

	PROCEDURE EraseArc(r: Rect; startAngle, arcAngle: INTEGER);
	  INLINE $A8C0;

	PROCEDURE InvertArc(r: Rect; startAngle, arcAngle: INTEGER);
	  INLINE $A8C1;

	PROCEDURE FillArc(r: Rect; startAngle, arcAngle: INTEGER; pat: Pattern);
	  INLINE $A8C2;

	PROCEDURE PtToAngle(r: Rect; pt: Point; VAR angle: INTEGER);
	  INLINE $A8C3;

	{ Polygon Routines }

	FUNCTION OpenPoly: PolyHandle;
	  INLINE $A8CB;

	PROCEDURE ClosePoly;
	  INLINE $A8CC;

	PROCEDURE KillPoly(poly: PolyHandle);
	  INLINE $A8CD;

	PROCEDURE OffsetPoly(poly: PolyHandle; dh, dv: INTEGER);
	  INLINE $A8CE;

	PROCEDURE MapPoly(poly: PolyHandle; fromRect, toRect: Rect);
	  INLINE $A8FC;

	PROCEDURE FramePoly(poly: PolyHandle);
	  INLINE $A8C6;

	PROCEDURE PaintPoly(poly: PolyHandle);
	  INLINE $A8C7;

	PROCEDURE ErasePoly(poly: PolyHandle);
	  INLINE $A8C8;

	PROCEDURE InvertPoly(poly: PolyHandle);
	  INLINE $A8C9;

	PROCEDURE FillPoly(poly: PolyHandle; pat: Pattern);
	  INLINE $A8CA;

	{ Region Calculations }

	FUNCTION NewRgn: RgnHandle;
	  INLINE $A8D8;

	PROCEDURE DisposeRgn(rgn: RgnHandle);
	  INLINE $A8D9;

	PROCEDURE CopyRgn(srcRgn, dstRgn: RgnHandle);
	  INLINE $A8DC;

	PROCEDURE SetEmptyRgn(rgn: RgnHandle);
	  INLINE $A8DD;

	PROCEDURE SetRectRgn(rgn: RgnHandle; left, top, right, bottom: INTEGER);
	  INLINE $A8DE;

	PROCEDURE RectRgn(rgn: RgnHandle; r: Rect);
	  INLINE $A8DF;

	PROCEDURE OpenRgn;
	  INLINE $A8DA;

	PROCEDURE CloseRgn(dstRgn: RgnHandle);
	  INLINE $A8DB;

	PROCEDURE OffsetRgn(rgn: RgnHandle; dh, dv: INTEGER);
	  INLINE $A8E0;

	PROCEDURE MapRgn(rgn: RgnHandle; fromRect, toRect: Rect);
	  INLINE $A8FB;

	PROCEDURE InsetRgn(rgn: RgnHandle; dh, dv: INTEGER);
	  INLINE $A8E1;

	PROCEDURE SectRgn(srcRgnA, srcRgnB, dstRgn: RgnHandle);
	  INLINE $A8E4;

	PROCEDURE UnionRgn(srcRgnA, srcRgnB, dstRgn: RgnHandle);
	  INLINE $A8E5;

	PROCEDURE DiffRgn(srcRgnA, srcRgnB, dstRgn: RgnHandle);
	  INLINE $A8E6;

	PROCEDURE XorRgn(srcRgnA, srcRgnB, dstRgn: RgnHandle);
	  INLINE $A8E7;

	FUNCTION EqualRgn(rgnA, rgnB: RgnHandle): BOOLEAN;
	  INLINE $A8E3;

	FUNCTION EmptyRgn(rgn: RgnHandle): BOOLEAN;
	  INLINE $A8E2;

	FUNCTION PtInRgn(pt: Point; rgn: RgnHandle): BOOLEAN;
	  INLINE $A8E8;

	FUNCTION RectInRgn(r: Rect; rgn: RgnHandle): BOOLEAN;
	  INLINE $A8E9;

	{ Graphical Operations on Regions }

	PROCEDURE FrameRgn(rgn: RgnHandle);
	  INLINE $A8D2;

	PROCEDURE PaintRgn(rgn: RgnHandle);
	  INLINE $A8D3;

	PROCEDURE EraseRgn(rgn: RgnHandle);
	  INLINE $A8D4;

	PROCEDURE InvertRgn(rgn: RgnHandle);
	  INLINE $A8D5;

	PROCEDURE FillRgn(rgn: RgnHandle; pat: Pattern);
	  INLINE $A8D6;

	{ Graphical Operations on BitMaps }

	PROCEDURE ScrollRect(dstRect: Rect; dh, dv: INTEGER; updateRgn: RgnHandle);
	  INLINE $A8EF;

	PROCEDURE CopyBits(srcBits, dstBits: BitMap; srcRect, dstRect: Rect;
					   mode: INTEGER; maskRgn: RgnHandle);
	  INLINE $A8EC;

	PROCEDURE SeedFill(srcPtr, dstPtr: Ptr; srcRow, dstRow, height,
					   words: INTEGER; seedH, seedV: INTEGER);
	  INLINE $A839;

	PROCEDURE CalcMask(srcPtr, dstPtr: Ptr; srcRow, dstRow, height,
					   words: INTEGER);
	  INLINE $A838;

	PROCEDURE CopyMask(srcBits, naskBits, dstBits: BitMap; srcRect, maskRect,
					   dstRect: Rect);
	  INLINE $A817;

	FUNCTION GetMaskTable: Ptr;

	{ Picture Routines }

	FUNCTION OpenPicture(picFrame: Rect): PicHandle;
	  INLINE $A8F3;

	PROCEDURE ClosePicture;
	  INLINE $A8F4;

	PROCEDURE DrawPicture(myPicture: PicHandle; dstRect: Rect);
	  INLINE $A8F6;

	PROCEDURE PicComment(kind, dataSize: INTEGER; dataHandle: Handle);
	  INLINE $A8F2;

	PROCEDURE KillPicture(myPicture: PicHandle);
	  INLINE $A8F5;

	{  The Bottleneck Interface:   }

	PROCEDURE SetStdProcs(VAR procs: QDProcs);
	  INLINE $A8EA;

	PROCEDURE StdText(count: INTEGER; textAddr: Ptr; numer, denom: Point);
	  INLINE $A882;

	PROCEDURE StdLine(newPt: Point);
	  INLINE $A890;

	PROCEDURE StdRect(verb: GrafVerb; r: Rect);
	  INLINE $A8A0;

	PROCEDURE StdRRect(verb: GrafVerb; r: Rect; ovWd, ovHt: INTEGER);
	  INLINE $A8AF;

	PROCEDURE StdOval(verb: GrafVerb; r: Rect);
	  INLINE $A8B6;

	PROCEDURE StdArc(verb: GrafVerb; r: Rect; startAngle, arcAngle: INTEGER);
	  INLINE $A8BD;

	PROCEDURE StdPoly(verb: GrafVerb; poly: PolyHandle);
	  INLINE $A8C5;

	PROCEDURE StdRgn(verb: GrafVerb; rgn: RgnHandle);
	  INLINE $A8D1;

	PROCEDURE StdBits(VAR srcBits: BitMap; VAR srcRect, dstRect: Rect;
					  mode: INTEGER; maskRgn: RgnHandle);
	  INLINE $A8EB;

	PROCEDURE StdComment(kind, dataSize: INTEGER; dataHandle: Handle);
	  INLINE $A8F1;

	FUNCTION StdTxMeas(count: INTEGER; textAddr: Ptr; VAR numer, denom: Point;
					   VAR info: FontInfo): INTEGER;
	  INLINE $A8ED;

	PROCEDURE StdGetPic(dataPtr: Ptr; byteCount: INTEGER);
	  INLINE $A8EE;

	PROCEDURE StdPutPic(dataPtr: Ptr; byteCount: INTEGER);
	  INLINE $A8F0;

	{ Misc Utility Routines }

	FUNCTION GetPixel(h, v: INTEGER): BOOLEAN;
	  INLINE $A865;

	FUNCTION Random: INTEGER;
	  INLINE $A861;

	PROCEDURE StuffHex(thingptr: Ptr; s: Str255);
	  INLINE $A866;

	PROCEDURE ForeColor(color: LongInt);
	  INLINE $A862;

	PROCEDURE BackColor(color: LongInt);
	  INLINE $A863;

	PROCEDURE ColorBit(whichBit: INTEGER);
	  INLINE $A864;


{ ****** THE FOLLOWING ROUTINES WERE ADDED FOR COLOR QUICKDRAW. *****}

{ Routines for Manipulating the CGrafPort	}

PROCEDURE  OpenCPort(port: CGrafPtr);
	INLINE $AA00;
PROCEDURE InitCPort(port: CGrafPtr);
	INLINE $AA01;
PROCEDURE CloseCPort(port: CGrafPtr);
	INLINE $AA02;

{ Routines for Manipulating PixMaps	}

FUNCTION  NewPixMap:PixMapHandle;
	INLINE $AA03;
PROCEDURE DisposPixMap(pm: PixMapHandle);
	INLINE $AA04;
PROCEDURE CopyPixMap(srcPM,dstPM: PixMapHandle);
	INLINE $AA05;
PROCEDURE SetCPortPix(pm: PixMapHandle);
	INLINE $AA06;

{ Routines for Manipulating PixPats	}

FUNCTION  NewPixPat:PixPatHandle;
	INLINE $AA07;
PROCEDURE DisposPixPat(pp: PixPatHandle);
	INLINE $AA08;
PROCEDURE CopyPixPat(srcPP,dstPP: PixPatHandle);
	INLINE $AA09;
PROCEDURE PenPixPat(pp: PixPatHandle);
	INLINE $AA0A;
PROCEDURE BackPixPat(pp: PixPatHandle);
	INLINE $AA0B;
FUNCTION  GetPixPat(patID: INTEGER): PixPatHandle;
	INLINE $AA0C;
PROCEDURE MakeRGBPat(pp: PixPatHandle; myColor: RGBColor);
	INLINE $AA0D;


PROCEDURE FillCRect(r: Rect; pp: PixPatHandle);
	INLINE $AA0E;
PROCEDURE FillCOval(r: Rect; pp: PixPatHandle);
	INLINE $AA0F;
PROCEDURE FillCRoundRect(r: Rect; ovWd,ovHt: INTEGER; pp: PixPatHandle);
	INLINE $AA10;
PROCEDURE FillCArc(r: Rect; startAngle,arcAngle: INTEGER; pp: PixPatHandle);
	INLINE $AA11;
PROCEDURE FillCRgn(rgn: RgnHandle; pp: PixPatHandle);
	INLINE $AA12;
PROCEDURE FillCPoly(poly: PolyHandle; pp: PixPatHandle);
	INLINE $AA13;


PROCEDURE RGBForeColor(color: RGBColor);
	INLINE $AA14;
PROCEDURE RGBBackColor(color: RGBColor);
	INLINE $AA15;
PROCEDURE SetCPixel(h,v: INTEGER; cPix: ColorSpec);
	INLINE $AA16;
FUNCTION  GetCPixel(h,v: INTEGER): ColorSpec;
	INLINE $AA17;
PROCEDURE GetForeColor(VAR color: RGBColor);
	INLINE $AA19;
PROCEDURE GetBackColor(VAR color: RGBColor);
	INLINE $AA1A;

{ Transfer Mode Utilities	}

PROCEDURE OpColor(color: RGBColor);
	INLINE $AA21;
PROCEDURE HiliteColor(color: RGBColor);
	INLINE $AA22;

{ Color Table Handling Routines	}

PROCEDURE DisposCTable(cTable: CTabHandle);
	INLINE $AA24;
FUNCTION GetCTable(ctID: INTEGER): CTabHandle;
	INLINE $AA18;

{ Color Cursor Handling Routines	}

FUNCTION GetCCursor(crsrID: INTEGER): CCrsrHandle;
	INLINE $AA1B;
PROCEDURE SetCCursor(cCrsr: CCrsrHandle);
	INLINE $AA1C;
PROCEDURE AllocCursor;
	INLINE $AA1D;
PROCEDURE DisposCCursor(cCrsr: CCrsrHandle);
	INLINE $AA26;

{ Icon Handling Routines	}

FUNCTION GetCIcon(iconID: INTEGER): cIconHandle;
	INLINE $AA1E;
PROCEDURE PlotCIcon(theRect: Rect; theIcon: cIconHandle);
	INLINE $AA1F;
PROCEDURE DisposCIcon(theIcon: cIconHandle);
	INLINE $AA25;
	
{ PixMap Handling Routines	}

PROCEDURE CopyPix(srcPix,dstPix: PixMap; srcRect,dstRect: Rect;
						 mode: INTEGER; maskRgn: RgnHandle);
	INLINE $A8EC;
PROCEDURE CopyCMask(srcPix: PixMap; maskBits: BitMap; dstPix: PixMap;
						 srcRect,maskRect,dstRect: Rect);
	INLINE $A817;

{ Picture Routines}

FUNCTION OpenCPicture(picFrame: Rect): PicHandle;
	INLINE $AA20;

{ Text Routines}

PROCEDURE CharExtra(extra: Fixed);
	INLINE $AA23;

{ GDevice Routines	}

FUNCTION  GetMaxDevice(globalRect: Rect) : GDHandle;
	INLINE $AA27;
FUNCTION  GetCTSeed : LONGINT;
	INLINE $AA28;
FUNCTION  GetDeviceList : GDHandle;
	INLINE $AA29;
FUNCTION  GetMainDevice : GDHandle;
	INLINE $AA2A;
FUNCTION  GetNextDevice(curDevice: GDHandle) : GDHandle;
	INLINE $AA2B;
FUNCTION  TestDeviceAttribute(gdh: GDHandle; attribute: INTEGER) : BOOLEAN;
	INLINE $AA2C;
PROCEDURE SetDeviceAttribute(gdh: GDHandle; attribute: INTEGER; value: BOOLEAN);
	INLINE $AA2D;
PROCEDURE InitGDevice(unitNum: INTEGER; mode: LONGINT; GDH: GDHandle);
	INLINE $AA2E;
FUNCTION  NewGDevice(unitNum: INTEGER; mode: LONGINT) : GDHandle;
	INLINE $AA2F;
PROCEDURE DisposGDevice(gdh: GDHandle);
	INLINE $AA30;
PROCEDURE SetGDevice(gd: GDHandle);
	INLINE $AA31;
FUNCTION  GetGDevice:GDHandle;
	INLINE $AA32;

{ Color Manager Interface	}

FUNCTION Color2Index(VAR myColor: RGBColor): LONGINT;
	INLINE $AA33;
PROCEDURE Index2Color(index: LONGINT; VAR aColor: RGBColor);
	INLINE $AA34;
PROCEDURE InvertColor(VAR myColor : RGBColor );
	INLINE $AA35;
FUNCTION  RealColor(color: RGBColor): BOOLEAN;
	INLINE $AA36;
PROCEDURE GetSubTable(VAR myColors:CTabHandle; iTabRes:integer; targetTbl:CTabHandle);
	INLINE $AA37;
PROCEDURE MakeITable(cTabH: CTabHandle; iTabH: ITabHandle; res: INTEGER);
	INLINE $AA39;
PROCEDURE AddSearch(searchProc: ProcPtr);
	INLINE $AA3A;
PROCEDURE AddComp(compProc: ProcPtr);
	INLINE $AA3B;
PROCEDURE DelSearch(searchProc: ProcPtr);
	INLINE $AA4C;
PROCEDURE DelComp(compProc: ProcPtr);
	INLINE $AA4D;
PROCEDURE SetClientID(id: INTEGER);
	INLINE $AA3C;
PROCEDURE ProtectEntry(index: INTEGER; protect: BOOLEAN);
	INLINE $AA3D;
PROCEDURE ReserveEntry(index: INTEGER; reserve: BOOLEAN);
	INLINE $AA3E;
PROCEDURE SetEntries(start, count: INTEGER; aTable: CSpecArray);
	INLINE $AA3F;
PROCEDURE SaveEntries(srcTable, resultTable: CTabHandle; VAR selection: ReqListRec);
	INLINE $AA49;
PROCEDURE RestoreEntries(srcTable, dstTable: CTabHandle; VAR selection: ReqListRec);
	INLINE $AA4A;
FUNCTION QDError: INTEGER;
	INLINE $AA40;
	
END.


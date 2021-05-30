{
  File: Quickdraw.p

 Version: 2.0

 Copyright Apple Computer, Inc. 1984, 1985, 1986
 All Rights Reserved

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

END.

/*
	Quickdraw.h -- QuickDraw

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __QUICKDRAW__
#define __QUICKDRAW__
#ifndef __TYPES__
#include <Types.h>
#endif

#define srcCopy 0
#define srcOr 1
#define srcXor 2
#define srcBic 3
#define notSrcCopy 4
#define notSrcOr 5
#define notSrcXor 6
#define notSrcBic 7
#define patCopy 8
#define patOr 9
#define patXor 10
#define patBic 11
#define notPatCopy 12
#define notPatOr 13
#define notPatXor 14
#define notPatBic 15
#define normalBit 0
#define inverseBit 1
#define redBit 4
#define greenBit 3
#define blueBit 2
#define cyanBit 8
#define magentaBit 7
#define yellowBit 6
#define blackBit 5
#define blackColor 33
#define whiteColor 30
#define redColor 205
#define greenColor 341
#define blueColor 409
#define cyanColor 273
#define magentaColor 137
#define yellowColor 69
#define picLParen 0
#define picRParen 1
#define normal 0x00
#define bold 0x01
#define italic 0x02
#define underline 0x04
#define outline 0x08
#define shadow 0x10
#define condense 0x20
#define extend 0x40
typedef unsigned char Pattern[8];
typedef short Bits16[16];
typedef enum {frame,paint,erase,invert,fill} GrafVerb;
typedef struct FontInfo {
	short ascent;
	short descent;
	short widMax;
	short leading;
} FontInfo;
typedef struct BitMap {
	Ptr baseAddr;
	short rowBytes;
	Rect bounds;
} BitMap;
typedef struct Cursor {
	Bits16 data;
	Bits16 mask;
	Point hotSpot;
} Cursor;
typedef struct PenState {
	Point pnLoc;
	Point pnSize;
	short pnMode;
	Pattern pnPat;
} PenState;
typedef struct Region {
	short rgnSize;
	Rect rgnBBox;
	short rgnData[1];
} Region,*RgnPtr,**RgnHandle;
typedef struct Picture {
	short picSize;
	Rect picFrame;
	short picData[1];
} Picture,*PicPtr,**PicHandle;
typedef struct Polygon {
	short polySize;
	Rect polyBBox;
	Point polyPoints[1];
} Polygon,*PolyPtr,**PolyHandle;
typedef struct QDProcs {
	ProcPtr textProc;
	ProcPtr lineProc;
	ProcPtr rectProc;
	ProcPtr rRectProc;
	ProcPtr ovalProc;
	ProcPtr arcProc;
	ProcPtr polyProc;
	ProcPtr rgnProc;
	ProcPtr bitsProc;
	ProcPtr commentProc;
	ProcPtr txMeasProc;
	ProcPtr getPicProc;
	ProcPtr putPicProc;
} QDProcs,*QDProcsPtr;
typedef struct GrafPort {
	short device;
	BitMap portBits;
	Rect portRect;
	RgnHandle visRgn;
	RgnHandle clipRgn;
	Pattern bkPat;
	Pattern fillPat;
	Point pnLoc;
	Point pnSize;
	short pnMode;
	Pattern pnPat;
	short pnVis;
	short txFont;
	Style txFace;
	short txMode;
	short txSize;
	Fixed spExtra;
	long fgColor;
	long bkColor;
	short colrBit;
	short patStretch;
	PicHandle picSave;
	RgnHandle rgnSave;
	PolyHandle polySave;
	QDProcsPtr grafProcs;
} GrafPort,*GrafPtr;
extern struct qd {
	char private[76];
	long randSeed;
	BitMap screenBits;
	Cursor arrow;
	Pattern dkGray;
	Pattern ltGray;
	Pattern gray;
	Pattern black;
	Pattern white;
	GrafPtr thePort;
} qd;

pascal void InitGraf(globalPtr)
	Ptr globalPtr;
	extern 0xA86E;
pascal void OpenPort(port)
	GrafPtr port;
	extern 0xA86F;
pascal void InitPort(port)
	GrafPtr port;
	extern 0xA86D;
pascal void ClosePort(port)
	GrafPtr port;
	extern 0xA87D;
pascal void SetPort(port)
	GrafPtr port;
	extern 0xA873;
pascal void GetPort(port)
	GrafPtr *port;
	extern 0xA874;
pascal void GrafDevice(device)
	short device;
	extern 0xA872;
pascal void SetPortBits(bm)
	BitMap *bm;
	extern 0xA875;
pascal void PortSize(width,height)
	short width,height;
	extern 0xA876;
pascal void MovePortTo(leftGlobal,topGlobal)
	short leftGlobal,topGlobal;
	extern 0xA877;
pascal void SetOrigin(h,v)
	short h,v;
	extern 0xA878;
pascal void SetClip(rgn)
	RgnHandle rgn;
	extern 0xA879;
pascal void GetClip(rgn)
	RgnHandle rgn;
	extern 0xA87A;
pascal void ClipRect(r)
	Rect *r;
	extern 0xA87B;
pascal void BackPat(pat)
	Pattern pat;
	extern 0xA87C;
pascal void InitCursor()
	extern 0xA850;
pascal void SetCursor(crsr)
	Cursor *crsr;
	extern 0xA851;
pascal void HideCursor()
	extern 0xA852;
pascal void ShowCursor()
	extern 0xA853;
pascal void ObscureCursor()
	extern 0xA856;
pascal void HidePen()
	extern 0xA896;
pascal void ShowPen()
	extern 0xA897;
pascal void GetPen(pt)
	Point *pt;
	extern 0xA89A;
pascal void GetPenState(pnState)
	PenState *pnState;
	extern 0xA898;
pascal void SetPenState(pnState)
	PenState *pnState;
	extern 0xA899;
pascal void PenSize(width,height)
	short width,height;
	extern 0xA89B;
pascal void PenMode(mode)
	short mode;
	extern 0xA89C;
pascal void PenPat(pat)
	Pattern pat;
	extern 0xA89D;
pascal void PenNormal()
	extern 0xA89E;
pascal void MoveTo(h,v)
	short h,v;
	extern 0xA893;
pascal void Move(dh,dv)
	short dh,dv;
	extern 0xA894;
pascal void LineTo(h,v)
	short h,v;
	extern 0xA891;
pascal void Line(dh,dv)
	short dh,dv;
	extern 0xA892;
pascal void TextFont(font)
	short font;
	extern 0xA887;
pascal void TextFace(face)
	Style face;
	extern 0xA888;
pascal void TextMode(mode)
	short mode;
	extern 0xA889;
pascal void TextSize(size)
	short size;
	extern 0xA88A;
pascal void SpaceExtra(extra)
	Fixed extra;
	extern 0xA88E;
pascal void DrawChar(ch)
	short ch;
	extern 0xA883;
pascal void DrawText(textBuf,firstByte,byteCount)
	Ptr textBuf;
	short firstByte,byteCount;
	extern 0xA885;
pascal short CharWidth(ch)
	short ch;
	extern 0xA88D;
pascal short TextWidth(textBuf,firstByte,byteCount)
	Ptr textBuf;
	short firstByte,byteCount;
	extern 0xA886;
pascal void MeasureText(count,textAddr,charLocs)
	short count;
	Ptr textAddr,charLocs;
	extern 0xA837;
pascal void GetFontInfo(info)
	FontInfo *info;
	extern 0xA88B;
pascal void ForeColor(color)
	long color;
	extern 0xA862;
pascal void BackColor(color)
	long color;
	extern 0xA863;
pascal void ColorBit(whichBit)
	short whichBit;
	extern 0xA864;
pascal void SetRect(r,left,top,right,bottom)
	Rect *r;
	short left,top,right,bottom;
	extern 0xA8A7;
pascal void OffsetRect(r,dh,dv)
	Rect *r;
	short dh,dv;
	extern 0xA8A8;
pascal void InsetRect(r,dh,dv)
	Rect *r;
	short dh,dv;
	extern 0xA8A9;
pascal Boolean SectRect(src1,src2,dstRect)
	Rect *src1,*src2;
	Rect *dstRect;
	extern 0xA8AA;
pascal void UnionRect(src1,src2,dstRect)
	Rect *src1,*src2;
	Rect *dstRect;
	extern 0xA8AB;
pascal Boolean EqualRect(rect1,rect2)
	Rect *rect1,*rect2;
	extern 0xA8A6;
pascal Boolean EmptyRect(r)
	Rect *r;
	extern 0xA8AE;
pascal void FrameRect(r)
	Rect *r;
	extern 0xA8A1;
pascal void PaintRect(r)
	Rect *r;
	extern 0xA8A2;
pascal void EraseRect(r)
	Rect *r;
	extern 0xA8A3;
pascal void InvertRect(r)
	Rect *r;
	extern 0xA8A4;
pascal void FillRect(r,pat)
	Rect *r;
	Pattern pat;
	extern 0xA8A5;
pascal void FrameOval(r)
	Rect *r;
	extern 0xA8B7;
pascal void PaintOval(r)
	Rect *r;
	extern 0xA8B8;
pascal void EraseOval(r)
	Rect *r;
	extern 0xA8B9;
pascal void InvertOval(r)
	Rect *r;
	extern 0xA8BA;
pascal void FillOval(r,pat)
	Rect *r;
	Pattern pat;
	extern 0xA8BB;
pascal void FrameRoundRect(r,ovalWidth,ovalHeight)
	Rect *r;
	short ovalWidth,ovalHeight;
	extern 0xA8B0;
pascal void PaintRoundRect(r,ovalWidth,ovalHeight)
	Rect *r;
	short ovalWidth,ovalHeight;
	extern 0xA8B1;
pascal void EraseRoundRect(r,ovalWidth,ovalHeight)
	Rect *r;
	short ovalWidth,ovalHeight;
	extern 0xA8B2;
pascal void InvertRoundRect(r,ovalWidth,ovalHeight)
	Rect *r;
	short ovalWidth,ovalHeight;
	extern 0xA8B3;
pascal void FillRoundRect(r,ovalWidth,ovalHeight,pat)
	Rect *r;
	short ovalWidth,ovalHeight;
	Pattern pat;
	extern 0xA8B4;
pascal void FrameArc(r,startAngle,arcAngle)
	Rect *r;
	short startAngle,arcAngle;
	extern 0xA8BE;
pascal void PaintArc(r,startAngle,arcAngle)
	Rect *r;
	short startAngle,arcAngle;
	extern 0xA8BF;
pascal void EraseArc(r,startAngle,arcAngle)
	Rect *r;
	short startAngle,arcAngle;
	extern 0xA8C0;
pascal void InvertArc(r,startAngle,arcAngle)
	Rect *r;
	short startAngle,arcAngle;
	extern 0xA8C1;
pascal void FillArc(r,startAngle,arcAngle,pat)
	Rect *r;
	short startAngle,arcAngle;
	Pattern pat;
	extern 0xA8C2;
pascal RgnHandle NewRgn()
	extern 0xA8D8;
pascal void OpenRgn()
	extern 0xA8DA;
pascal void CloseRgn(dstRgn)
	RgnHandle dstRgn;
	extern 0xA8DB;
pascal void DisposeRgn(rgn)
	RgnHandle rgn;
	extern 0xA8D9;
pascal void CopyRgn(srcRgn,dstRgn)
	RgnHandle srcRgn,dstRgn;
	extern 0xA8DC;
pascal void SetEmptyRgn(rgn)
	RgnHandle rgn;
	extern 0xA8DD;
pascal void SetRectRgn(rgn,left,top,right,bottom)
	RgnHandle rgn;
	short left,top,right,bottom;
	extern 0xA8DE;
pascal void RectRgn(rgn,r)
	RgnHandle rgn;
	Rect *r;
	extern 0xA8DF;
pascal void OffsetRgn(rgn,dh,dv)
	RgnHandle rgn;
	short dh,dv;
	extern 0xA8E0;
pascal void InsetRgn(rgn,dh,dv)
	RgnHandle rgn;
	short dh,dv;
	extern 0xA8E1;
pascal void SectRgn(srcRgnA,srcRgnB,dstRgn)
	RgnHandle srcRgnA,srcRgnB,dstRgn;
	extern 0xA8E4;
pascal void UnionRgn(srcRgnA,srcRgnB,dstRgn)
	RgnHandle srcRgnA,srcRgnB,dstRgn;
	extern 0xA8E5;
pascal void DiffRgn(srcRgnA,srcRgnB,dstRgn)
	RgnHandle srcRgnA,srcRgnB,dstRgn;
	extern 0xA8E6;
pascal void XorRgn(srcRgnA,srcRgnB,dstRgn)
	RgnHandle srcRgnA,srcRgnB,dstRgn;
	extern 0xA8E7;
pascal Boolean RectInRgn(r,rgn)
	Rect *r;
	RgnHandle rgn;
	extern 0xA8E9;
pascal Boolean EqualRgn(rgnA,rgnB)
	RgnHandle rgnA,rgnB;
	extern 0xA8E3;
pascal Boolean EmptyRgn(rgn)
	RgnHandle rgn;
	extern 0xA8E2;
pascal void FrameRgn(rgn)
	RgnHandle rgn;
	extern 0xA8D2;
pascal void PaintRgn(rgn)
	RgnHandle rgn;
	extern 0xA8D3;
pascal void EraseRgn(rgn)
	RgnHandle rgn;
	extern 0xA8D4;
pascal void InvertRgn(rgn)
	RgnHandle rgn;
	extern 0xA8D5;
pascal void FillRgn(rgn,pat)
	RgnHandle rgn;
	Pattern pat;
	extern 0xA8D6;
pascal void ScrollRect(r,dh,dv,updateRgn)
	Rect *r;
	short dh,dv;
	RgnHandle updateRgn;
	extern 0xA8EF;
pascal void CopyBits(srcBits,dstBits,srcRect,dstRect,mode,maskRgn)
	BitMap *srcBits,*dstBits;
	Rect *srcRect,*dstRect;
	short mode;
	RgnHandle maskRgn;
	extern 0xA8EC;
pascal void SeedFill(srcPtr,dstPtr,srcRow,dstRow,height,words,seedH,seedV)
	Ptr srcPtr,dstPtr;
	short srcRow,dstRow,height,words;
	short seedH,seedV;
	extern 0xA839;
pascal void CalcMask(srcPtr,dstPtr,srcRow,dstRow,height,words)
	Ptr srcPtr,dstPtr;
	short srcRow,dstRow,height,words;
	extern 0xA838;
pascal void CopyMask(srcBits,maskBits,dstBits,srcRect,maskRect,dstRect)
	BitMap *srcBits,*maskBits,*dstBits;
	Rect *srcRect,*maskRect,*dstRect;
	extern 0xA817;
pascal PicHandle OpenPicture(picFrame)
	Rect *picFrame;
	extern 0xA8F3;
pascal void PicComment(kind,dataSize,dataHandle)
	short kind,dataSize;
	Handle dataHandle;
	extern 0xA8F2;
pascal void ClosePicture()
	extern 0xA8F4;
pascal void DrawPicture(myPicture,dstRect)
	PicHandle myPicture;
	Rect *dstRect;
	extern 0xA8F6;
pascal void KillPicture(myPicture)
	PicHandle myPicture;
	extern 0xA8F5;
pascal PolyHandle OpenPoly()
	extern 0xA8CB;
pascal void ClosePoly()
	extern 0xA8CC;
pascal void KillPoly(poly)
	PolyHandle poly;
	extern 0xA8CD;
pascal void OffsetPoly(poly,dh,dv)
	PolyHandle poly;
	short dh,dv;
	extern 0xA8CE;
pascal void FramePoly(poly)
	PolyHandle poly;
	extern 0xA8C6;
pascal void PaintPoly(poly)
	PolyHandle poly;
	extern 0xA8C7;
pascal void ErasePoly(poly)
	PolyHandle poly;
	extern 0xA8C8;
pascal void InvertPoly(poly)
	PolyHandle poly;
	extern 0xA8C9;
pascal void FillPoly(poly,pat)
	PolyHandle poly;
	Pattern pat;
	extern 0xA8CA;
pascal void SetPt(pt,h,v)
	Point *pt;
	short h,v;
	extern 0xA880;
pascal void LocalToGlobal(pt)
	Point *pt;
	extern 0xA870;
pascal void GlobalToLocal(pt)
	Point *pt;
	extern 0xA871;
pascal short Random()
	extern 0xA861;
pascal Boolean GetPixel(h,v)
	short h,v;
	extern 0xA865;
pascal void ScalePt(pt,srcRect,dstRect)
	Point *pt;
	Rect *srcRect,*dstRect;
	extern 0xA8F8;
pascal void MapPt(pt,srcRect,dstRect)
	Point *pt;
	Rect *srcRect,*dstRect;
	extern 0xA8F9;
pascal void MapRect(r,srcRect,dstRect)
	Rect *r;
	Rect *srcRect,*dstRect;
	extern 0xA8FA;
pascal void MapRgn(rgn,srcRect,dstRect)
	RgnHandle rgn;
	Rect *srcRect,*dstRect;
	extern 0xA8FB;
pascal void MapPoly(poly,srcRect,dstRect)
	PolyHandle poly;
	Rect *srcRect,*dstRect;
	extern 0xA8FC;
pascal void SetStdProcs(procs)
	QDProcs *procs;
	extern 0xA8EA;
pascal void StdRect(verb,r)
	GrafVerb verb;
	Rect *r;
	extern 0xA8A0;
pascal void StdRRect(verb,r,ovalWidth,ovalHeight)
	GrafVerb verb;
	Rect *r;
	short ovalWidth,ovalHeight;
	extern 0xA8AF;
pascal void StdOval(verb,r)
	GrafVerb verb;
	Rect *r;
	extern 0xA8B6;
pascal void StdArc(verb,r,startAngle,arcAngle)
	GrafVerb verb;
	Rect *r;
	short startAngle,arcAngle;
	extern 0xA8BD;
pascal void StdPoly(verb,poly)
	GrafVerb verb;
	PolyHandle poly;
	extern 0xA8C5;
pascal void StdRgn(verb,rgn)
	GrafVerb verb;
	RgnHandle rgn;
	extern 0xA8D1;
pascal void StdBits(srcBits,srcRect,dstRect,mode,maskRgn)
	BitMap *srcBits;
	Rect *srcRect,*dstRect;
	short mode;
	RgnHandle maskRgn;
	extern 0xA8EB;
pascal void StdComment(kind,dataSize,dataHandle)
	short kind,dataSize;
	Handle dataHandle;
	extern 0xA8F1;
pascal short StdTxMeas(byteCount,textAddr,numer,denom,info)
	short byteCount;
	Ptr textAddr;
	Point *numer,*denom;
	FontInfo *info;
	extern 0xA8ED;
pascal void StdGetPic(dataPtr,byteCount)
	Ptr dataPtr;
	short byteCount;
	extern 0xA8EE;
pascal void StdPutPic(dataPtr,byteCount)
	Ptr dataPtr;
	short byteCount;
	extern 0xA8F0;
#endif

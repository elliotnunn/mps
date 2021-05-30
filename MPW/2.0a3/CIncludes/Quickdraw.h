/*
	Quickdraw.h -- Color Quickdraw interface 

	Version: 2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985-1987
	All rights reserved.
*/
/*
	modifications:
	01/22/87	KLH	added CQDProcs record instead of lengthening existing
						QDProcs.
	01/26/87	KLH	gdPMap previously changed from handle to PixMapHandle,
						but misspelled as gdDPMap.
	15Dec86		DAF 	added gamma table format
	16Feb87		KLH	OpenCPicture changed to agree with OpenPicture.
	19feb87		KLH	SetEntries parameters corrected.
	9MAR87		KLH removed UpdatePixMap until finished
					updated Color2Index & Index2Color.
	
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

typedef char QDByte, *QDPtr, **QDHandle;
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
	Ptr textProc;
	Ptr lineProc;
	Ptr rectProc;
	Ptr rRectProc;
	Ptr ovalProc;
	Ptr arcProc;
	Ptr polyProc;
	Ptr rgnProc;
	Ptr bitsProc;
	Ptr commentProc;
	Ptr txMeasProc;
	Ptr getPicProc;
	Ptr putPicProc;
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
	Style txFace;			/* txFace is unpacked byte, but push as short */
	char filler;
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
	short face;				/* face = Style (char); on stack as short */
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



/* Define __ALLNU__ to include routines for Macintosh SE or II. */
#ifdef __ALLNU__		


#define invalColReq		-1			/* invalid color table request */

/* VALUES FOR GDType */

#define clutType		0				/*  0 if lookup table */
#define fixedType		1				/*  1 if fixed table */
#define directType		2				/*  2 if direct values */

/*  BIT ASSIGNMENTS FOR GDFlags */

#define gdDevType		0				/* 0 = monochrome; 1 = color */
#define ramInit			10				/* 1 if initialized from 'scrn' resource */
#define mainScrn		11				/* 1 if main screen */
#define allInit			12				/* 1 if all devices initialized */
#define screenDevice	13				/* 1 if screen device [not used] */
#define noDriver		14				/* 1 if no driver for this GDevice */
#define scrnActive		15				/* 1 if in use */

#define hiliteBit		7				/* flag bit in HiliteMode (lowMem flag) */

#define defQDColors     127			/* resource ID of clut for default QDColors */


typedef struct RGBColor{
	short			red;				/* magnitude of red component */
	short			green;				/* magnitude of green component */
	short			blue;				/* magnitude of blue component */
} RGBColor;

typedef struct ColorSpec{
	short			value;				/* index or other value */
	RGBColor		rgb;				/* true color */
} ColorSpec;

typedef struct CSpecArray{
	ColorSpec		ctTable[1];			/* array [0..0] of ColorSpec */
} CSpecArray;

typedef struct ColorTable{
	long			ctSeed;				/* unique identifier for table */
	short			transIndex;			/* index of transparent pixel */
	short			ctSize;				/* number of entries in CTTable */
	CSpecArray		ctTable;			/* array [0..0] of ColorSpec */
} ColorTable, *CTabPtr, **CTabHandle;

typedef struct PixMap{
	Ptr				baseAddr;			/* pointer to pixels */
	short			rowBytes;			/* offset to next line */
	Rect			bounds;				/* encloses bitmap */
	short			pmVersion;			/* pixMap version number */
	short			packType;			/* defines packing format */
	long			packSize;			/* length of pixel data */
	Fixed			hRes;				/* horiz. resolution (ppi) */
	Fixed			vRes;				/* vert. resolution (ppi) */
	short			pixelType;			/* defines pixel type */
	short			pixelSize;			/* # bits in pixel */
	short			cmpCount;			/* # components in pixel */
	short			cmpSize;			/* # bits per component */
	long			planeBytes;			/* offset to next plane */
	CTabHandle		pmTable;			/* color map for this pixMap */
	long			pmReserved;			/* for future use. MUST BE 0 */
} PixMap, *PixMapPtr, **PixMapHandle;

typedef struct PatXMap{
	short			patXRow;			/* rowbytes of expanded pattern */
	short			patXHMask;			/* horizontal mask */
	short			patXVMask;			/* vertical mask */
	long			lastCTable;			/* seed value for last color table */
	short			lastOfst;			/* last global-local offset */
	long			lastInvert;			/* last invert value */
	long			lastAlign;			/* last horizontal align */
	short			lastStretch;		/* last stretch */
} PatXMap, *PatXMapPtr, **PatXMapHandle;

typedef struct PixPat{
	short			patType;			/* type of pattern */
	PixMapHandle	patMap;				/* the pattern's pixMap */
	Handle			patData;			/* pixmap's data */
	Handle			patXData;			/* expanded pattern data */
	short			patXValid;			/* [word] flags whether expanded pattern valid */
	PatXMapHandle	patXMap;			/* [long] handle to expanded pattern data */
	Pattern			pat1Data;			/* old-style pattern/RGB color */
} PixPat, *PixPatPtr, **PixPatHandle;

typedef struct CCrsr{
	short			crsrType;			/* type of cursor */
	PixMapHandle	crsrMap; 			/* the cursor's pixmap */
	Handle			crsrData;			/* cursor's data */
	Handle			crsrXData;			/* expanded cursor data */
	short			crsrXValid;			/* depth of expanded data (0 if none) */
	Handle			crsrXHandle;		/* future use */
	Bits16			crsr1Data;			/* one-bit cursor */
	Bits16			crsrMask;			/* cursor's mask */
	Point			crsrHotSpot;		/* cursor's hotspot */
	long			crsrXTable;			/* private */
	long			crsrID;				/* private */
} CCrsr, *CCrsrPtr, **CCrsrHandle;

typedef struct CIcon{
	PixMap			iconPMap;			/* the icon's pixMap */
	BitMap			iconMask;			/* the icon's mask */
	BitMap			iconBMap;			/* the icon's bitMap */
	Handle			iconData;			/* the icon's data */
	short			iconMaskData[1];	/* icon's mask and bitmap data */
} CIcon, *CIconPtr, **CIconHandle;

typedef struct GammaTbl{
	short			gVersion;			/* gamma version number	 */		
	short			gType;				/* gamma data type */
	short			gFormulaSize;		/* Formula data size */
	short			gChanCnt;			/* number of channels of data */
	short			gDataCnt;			/* number of values/channel */
	short			gDataWidth;			/* bits/corrected value (data packed to next larger byte size) */
	short			gFormulaData[1];	/* data for formulas, followed by gamma values */
} GammaTbl, *GammaTblPtr, **GammaTblHandle;

typedef struct ITab{
	long			iTabSeed;			/* copy of CTSeed from source CTable */
	short			iTabRes;			/* bits/channel resolution of iTable */
	unsigned char	iTTable[1];			/* byte colortable index values */
} ITab, *ITabPtr, **ITabHandle;

typedef struct GDevice{
	short			gdRefNum;			/* driver's unit number */
	short			gdID;				/* client ID for search procs */
	short			gdType;				/* fixed/CLUT/direct */
	ITabHandle		gdITable; 			/* handle to inverse lookup table */
	short			gdResPref;   		/* preferred resolution of GDITable */
	ProcPtr			gdSearchProc;		/* search proc list head */
	ProcPtr			gdCompProc;			/* complement proc list */
	short			gdFlags;			/* grafDevice flags word */
	PixMapHandle	gdPMap;				/* describing pixMap */
	long			gdRefCon;			/* reference value */
	Handle			gdNextGD;	/*GDHandle*/	/* handle of next gDevice */
	Rect			gdRect;				/*device's bounds in global coordinates */
	long			gdMode;				/* device's current mode */
	short			gdCCBytes;			/* depth of expanded cursor data */
	short			gdCCDepth;			/* depth of expanded cursor data */
	Handle			gdCCXData;			/*handle to cursor's expanded data */
	Handle			gdCCXMask;			/* handle to cursor's expanded mask */
	long			gdReserved;			/* future use. MUST BE 0 */
} GDevice, *GDPtr, **GDHandle;

typedef struct CGrafPort{
	short			device;
	PixMapHandle	portPixMap;			/* port's pixel map */
	short			portVersion;		/* high 2 bits always set */
	Handle			grafVars;			/* handle to more fields */
	short			chExtra;			/* character extra */
	short			pnLocHFrac;			/* pen fraction */
	Rect			portRect;
	RgnHandle		visRgn;
	RgnHandle		clipRgn;
	PixPatHandle	bkPixPat;			/* background pattern */
	RGBColor		rgbFgColor;			/* RGB components of fg */
	RGBColor		rgbBkColor;			/* RGB components of bk */
	Point			pnLoc;
	Point			pnSize;
	short			pnMode;
	PixPatHandle	pnPixPat;			/* pen's pattern */
	PixPatHandle	fillPixPat;			/* fill pattern */
	short			pnVis;
	short			txFont;
	Style			txFace;		/* txFace is unpacked byte, push as short */
	char			filler;
	short			txMode;
	short			txSize;
	Fixed			spExtra;
	long			fgColor;
	long			bkColor;
	short			colrBit;
	short			patStretch;
	QDHandle		picSave;
	QDHandle		rgnSave;
	QDHandle		polySave;
	QDProcsPtr		grafProcs;
} CGrafPort, *CGrafPtr;

typedef struct GrafVars{
	RGBColor		rgbOpColor; 		/* color for addPin, subPin and average */
	RGBColor		rgbHiliteColor; 	/* color for hiliting */
	Handle			pmFgColor; 			/* palette handle for foreground color */
	short			pmFgIndex; 			/* index value for foreground */
	Handle			pmBkColor;			/* palette handle for background color */
	short			pmBkIndex;			/* index value for background */
	short			pmFlags;			/* flags for Palette Manager */
} GrafVars;


typedef struct SProcRec{
	Handle			nxtSrch;	/*SProcHndl*/		/* handle to next SProcRec */
	ProcPtr			srchProc;			/* pointer to search procedure */
} SProcRec, *SProcPtr, **SProcHndl;

typedef struct CProcRec{
	Handle			nxtComp;	/*CProcHndl*/		/* handle to next CProcRec */
	ProcPtr			compProc;			/* pointer to complement procedure */
} CProcRec, *CProcPtr, **CProcHndl;

typedef struct CQDProcs {
	Ptr				textProc;
	Ptr				lineProc;
	Ptr				rectProc;
	Ptr				rRectProc;
	Ptr				ovalProc;
	Ptr				arcProc;
	Ptr				polyProc;
	Ptr				rgnProc;
	Ptr				bitsProc;
	Ptr				commentProc;
	Ptr				txMeasProc;
	Ptr				getPicProc;
	Ptr				putPicProc;
	Ptr				opcodeProc;			/* fields added to QDProcs */
	Ptr				newProc1;
	Ptr				newProc2;
	Ptr				newProc3;
	Ptr				newProc4;
	Ptr				newProc5;
	Ptr				newProc6;
} CQDProcs,*CQDProcsPtr;

typedef short QDErr;

typedef struct ReqListRec{				/* request List structure */
	short			reqLSize;			/* request list size */
	short			reqLData[1];		/* request list data */
} ReqListRec;


			/* Routines for Manipulating the CGrafport */
				  
pascal void OpenCPort(port)
	CGrafPtr port;
	extern 0xAA00;
pascal void InitCPort(port)
	CGrafPtr port;
	extern 0xAA01;
pascal void CloseCPort(port)
	CGrafPtr port;
	extern 0xAA02;

			/* Routines for Manipulating PixMaps */
				
pascal PixMapHandle NewPixMap()
	extern 0xAA03;
pascal void DisposPixMap(pm)
	PixMapHandle pm;
	extern 0xAA04;
pascal void CopyPixMap(srcPM, dstPM)
	PixMapHandle srcPM, dstPM;
	extern 0xAA05;
pascal void SetCPortPix(pm)
	PixMapHandle pm;
	extern 0xAA06;

			/* Routines for Manipulating PixPats */

pascal PixPatHandle NewPixPat()
	extern 0xAA07;
pascal void DisposPixPat(pp)
	PixPatHandle pp;
	extern 0xAA08;
pascal void CopyPixPat(srcPP, dstPP)
	PixPatHandle srcPP, dstPP;
	extern 0xAA09;
pascal void PenPixPat(pp)
	PixPatHandle pp;
	extern 0xAA0A;
pascal void BackPixPat(pp)
	PixPatHandle pp;
	extern 0xAA0B;
pascal PixPatHandle GetPixPat(patID)
	short patID;
	extern 0xAA0C;
pascal void MakeRGBPat(pp, myColor)
	PixPatHandle pp;
	RGBColor *myColor;
	extern 0xAA0D;

pascal void FillCRect(r, pp)
	Rect *r;
	PixPatHandle pp;
	extern 0xAA0E;
pascal void FillCOval(r, pp)
	Rect *r;
	PixPatHandle pp;
	extern 0xAA0F;
pascal void FillCRoundRect(r, ovWd, ovHt, pp)
	Rect *r;
	short ovWd, ovHt;
	PixPatHandle pp;
	extern 0xAA10;
pascal void FillCArc(r, startAngle, arcAngle, pp)
	Rect *r;
	short startAngle, arcAngle;
	PixPatHandle pp;
	extern 0xAA11;
pascal void FillCRgn(rgn, pp)
	RgnHandle rgn;
	PixPatHandle pp;
	extern 0xAA12;
pascal void FillCPoly(poly, pp)
	PolyHandle poly;
	PixPatHandle pp;
	extern 0xAA13;

pascal void RGBForeColor(color)
	RGBColor *color;
	extern 0xAA14;
pascal void RGBBackColor(color)
	RGBColor *color;
	extern 0xAA15;
pascal void SetCPixel(h, v, cPix)
	short h, v;
	ColorSpec *cPix;
	extern 0xAA16;
pascal ColorSpec GetCPixel(h, v)
	short h, v;
	extern 0xAA17;
pascal void GetForeColor(color)
	RGBColor *color;
	extern 0xAA19;
pascal void GetBackColor(color)
	RGBColor *color;
	extern 0xAA1A;

			/* Transfer Mode Utilities	*/

pascal void OpColor(color)
	RGBColor color;
	extern 0xAA21;
pascal void HiliteColor(color)
	RGBColor color;
	extern 0xAA22;

			/* Color Table Handling Routines */

pascal void DisposCTable(cTable)
	CTabHandle cTable;
	extern 0xAA24;
pascal CTabHandle GetCTable(ctID)
	short ctID;
	extern 0xAA18;

			/* Color Cursor Handling Routines */

pascal CCrsrHandle GetCCursor(crsrID)
	short crsrID;
	extern 0xAA1B;
pascal void SetCCursor(cCrsr)
	CCrsrHandle cCrsr;
	extern 0xAA1C;
pascal void AllocCursor()
	extern 0xAA1D;
pascal void DisposCCursor(cCrsr)
	CCrsrHandle cCrsr;
	extern 0xAA26;

			/* Icon Handling Routines */

pascal CIconHandle GetCIcon(iconID)
	short iconID;
	extern 0xAA1E;
pascal void PlotCIcon(theRect, theIcon)
	Rect *theRect;
	CIconHandle theIcon;
	extern 0xAA1F;
pascal void DisposCIcon(theIcon)
	CIconHandle theIcon;
	extern 0xAA25;
	
			/* PixMap Handling Routines */

pascal void CopyPix(srcPix, dstPix, srcRect, dstRect, mode, maskRgn)
	PixMap *srcPix, *dstPix;
	Rect *srcRect, *dstRect;
	short mode;
	RgnHandle maskRgn;
	extern 0xA8EC;
pascal void CopyCMask(srcPix, maskBits, dstPix, srcRect, maskRect, dstRect)
	PixMap *srcPix;
	BitMap *maskBits;
	PixMap *dstPix;
	Rect *srcRect, *maskRect, *dstRect;
	extern 0xA817;

			/* Picture Routines */

pascal PicHandle OpenCPicture(picFrame)
	Rect picFrame;
	extern 0xAA20;

			/* Text Routines */

pascal void CharExtra(extra)
	Fixed extra;
	extern 0xAA23;

			/* GDevice Routines */

pascal GDHandle GetMaxDevice(globalRect)
	Rect *globalRect;
	extern 0xAA27;
pascal long GetCTSeed()
	extern 0xAA28;
pascal GDHandle GetDeviceList()
	extern 0xAA29;
pascal GDHandle GetMainDevice()
	extern 0xAA2A;
pascal GDHandle GetNextDevice(curDevice)
	GDHandle curDevice;
	extern 0xAA2B;
pascal Boolean TestDeviceAttribute(gdh, attribute)
	GDHandle gdh;
	short attribute;
	extern 0xAA2C;
pascal void SetDeviceAttribute(gdh, attribute, value)
	GDHandle gdh;
	short attribute;
	Boolean value;
	extern 0xAA2D;
pascal void InitGDevice(unitNum, mode, gdh)
	short unitNum;
	long mode;
	GDHandle gdh;
	extern 0xAA2E;
pascal GDHandle NewGDevice(unitNum, mode)
	short unitNum;
	long mode;
	extern 0xAA2F;
pascal void DisposGDevice(gdH)
	GDHandle gdH;
	extern 0xAA30;
pascal void SetGDevice(gd)
	GDHandle gd;
	extern 0xAA31;
pascal GDHandle GetGDevice()
	extern 0xAA32;

			/* Color Manager Interface */

pascal long Color2Index(myColor)
	RGBColor *myColor;
	extern 0xAA33;
pascal void Index2Color(index, aColor)
	long index;
	RGBColor *aColor;
	extern 0xAA34;
pascal void InvertColor(myColor)
	RGBColor *myColor;
	extern 0xAA35;
pascal Boolean RealColor(color)
	RGBColor *color;
	extern 0xAA36;
pascal void GetSubTable(myColors, iTabRes, targetTbl)
	CTabHandle *myColors;
	short iTabRes;
	CTabHandle targetTbl;
	extern 0xAA37;
pascal void MakeITable(cTabH, iTabH, res)
	CTabHandle cTabH;
	ITabHandle iTabH;
	short res;
	extern 0xAA39;
pascal void AddSearch(searchProc)
	ProcPtr searchProc;
	extern 0xAA3A;
pascal void AddComp(compProc)
	ProcPtr compProc;
	extern 0xAA3B;
pascal void DelSearch(searchProc)
	ProcPtr searchProc;
	extern 0xAA4C;
pascal void DelComp(compProc)
	ProcPtr compProc;
	extern 0xAA4D;
pascal void SetClientID(id)
	short id;
	extern 0xAA3C;
pascal void ProtectEntry(index, protect)
	short index;
	Boolean protect;
	extern 0xAA3D;
pascal void ReserveEntry(index, reserve)
	short index;
	Boolean reserve;
	extern 0xAA3E;
pascal void SetEntries(start, count, aTable)
	short start;
	short count;
	CSpecArray aTable;
	extern 0xAA3F;
pascal void SaveEntries(srcTable, resultTable, selection)
	CTabHandle srcTable;
	CTabHandle resultTable;
	ReqListRec *selection;
	extern 0xAA49;
pascal void RestoreEntries(srcTable, dstTable, selection)
	CTabHandle srcTable;
	CTabHandle dstTable;
	ReqListRec *selection;
	extern 0xAA4A;
pascal short QDError()
	extern 0xAA40;


#endif					/* __ALLNU__ */
#endif					/* __QUICKDRAW__ */

